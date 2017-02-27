//
//  ViewController.h
//  FaceBookSDK
//
//  Created by Ankit Teotia on 19/12/16.
//  Copyright © 2016 Ankit Teotia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import <Accounts/Accounts.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <linkedin-sdk/LISDK.h>
#import "LinkedInOAuthViewController.h"
#import "LinkedInConnector.h"

@interface ViewController : UIViewController<UIAlertViewDelegate,NSURLSessionDelegate,LinkedInOAuthViewControllerDelegate,LinkedInConnectorDelegate,NSURLSessionDelegate>
{
    NSDictionary *dictLinkedInData;
}

@property (weak, nonatomic) IBOutlet UIImageView *welcomeImage;

@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) ACAccount *fbAccount;
@property(nonatomic, strong) NSString *accessToken;

-(id)initWithAccessToken:(NSString *)accessToken;

@property (strong,nonatomic) LinkedInConnector *objLinkedInConnector;

@property (weak, nonatomic) IBOutlet UIButton *signUp;
@property (weak, nonatomic) IBOutlet UIButton *signIn;

- (IBAction)facebookLogin:(id)sender;

- (IBAction)linkedInLogin:(id)sender;

@end

