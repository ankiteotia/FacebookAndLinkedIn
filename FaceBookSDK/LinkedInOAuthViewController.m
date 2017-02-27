//
//  LinkedInOAuthViewController.m
//  LinkedInSampleApp
//
//  Created by 10times on 05/12/16.
//  Copyright © 2016 10times. All rights reserved.
//
#import "LinkedInOAuthViewController.h"
static NSString * const kAccessTokenURLString = @"https://api.linkedin.com/uas/oauth2/accessToken";
static NSString * const kUserLoginURLString = @"https://www.linkedin.com/uas/oauth2/authorization";
static NSString * const kRedirectUrl = @"http://www.ankitchaudhary.com";
static NSString * const kState = @"ankitlinkedin";

@interface LinkedInOAuthViewController ()
@property (nonatomic , strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation LinkedInOAuthViewController
@synthesize ApiKeyApp,SecretKeyApp,linkeInAccessToken,authorizationToken,webView,secondsRemainingBeforeExpiry,activityIndicator,PermissionsArray;

-(id)initWith_ApiKey:(NSString *)ApiKey SecretKey:(NSString *)SecretKey permissions:(NSArray *)permissions
{
    self = [super initWithNibName:nil bundle:nil];
    self.view.backgroundColor = [UIColor grayColor];
    
    
    self.ApiKeyApp = [[NSString alloc] initWithString:ApiKey];
    self.SecretKeyApp = [[NSString alloc] initWithString:SecretKey];
    self.PermissionsArray = [[NSArray alloc]initWithArray:permissions];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    webView.delegate = self;
    
    dataFromServer = [[NSMutableData alloc]init];
    
    activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    activityIndicator.center = self.view.center;
}

-(void)dismissLinkedINVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getAuthorizationCode];
}

-(void)getAuthorizationCode
{
    
    NSString *authorizationURLString;
    
    if (self.PermissionsArray.count>0) {
        
        NSMutableString *permissionString = [[NSMutableString alloc] init];
        
        for (int i=0; i<PermissionsArray.count; i++) {
            [permissionString appendString:[PermissionsArray objectAtIndex:i]];
            
            if (!(PermissionsArray.count==i)) {
                [permissionString appendString:@"%20"];
            }
            
        }
        
        authorizationURLString=[NSString stringWithFormat:@"%@?response_type=code&client_id=%@&state=%@&redirect_uri=%@&scope=%@",kUserLoginURLString,ApiKeyApp,kState,kRedirectUrl,permissionString];
    }
    else
    {
        authorizationURLString = [NSString stringWithFormat:@"%@?response_type=code&client_id=%@&state=%@&redirect_uri=%@",kUserLoginURLString,ApiKeyApp,kState,kRedirectUrl];
    }
  
    NSURL *authorizationURL = [NSURL URLWithString:authorizationURLString];
    
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:authorizationURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    UINavigationBar *navBar = [[UINavigationBar alloc]init];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonTapped)];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        
        webView.frame = CGRectMake(0, 64, self.view.frame.size.width,self.view.frame.size.height- 64);
        
        navBar.frame = CGRectMake(0, 20, self.view.frame.size.width, 44);
        
    }
    else
    {
        webView.frame = CGRectMake(0, 44, self.view.frame.size.width,self.view.frame.size.height- 44);
        
        navBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    }
    
    [navBar pushNavigationItem:self.navigationItem animated:NO];
    [self.view addSubview:navBar];
    
}

-(void)closeButtonTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.view addSubview:activityIndicator];
    [self.activityIndicator setHidden:FALSE];
    [activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator setHidden:TRUE];
    [activityIndicator stopAnimating];
    [self.activityIndicator removeFromSuperview];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = request.URL;
    NSString *urlString = url.absoluteString;
    
    BOOL requestForCallbackURL = ([urlString rangeOfString:[NSString stringWithFormat:@"%@/?", kRedirectUrl]].location != NSNotFound);
    
    if ( requestForCallbackURL )
    {
        BOOL userAllowedAccess = ([urlString rangeOfString:@"error"].location == NSNotFound);
        
        if ( userAllowedAccess )
        {
            
            NSArray *comp1 = [urlString componentsSeparatedByString:@"?"];
            
            NSString *query = [comp1 lastObject];
            
            NSArray *queryElements = [query componentsSeparatedByString:@"&"];
            
            for (NSString *element in queryElements) {
                NSArray *keyVal = [element componentsSeparatedByString:@"="];
                
                if (keyVal.count > 0) {
                    
                    NSString *variableKey = [keyVal objectAtIndex:0];
                    NSString *value = (keyVal.count == 2) ? [keyVal lastObject] : nil;
                    
                    if ([variableKey isEqualToString:@"code"]) {
                        self.authorizationToken = [[NSString alloc]initWithString:value];
                    }
                }
            }
            
            [self accessTokenFromProvider];
        }
        else
        {
            NSMutableDictionary* details = [NSMutableDictionary dictionary];
            
            [details setValue:@"user denied to login for the given permission" forKey:NSLocalizedDescriptionKey];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    }
    
    return YES;
}

-(void)accessTokenFromProvider
{
    NSString *authorizationURLString = [NSString stringWithFormat:@"%@?grant_type=authorization_code&code=%@&redirect_uri=%@&client_id=%@&client_secret=%@",kAccessTokenURLString,self.authorizationToken,kRedirectUrl,ApiKeyApp,SecretKeyApp];
    
    NSURL *authorizationURL = [NSURL URLWithString:authorizationURLString];
        
    NSURLRequest *request = [NSMutableURLRequest requestWithURL:authorizationURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    
    NSURLConnection *urlConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    [urlConnection start];
    
}

#pragma mark : NSURLConnection Delegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [dataFromServer setLength:0];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"ALERT" message:@"Unable to fetch data" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"ok", nil];
    
    [av show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [dataFromServer appendData:data];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   
    NSError *e = nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:dataFromServer options: NSJSONReadingMutableContainers error: &e];
    
    if (!jsonDictionary) {
       
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        
        [details setValue:@"error parsing the json" forKey:NSLocalizedDescriptionKey];
        
        NSError *error = [[NSError alloc]initWithDomain:@"permission denied" code:2 userInfo:details];
        
        [self.delegate accessTokenReceived:nil secondsRemainingBeforeExpiry:120 error:error];
        
    } else {
        
        self.linkeInAccessToken = [jsonDictionary valueForKey:@"access_token"];
        
        [[NSUserDefaults standardUserDefaults] setObject:linkeInAccessToken forKey:@"access_token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.delegate accessTokenReceived:self.linkeInAccessToken secondsRemainingBeforeExpiry:[[jsonDictionary valueForKey:@"expires_in"] integerValue] error:nil];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
