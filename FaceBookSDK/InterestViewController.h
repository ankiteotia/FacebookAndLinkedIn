//
//  InterestViewController.h
//  FaceBookSDK
//
//  Created by 10times on 21/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterestViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *interestTableView;

- (IBAction)doneButtonPressed:(id)sender;

@property (nonatomic,strong) NSArray  *json;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@end
