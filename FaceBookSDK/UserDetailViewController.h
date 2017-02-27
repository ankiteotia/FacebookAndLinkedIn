//
//  UserDetailViewController.h
//  FaceBookSDK
//
//  Created by 10times on 21/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserDetailViewController : UIViewController

@property(nonatomic, strong) NSString *eName;
@property(nonatomic, strong) NSString *eEmail;
@property(nonatomic, strong) NSString *eCompany;
@property(nonatomic, strong) NSString *eDesignation;
@property(nonatomic, strong) NSString *eLocation;
@property(nonatomic, strong) NSString *eImageURL;

@property(nonatomic, strong) NSString *ePassword;

@property(nonatomic, strong) NSURL *eURL;
@property(nonatomic, strong) NSData *eImageData;

@end
