//
//  LinkedInOAuthViewController.h
//  LinkedInSampleApp
//
//  Created by 10times on 05/12/16.
//  Copyright © 2016 10times. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LinkedInOAuthViewControllerDelegate<NSObject>
-(void)accessTokenReceived:(NSString *)accessToken secondsRemainingBeforeExpiry:(NSInteger)secondsRemainingBeforeExpiry error:(NSError *)error;
@end

@interface LinkedInOAuthViewController : UIViewController<UIWebViewDelegate>
{
    NSString *ApiKeyApp;
    NSString *SecretKeyApp;
    NSArray  *PermissionsArray;
    NSMutableData *dataFromServer;
}

-(id)initWith_ApiKey:(NSString *)ApiKey SecretKey:(NSString *)SecretKey permissions:(NSArray *)permissions;

@property(nonatomic,strong) NSString *ApiKeyApp;
@property(nonatomic,strong) NSString *SecretKeyApp;
@property(nonatomic,strong) NSArray  *PermissionsArray;


@property (nonatomic,strong) id<LinkedInOAuthViewControllerDelegate> delegate;

@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, strong) NSString *authorizationToken;
@property(nonatomic, strong) NSString *linkeInAccessToken;
@property(nonatomic) NSInteger secondsRemainingBeforeExpiry;


@end
