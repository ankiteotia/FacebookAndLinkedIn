//
//  ViewController.m
//  FaceBookSDK
//
//  Created by Ankit Teotia on 19/12/16.
//  Copyright © 2016 Ankit Teotia. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <Social/Social.h>
#import "FacebookDetailViewController.h"
#import "EventViewController.h"
#import "LinkedInOAuthViewController.h"
#import "LinkedInConnector.h"
#import "UserDetailViewController.h"
#import "LoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSDictionary *jsonData;
    NSDictionary *dict;
    NSArray *list;
    NSUserDefaults * userData;
    NSString *localizedLoadingString;
    LinkedInConnector *fetchData;

    UserDetailViewController *uData;
    
}
@synthesize accessToken;


- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.navigationItem.hidesBackButton = YES;
    
    uData = [[UserDetailViewController alloc] init];
    
      fetchData.delegate = self;
    
    self.signIn.layer.cornerRadius = 30.0;
    self.signIn.clipsToBounds = YES;
    
    self.signUp.layer.cornerRadius = 30.0;
    self.signUp.clipsToBounds = YES;
    
}

- (IBAction)facebookLogin:(id)sender {
    
    localizedLoadingString = NSLocalizedString(@"loading", @"");
    
    [SVProgressHUD showWithStatus:localizedLoadingString maskType:SVProgressHUDMaskTypeBlack];
    
    self.accountStore = [[ACAccountStore alloc] init];
    
    ACAccountType *fbAccountType = [self.accountStore
                                    accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    NSDictionary *options = @{
                              @"ACFacebookAppIdKey" : @"373226943060264",
                              @"ACFacebookPermissionsKey" : @[@"email"],
                              @"ACFacebookAudienceKey" : ACFacebookAudienceEveryone};

    [self.accountStore requestAccessToAccountsWithType:fbAccountType options:options completion:^(BOOL granted, NSError *error)
     {
         if (granted) {
             
             NSArray *accounts = [self.accountStore accountsWithAccountType:fbAccountType];
             self.fbAccount = [accounts lastObject];

             [SVProgressHUD dismiss];
             [self performSelectorInBackground:@selector(getUserFbData) withObject:Nil];
         } else {
             
             if ([error code]==6) {
                 [self performSelectorOnMainThread:@selector(showAlertForPermission) withObject:Nil waitUntilDone:YES];
             }
             if ([error code]==0) {
                 [self performSelectorOnMainThread:@selector(showAlertForPermission) withObject:Nil waitUntilDone:YES];
             }
             [SVProgressHUD dismiss];
         }
         
     }];
    
}

-(void)showAlertForPermission
{
    [SVProgressHUD dismiss];
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    login.loginBehavior = FBSDKLoginBehaviorNative;
    
    [login logInWithReadPermissions:@[@"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            
        } else if (result.isCancelled) {
            
        } else {
            if ([result.grantedPermissions containsObject:@"email"]) {
                
                NSLog(@"%@",result.token);
                [self performSelector:@selector(fetchUserInfo) withObject:nil afterDelay:0.1];
                
            }
        }
    }];
}

