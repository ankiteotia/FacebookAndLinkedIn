//
//  NewRearViewController.h
//  FaceBookSDK
//
//  Created by 10times on 18/01/17.
//  Copyright © 2016 10times. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface NewRearViewController : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>
{
    
    
}
@property(nonatomic, assign)BOOL isDonePressed;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UIImageView *timelinePhoto;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *homebutton;
@property (weak, nonatomic) IBOutlet UIButton *notificationButton;
@property (weak, nonatomic) IBOutlet UIButton *shareInviteButton;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIButton *goToButton;

@property (weak, nonatomic) IBOutlet UIButton *interest;
- (IBAction)interestButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *goToEventText;

- (IBAction)goToEventButton:(id)sender;
- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)notificationButtonPressed:(id)sender;
- (IBAction)shareInviteButtonPressed:(id)sender;
- (IBAction)settingButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *aboutUs;
@property (weak, nonatomic) IBOutlet UIButton *feedback;

@property (weak, nonatomic) IBOutlet UIButton *userProfile;

- (IBAction)aboutUsButton:(id)sender;
- (IBAction)feedbackButton:(id)sender;

@end
