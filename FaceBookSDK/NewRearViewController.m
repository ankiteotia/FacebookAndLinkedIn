//
//  NewRearViewController.m
//  FaceBookSDK
//
//  Created by 10times on 18/01/17.
//  Copyright © 2016 10times. All rights reserved.
//

#import "NewRearViewController.h"
#import <MessageUI/MessageUI.h>
#import "NotificationViewController.h"
#import "SettingViewController.h"
#import "EventViewController.h"
#import "FacebookDetailViewController.h"
#import "InterestViewController.h"
#import "AboutUsViewController.h"


@interface NewRearViewController ()

@end

@implementation NewRearViewController

@synthesize timelinePhoto;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    NSString *localizedHomeString = NSLocalizedString(@"Home", @"");
    self.navigationItem.title = localizedHomeString;
    
    self.homebutton.layer.cornerRadius = 6.0;
    self.homebutton.clipsToBounds = YES;
    
    self.notificationButton.layer.cornerRadius = 6.0;
    self.notificationButton.clipsToBounds = YES;
    
    self.shareInviteButton.layer.cornerRadius = 6.0;
    self.shareInviteButton.clipsToBounds = YES;
    
    self.settingButton.layer.cornerRadius = 6.0;
    self.settingButton.clipsToBounds = YES;
    
    self.goToButton.layer.cornerRadius = 6.0;
    self.goToButton.clipsToBounds = YES;
    
    self.interest.layer.cornerRadius = 6.0;
    self.interest.clipsToBounds = YES;
    
    self.aboutUs.layer.cornerRadius = 6.0;
    self.aboutUs.clipsToBounds = YES;
    
    self.feedback.layer.cornerRadius = 6.0;
    self.feedback.clipsToBounds = YES;
    
        [self linkedInFacebookDetails];
    
}

-(void)linkedInFacebookDetails{
    
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSData *picture = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPicture"];
    
    self.userNameLabel.text = name;

    self.timelinePhoto.image = [UIImage imageWithData:picture];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    effectView.frame = self.timelinePhoto.frame;
    [self.timelinePhoto addSubview:effectView];
    
     [self.userProfile setBackgroundImage:[UIImage imageWithData:picture] forState:UIControlStateNormal];
    
//    [self.userProfile setImage:[UIImage imageWithData:picture] forState:UIControlStateNormal];
    
    self.userProfile.layer.cornerRadius = 55.0;
    self.userProfile.clipsToBounds = YES;

}

-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)viewWillDisappear:(BOOL)animated{
    

}

- (IBAction)goToEventButton:(id)sender {
    
    if ([self.goToEventText.text isEqual:@""]) {
        
        NSString *localizedSignUpString = NSLocalizedString(@"Enter Valid Event Code", @"");
        NSString *localizedOkString = NSLocalizedString(@"Ok", @"");

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:localizedSignUpString
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:localizedOkString
                                              otherButtonTitles:nil];
        
        [alert show];

    }
    
    else {
    
        NSLog(@"This is your event...!!");
    
    }
    
}

- (IBAction)homeButtonPressed:(id)sender {
    
    EventViewController *homeObj = [self.storyboard instantiateViewControllerWithIdentifier:@"EventViewController"];
    
    [self.navigationController pushViewController:homeObj animated:NO];

    
}

- (IBAction)notificationButtonPressed:(id)sender {
    
    NotificationViewController *eventObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NotificationViewController"];

    [self.navigationController pushViewController:eventObj animated:NO];

}

- (IBAction)shareInviteButtonPressed:(id)sender {
    
    
}

- (IBAction)settingButtonPressed:(id)sender {
    
    SettingViewController *settingObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    
    [self.navigationController pushViewController:settingObj animated:NO];

}
- (IBAction)editProfile:(id)sender {
    
    FacebookDetailViewController *facebookDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"FacebookDetailViewController"];
    
    [self.navigationController pushViewController:facebookDetailObj animated:NO];
    
}

- (IBAction)hideKeyboard:(UITapGestureRecognizer *)sender {
    
    [self.view endEditing:YES];
}

- (IBAction)interestButton:(id)sender {

    InterestViewController *interestDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"InterestViewController"];
    
    [self.navigationController pushViewController:interestDetailObj animated:NO];

    
}

- (IBAction)aboutUsButton:(id)sender {
    
    
    AboutUsViewController *aboutDetailObj = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
    
    [self.navigationController pushViewController:aboutDetailObj animated:NO];

    
}

- (IBAction)feedbackButton:(id)sender {


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
