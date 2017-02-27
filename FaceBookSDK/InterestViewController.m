//
//  InterestViewController.m
//  FaceBookSDK
//
//  Created by 10times on 21/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import "InterestViewController.h"
#import "EventViewController.h"
#import "SWRevealViewController.h"

@interface InterestViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation InterestViewController
{

    int eventCount;
    NSString *dict;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interestTableView.delegate = self;
    self.interestTableView.dataSource = self;
    
    [self interestDetail];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [SVProgressHUD showWithStatus:@"loading" maskType:SVProgressHUDMaskTypeBlack];
    
}

-(void)interestDetail{
    
    NSURL *url = [NSURL URLWithString:@"http://serve.10times.com/index.php/autosuggest?for=industry"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:15.0];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    request.HTTPMethod = @"GET";
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSError *error = nil;
    
    if (!error) {
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (!error) {
                
                self.json = [NSJSONSerialization JSONObjectWithData:data
                                                            options:kNilOptions
                                                              error:&error];
                
                eventCount = (unsigned long)self.json.count;
                
                [self.interestTableView reloadData];
            }
        }];
        
        [task resume];
    }

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"interest";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *intDetails = [[self.json valueForKey:@"name" ] objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
    }
    
    cell.textLabel.text = intDetails;
    cell.textLabel.textColor = [UIColor orangeColor];
    
    [SVProgressHUD dismiss];
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return eventCount;
    
}

- (IBAction)doneButtonPressed:(id)sender {

    EventViewController *home = [self.storyboard instantiateViewControllerWithIdentifier:@"EventViewController"];
    
    [self.navigationController pushViewController:home animated:NO];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
