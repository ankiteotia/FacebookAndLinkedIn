//
//  ViewController.m
//  CustomCell
//
//  Created by 10times on 21/12/16.
//  Copyright © 2016 10times. All rights reserved.
//

#import "EventViewController.h"
#import "CustomCellTableViewCell.h"
#import "DetailViewController.h"
#import <EventKitUI/EventKitUI.h>
#import "NewRearViewController.h"
#import "SWRevealViewController.h"
#import "CustomCellTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface EventViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation EventViewController
{
    
    NSString *detail;
    NSString *dateDetail;
    NSString *dateEndDetail;
    NSString *nameDetail;
    
    NSArray *jsonData;
    NSDictionary *json;
    
    NSArray *fetchName;
    NSArray *fetchCity;
    NSArray *fetchDate;
    NSString *fetchEventID;
    NSArray *fetchImage;
    
    UITableViewCell *selectedEventDate;
    UITableViewCell *selectedEventEndDate;
    UITableViewCell *selectedEventName;
    
    NSString *fetchURL;
    
    NSString *dict;
    
    int eventCount;    
    UITableViewCell *selectedCell;
    
    UIBarButtonItem *revealButtonItem;
    
    CustomCellTableViewCell *customCell;

}

#define kTimeOutInterval @"30"

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self incomingData];

    self.navigationItem.hidesBackButton = YES;
   
    self.userTableView.delegate = self;
    self.userTableView.dataSource = self;

    selectedIndex = -1;
    
    NSString *localizedLoadingString = NSLocalizedString(@"loading", @"");
    
    [SVProgressHUD showWithStatus:localizedLoadingString maskType:SVProgressHUDMaskTypeBlack];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.eventSlider setHidden:NO];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"nibCell"];
    
    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"CustomCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"nibCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"nibCell"];
        
    }
    
    fetchName = [json valueForKey:@"name"];
    fetchCity = [json valueForKey:@"city"];
    fetchDate = [json valueForKey:@"startDate"];
    fetchImage = [json valueForKey:@"event_samll_wrapper"];
    
    
    [cell.layer setCornerRadius:8.0f];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setBorderWidth:3.0f];
    
    [cell.attendButton setTag:indexPath.row];
    [cell.followButton setTag:indexPath.row];
    [cell.reminderButton setTag:indexPath.row];
    [cell.visitorButton setTag:indexPath.row];


    return cell;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"More" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){

//            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
            selectedCell = [tableView cellForRowAtIndexPath:indexPath];
            selectedCell = [[json valueForKey:@"des"] objectAtIndex:indexPath.row ];
        
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:selectedCell forKey:@"eventDescription"];
            [defaults synchronize];
        
            DetailViewController *dVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
        
            [self.navigationController pushViewController:dVC animated:YES];
    
    }];
    
    editAction.backgroundColor = [UIColor orangeColor];

    return @[editAction];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (selectedIndex == indexPath.row) {
        
        return 206;
    }
    
    else {
        
        customCell = [[CustomCellTableViewCell alloc] init];
        customCell.attendButton.hidden = YES;
        return 115;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(CustomCellTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    NSString *imageURL = fetchImage[indexPath.row];

//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]
//                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

        cell.eventLabel.text = fetchName[indexPath.row];
        cell.dateLabel.text = fetchDate[indexPath.row];
        cell.locationLabel.text = fetchCity[indexPath.row];
   
    [SVProgressHUD dismiss];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (selectedIndex == indexPath.row) {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        return;
    }
    
    if (selectedIndex != -1) {
        NSIndexPath *prevPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:prevPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return eventCount;
}

-(void)incomingData{
    
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
                
                // Reminder
                
                NSArray *nameArray = [json valueForKey:@"name"];
                NSArray *startDateArray = [json valueForKey:@"startDate"];
                NSArray *endDateArray = [json valueForKey:@"endDate"];
                
                NSUserDefaults *jsonName = [NSUserDefaults standardUserDefaults];
                [jsonName setObject:nameArray forKey:@"JSONname"];
                [jsonName synchronize];
                
                NSUserDefaults *jsonDate = [NSUserDefaults standardUserDefaults];
                [jsonDate setObject:startDateArray forKey:@"JSONdate"];
                [jsonDate synchronize];
                
                NSUserDefaults *jsonEndDate = [NSUserDefaults standardUserDefaults];
                [jsonEndDate setObject:endDateArray forKey:@"JSONendDate"];
                [jsonEndDate synchronize];
                
                // Reminder

                dict = [json valueForKey:@"name"];
                
                eventCount = (unsigned long)json.count;
                
                [self.userTableView reloadData];
            }
        }];
        
        [task resume];
    }
}

- (IBAction)upcomingButton:(id)sender {
    
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
     {
         self.eventSlider.center = CGPointMake(55, 528);
     } completion:nil];
}

- (IBAction)nearbyButton:(id)sender {
    
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^
     {
         self.eventSlider.center = CGPointMake(160, 528);
     } completion:nil];
}

- (IBAction)trendingButton:(id)sender {
    
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         self.eventSlider.center = CGPointMake(265, 528);
     } completion:nil];
    
}

- (IBAction)searchButton:(id)sender {
    
    NSLog(@"Search has been started..!");
    
//    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0,0, 250,44)];
//    searchBar.placeholder = @"Search";
//    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc]initWithCustomView:searchBar];
//    searchBarItem.tag = 123;
//    searchBarItem.customView.hidden = YES;
//    searchBarItem.customView.alpha = 0.0f;
//    self.navigationItem.leftBarButtonItem = searchBarItem;
//    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(whenSearchClicked:)];
//    self.navigationItem.rightBarButtonItem = leftItem;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

//- (void)whenSearchClicked:(id)sender
//{
//    NSArray *buttonsArray = self.navigationController.navigationBar.topItem.leftBarButtonItems;
//    for(UIBarButtonItem *item in buttonsArray)
//    {
//        if(item.tag == 123 && item.customView.hidden)
//        {
//            item.customView.hidden = NO;
//            if([item.customView isKindOfClass:[UISearchBar class]])
//                [item.customView becomeFirstResponder];
//            UIBarButtonItem *rightItem = self.navigationController.navigationBar.topItem.rightBarButtonItem;
//            [rightItem setTitle:@"Cancel"];
//        }
//        else
//        {
//            item.customView.hidden = YES;
//            if([item.customView isKindOfClass:[UISearchBar class]])
//                [item.customView resignFirstResponder];
//            UIBarButtonItem *rightItem = self.navigationController.navigationBar.topItem.rightBarButtonItem;
//            [rightItem setTitle:@"Search"];
//            
//        }
//    }
//    
//}


@end
