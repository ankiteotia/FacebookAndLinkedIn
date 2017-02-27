//
//  FacebookDetailViewController.m
//  FaceBookSDK
//
//  Created by Ankit Teotia on 20/12/16.
//  Copyright © 2016 Ankit Teotia. All rights reserved.
//

#import "FacebookDetailViewController.h"
#import "SVProgressHUD.h"
#import "ViewController.h"
#import "NewRearViewController.h"
#import "ViewController.h"
#import "SWRevealViewController.h"

@interface FacebookDetailViewController ()

@end

@implementation FacebookDetailViewController
{
    UIViewController *facebookData;
    ViewController *selectedButton;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.save.layer.cornerRadius = 30.0;
    self.save.clipsToBounds = YES;
    
    self.logOut.layer.cornerRadius = 30.0;
    self.logOut.clipsToBounds = YES;
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    
    [self userDetails];
    
    [SVProgressHUD dismiss];

}
- (IBAction)hideKeyboard:(UITapGestureRecognizer *)sender {
    
    [self.view endEditing:YES];
}

- (IBAction)logoutButton:(id)sender {
    
    ViewController *viewControllerObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [self.navigationController pushViewController:viewControllerObj animated:NO];
    
}

-(void)userDetails{
    
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *email = [[NSUserDefaults standardUserDefaults] objectForKey:@"userEmail"];
    NSData *picture = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPicture"];
    
    NSArray *company = [[NSUserDefaults standardUserDefaults] objectForKey:@"userCompany"];
    
NSString *designation = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDesignation"];
    NSString *location = [[NSUserDefaults standardUserDefaults] objectForKey:@"userLocation"];
   
    self.profileNameText.text = name;
    self.emailLabel.text = email;
    
  //  self.profileCompanyText.text = company[0];
    self.profileDesignationText.text = designation;
    self.profileLocationText.text = location;
    
    self.profileImageView.image = [UIImage imageWithData:picture];
    self.profileImageView.layer.cornerRadius = 55.0;
    self.profileImageView.clipsToBounds = YES;
    
    self.coverImageView.image = [UIImage imageWithData:picture];
    
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        
        self.coverImageView.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        
        blurEffectView.frame = self.coverImageView.bounds;
        
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.coverImageView addSubview:blurEffectView];
        
    } else {
        
        self.coverImageView.backgroundColor = [UIColor blackColor];
    }
}

- (IBAction)submitButton:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your Profile has been saved"
                                                    message:@"Successfully"
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
