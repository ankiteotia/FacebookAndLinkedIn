//
//  DetailViewController.m
//  CustomCell
//
//  Created by 10times on 23/12/16.
//  Copyright © 2016 10times. All rights reserved.
//

#import "DetailViewController.h"
#import "EventViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
{

    UIViewController *fetchData;
    NSString *details;
}

@synthesize description;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *localizedSignUpString = NSLocalizedString(@"Event Detail", @"");
    self.navigationItem.title = localizedSignUpString;
    
    fetchData = [[UIViewController alloc] init];
    
    details = [[NSUserDefaults standardUserDefaults] objectForKey:@"eventDescription"];
    
    [self descriptionMethod];
    
}


-(void)descriptionMethod{
    
    
    NSString *fetchEventDescription = details;
    
    self.description.text = fetchEventDescription;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
