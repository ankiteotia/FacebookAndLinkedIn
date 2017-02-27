//
//  SignUpViewController.h
//  FaceBookSDK
//
//  Created by 10times on 16/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;

@property (weak, nonatomic) IBOutlet UITextField *companyText;
@property (weak, nonatomic) IBOutlet UITextField *designationText;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

- (IBAction)registerButton:(id)sender;


@end
