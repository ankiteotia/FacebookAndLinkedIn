//
//  PasswordViewController.h
//  FaceBookSDK
//
//  Created by 10times on 23/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *passwordText;


- (IBAction)loginButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *logIn;

@end
