//
//  FacebookDetailViewController.h
//  FaceBookSDK
//
//  Created by Ankit Teotia on 20/12/16.
//  Copyright © 2016 Ankit Teotia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FacebookDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

- (IBAction)logoutButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *profileNameText;

@property (weak, nonatomic) IBOutlet UITextField *profileCompanyText;

@property (weak, nonatomic) IBOutlet UITextField *profileDesignationText;

@property (weak, nonatomic) IBOutlet UITextField *profileLocationText;

- (IBAction)submitButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *save;

@property (weak, nonatomic) IBOutlet UIButton *logOut;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@end
