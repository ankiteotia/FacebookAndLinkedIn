//
//  VisitorViewController.m
//  FaceBookSDK
//
//  Created by 10times on 28/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import "VisitorViewController.h"
#import "VisitorTableViewCell.h"
#import "SVProgressHUD.h"
#import "CustomCellTableViewCell.h"

@interface VisitorViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation VisitorViewController
{
    NSDictionary *json;
    NSString *dict;
    int visitorCount;
    NSArray *fetchVisitorName;
    NSArray *fetchVisitorCompany;
    NSArray *fetchVisitorLocation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.visitorTableView.delegate = self;
    self.visitorTableView.dataSource =self;
    
    [self visitorData];
    
    [SVProgressHUD showWithStatus:@"loading" maskType:SVProgressHUDMaskTypeBlack];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
 VisitorTableViewCell * cell = (id)[tableView dequeueReusableCellWithIdentifier:@"nibCell"];
    
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"VisitorTableViewCell" bundle:nil] forCellReuseIdentifier:@"nibCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"nibCell"];
        
    }
    
    fetchVisitorName = [[json valueForKey:@"visitor_meta"] valueForKey:@"name"];
    
    NSLog(@"%@", fetchVisitorName);
    
    fetchVisitorCompany = [[json valueForKey:@"visitor_meta"] valueForKey:@"user_company"];
    fetchVisitorLocation = [[json valueForKey:@"visitor_meta"] valueForKey:@"city"];
    
    [cell.layer setCornerRadius:8.0f];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setBorderWidth:3.0f];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(VisitorTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.visitorNameLabel.text = fetchVisitorName[indexPath.row];
    cell.visitorPosition.text = fetchVisitorCompany[indexPath.row];
    cell.visitorLocation.text = fetchVisitorLocation[indexPath.row];

    [SVProgressHUD dismiss];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Selected cell");
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(void)visitorData{
    
    NSURL *url = [NSURL URLWithString:@"http://serve.10times.com/index.php/search?type=event"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:15.0];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    request.HTTPMethod = @"GET";
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSError *error = nil;
    
    if (!error) {
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (!error) {
                
                json = [NSJSONSerialization JSONObjectWithData:data
                                                       options:kNilOptions
                                                         error:&error];
                
//                dict = [json valueForKey:@"name"];
                
                visitorCount = (unsigned long)json.count;
                
                [self.visitorTableView reloadData];
            }
        }];
        
        [task resume];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
