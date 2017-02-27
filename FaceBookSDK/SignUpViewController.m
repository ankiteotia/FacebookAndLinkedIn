//
//  SignUpViewController.m
//  FaceBookSDK
//
//  Created by 10times on 16/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import "SignUpViewController.h"
#import "UserDetailViewController.h"
#import "EventViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
{
    UserDetailViewController *userDetails;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    userDetails = [[UserDetailViewController alloc] init];
    
    NSString *localizedSignUpString = NSLocalizedString(@"Sign Up", @"");
    self.navigationItem.title = localizedSignUpString;
    
    [self.navigationItem.backBarButtonItem setTitle:@""];

    self.registerBtn.layer.cornerRadius = 30.0;
    self.registerBtn.clipsToBounds = YES;
}

- (IBAction)hideKeyboard:(UITapGestureRecognizer *)sender {
    
    [self.view endEditing:YES];
    
}


- (IBAction)registerButton:(id)sender {
    
    [self textdata];
    
}


-(void)textdata{
    
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([self.nameText.text isEqual:@""] || [self.emailText.text isEqual:@""] || [self.companyText.text isEqual:@""] || [self.designationText.text isEqual:@""] || [self.passwordText.text isEqual:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"All fields are required"
                                                        message:@"Try Again"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    else{
    
    if (self.passwordText.text.length < 8) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"8 digit Password required"
                                                        message:@"Try Again"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];

    }
    
    else{
        
        if ([emailTest evaluateWithObject:self.emailText.text] == NO) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test!" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            return;
        }
        
        else {
        
    userDetails.eName = self.nameText.text;
    userDetails.eEmail = self.emailText.text;
    userDetails.eCompany = self.companyText.text;
    userDetails.eDesignation = self.designationText.text;
    
    userDetails.ePassword = self.passwordText.text;
  
    UIImage *userImage = [UIImage imageNamed: @"Ankit.jpg"];

    userDetails.eImageData = [NSData dataWithData:UIImagePNGRepresentation(userImage)];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    [standardUserDefaults setObject:userDetails.eName forKey:@"userName"];
    [standardUserDefaults synchronize];
    
    [standardUserDefaults setObject:userDetails.eEmail forKey:@"userEmail"];
    [standardUserDefaults synchronize];
    
    [standardUserDefaults setObject:userDetails.eCompany forKey:@"userCompany"];
    [standardUserDefaults synchronize];
    
    [standardUserDefaults setObject:userDetails.eDesignation forKey:@"userDesignation"];
    [standardUserDefaults synchronize];
    
    [standardUserDefaults setObject:userDetails.eImageData forKey:@"userPicture"];
    [standardUserDefaults synchronize];
    
    [standardUserDefaults setObject:userDetails.eImageData forKey:@"userPassword"];
    [standardUserDefaults synchronize];

    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    EventViewController *obj = [storyBoard instantiateViewControllerWithIdentifier:@"EventViewController"];
    
    [self.navigationController pushViewController:obj animated:NO];
    
      }
    }
  }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
