//
//  LoginViewController.m
//  FaceBookSDK
//
//  Created by 10times on 16/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import "LoginViewController.h"
#import "EventViewController.h"
#import "PasswordViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *localizedLogInString = NSLocalizedString(@"LogIn", @"");
    self.navigationItem.title = localizedLogInString;
    
    [self.navigationItem.backBarButtonItem setTitle:@""];
    
    self.login.layer.cornerRadius = 30.0;
    self.login.clipsToBounds = YES;

}

- (IBAction)hideKeyboard:(UITapGestureRecognizer *)sender {
    
    [self.view endEditing:YES];
}


-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

-(void)userLoginDetail{
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    NSString *email = self.emailLoginText.text;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setObject:email forKey:@"userEmail"];
    [standardUserDefaults synchronize];

    
    if ([email isEqual:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Username can't be empty"
                                                message:@"Try Again!"
                                                delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
   
    else{
   
        if ([emailTest evaluateWithObject:self.emailLoginText.text] == NO) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Email!" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            return;
        }
        
        else {
        
        int randomNumber = [self getRandomNumberBetween:1000 to:9999];
        
        NSLog(@"%d", randomNumber);
       
        NSString *OTP = [[NSNumber numberWithInt:randomNumber] stringValue];;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your OTP number is"
                                                        message:OTP
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        
        [[NSUserDefaults standardUserDefaults] setObject:OTP forKey:@"OTPdefault"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        if (UIAlertActionStyleCancel) {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        PasswordViewController *obj = [storyBoard instantiateViewControllerWithIdentifier:@"PasswordViewController"];
        
        [self.navigationController pushViewController:obj animated:NO];
            
        }
    }
  }
}

- (IBAction)loginButton:(id)sender {
    
    [self userLoginDetail];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
