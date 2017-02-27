//
//  AboutUsViewController.h
//  FaceBookSDK
//
//  Created by 10times on 23/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *aboutUsTableView;

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

- (IBAction)checkForUpdate:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *aboutUsText;

@property(nonatomic, retain)    NSMutableDictionary *array;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@end
