//
//  PasswordViewController.m
//  FaceBookSDK
//
//  Created by 10times on 23/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import "PasswordViewController.h"
#import "EventViewController.h"

@interface PasswordViewController ()

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *localizedPasswordString = NSLocalizedString(@"Login", @"");

    self.navigationItem.title = localizedPasswordString;

    self.logIn.layer.cornerRadius = 30.0;
    self.logIn.clipsToBounds = YES;
}

-(void)passwordDetail{
    
   if ([self.passwordText.text isEqual:[[NSUserDefaults standardUserDefaults] objectForKey:@"OTPdefault"]]
) {
       
       UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
       
       EventViewController *obj = [storyBoard instantiateViewControllerWithIdentifier:@"EventViewController"];
       
       [self.navigationController pushViewController:obj animated:NO];

    }
    
   else{
    
       NSString *localizedAlertString = NSLocalizedString(@"Incorrect OTP", @"");
       NSString *localizedString = NSLocalizedString(@"Try Again!", @"");
       NSString *localizedOkString = NSLocalizedString(@"Ok", @"");

       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:localizedAlertString
                                                       message:localizedString
                                                      delegate:self
                                             cancelButtonTitle:localizedOkString
                                             otherButtonTitles:nil];
       [alert show];
       

   }
    
}


- (IBAction)loginButton:(id)sender {
    
    [self passwordDetail];
    
}
- (IBAction)hideKeyboard:(UITapGestureRecognizer *)sender {
    
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
