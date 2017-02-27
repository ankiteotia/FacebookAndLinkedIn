//
//  ViewController.h
//  CustomCell
//
//  Created by 10times on 21/12/16.
//  Copyright © 2016 10times. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "DetailViewController.h"
#import <EventKitUI/EventKitUI.h>

#define ALERT_Reminder 0

@interface EventViewController : UIViewController
{
    int selectedIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (weak, nonatomic) IBOutlet UILabel *eventSlider;

- (IBAction)upcomingButton:(id)sender;
- (IBAction)nearbyButton:(id)sender;
- (IBAction)trendingButton:(id)sender;

- (IBAction)searchButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;


@end
