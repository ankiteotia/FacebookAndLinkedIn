//
//  LoginViewController.h
//  FaceBookSDK
//
//  Created by 10times on 16/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailLoginText;

- (IBAction)loginButton:(id)sender;

-(int)getRandomNumberBetween:(int)from to:(int)to;

@property (weak, nonatomic) IBOutlet UIButton *login;

@end