-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, first_name, last_name, picture.type(large), email,location,work"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             
             if (!error)
             {
                 list = result;
                 
                 uData.eName = [list valueForKey:@"name"];
                 uData.eEmail = [list valueForKey:@"email"];
                 uData.eImageURL = [[[list valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                 
                 uData.eURL = [NSURL URLWithString:uData.eImageURL];
                 uData.eImageData = [NSData dataWithContentsOfURL:uData.eURL];
                    
                 [[NSUserDefaults standardUserDefaults] setObject:uData.eName forKey:@"userName"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [[NSUserDefaults standardUserDefaults] setObject:uData.eEmail forKey:@"userEmail"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
        [[NSUserDefaults standardUserDefaults] setObject:uData.eImageData forKey:@"userPicture"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
    }
    
    [self getUserFbData];
}

-(void)getUserFbData
{
    localizedLoadingString = NSLocalizedString(@"loading", @"");
    
    [SVProgressHUD showWithStatus:localizedLoadingString maskType:SVProgressHUDMaskTypeBlack];
    
    SLRequest *objSLRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://graph.facebook.com/me"] parameters:Nil];
    objSLRequest.account = self.fbAccount;
    
    [objSLRequest performRequestWithHandler:^(NSData *data,NSHTTPURLResponse *response,NSError *error) {
        if(!error)
        {
            NSMutableDictionary* userlist =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            @try {
                
                UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                
                EventViewController *obj = [storyBoard instantiateViewControllerWithIdentifier:@"EventViewController"];
                
                [self.navigationController pushViewController:obj animated:NO];
                
            }
            @catch (NSException *exception) {
                NSLog(@"Exception %@",exception);
            }
        }
        else
        {
            
            NSLog(@"error aa gyi h..");
        }
    }];
    
}


- (IBAction)linkedInLogin:(id)sender {
    
    [LISDKSessionManager createSessionWithAuth:[NSArray arrayWithObjects:LISDK_BASIC_PROFILE_PERMISSION,LISDK_EMAILADDRESS_PERMISSION, nil] state:nil showGoToAppStoreDialog:YES successBlock:^(NSString *data) {
        
        LISDKSession *session = [[LISDKSessionManager sharedInstance] session];
        NSLog(@"%@----%@",data,session);
        
        NSString *url = @"https://api.linkedin.com/v1/people/~:(id,first-name,last-name,email-address,picture-url,skills,summary,positions:(title,company:(name)),)";
        
        [[LISDKAPIHelper sharedInstance] getRequest:url success:^(LISDKAPIResponse * responce) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *jsonString = responce.data;
                
                NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
                
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                dictLinkedInData = [json mutableCopy];
                
            });
            
        } error:^(LISDKAPIError *error) {
            NSLog(@"%@",error);
        }];
        
    } errorBlock:^(NSError *err) {
        
        LinkedInOAuthViewController *oAuthVC = [[LinkedInOAuthViewController alloc]initWith_ApiKey:@"81l6ju0cllclm4" SecretKey:@"TTVepg3pPboOk3N6" permissions:nil];
        oAuthVC.delegate = self;
        [self presentViewController:oAuthVC animated:YES completion:nil];
        
    }];
    
}

#pragma mark - LinkedOAuthViewController Delegate
-(void)accessTokenReceived:(NSString *)linkeInAccessToken secondsRemainingBeforeExpiry:(NSInteger)secondsRemainingBeforeExpiry error:(NSError *)error
{
    if (error==nil) {
        
        self.objLinkedInConnector = [[LinkedInConnector alloc]initWithAccessToken:linkeInAccessToken];
        
        self.objLinkedInConnector.delegate = self;
        [self.objLinkedInConnector getUserData];
        
    }
    
    else
    {
        UIAlertView *av =[ [UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"Error Code %ld",(long)error.code] message:[error.userInfo valueForKey:NSLocalizedDescriptionKey] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [av show];
    }
}

-(id)initWithAccessToken:(NSString *)accessToken{
    
    self = [super init];
    
    return self;

}

#pragma mark - LinkedInConnector Delegate
-(void)UserDataReceived:(NSDictionary *)data
{
    [SVProgressHUD showWithStatus:localizedLoadingString maskType:SVProgressHUDMaskTypeBlack];

    dictLinkedInData = [data mutableCopy];
   
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    EventViewController *obj = [storyBoard instantiateViewControllerWithIdentifier:@"EventViewController"];
    
    [self.navigationController pushViewController:obj animated:NO];
}
- (IBAction)signInBtn:(id)sender {
    
    LoginViewController *loginObj = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    [self.navigationController pushViewController:loginObj animated:NO];

}
- (IBAction)signUpBtn:(id)sender {
    
    LoginViewController *signUpObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    
    [self.navigationController pushViewController:signUpObj animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
