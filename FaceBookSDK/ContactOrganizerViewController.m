//
//  ContactOrganizerViewController.m
//  CustomCell
//
//  Created by 10times on 29/12/16.
//  Copyright © 2016 10times. All rights reserved.
//

#import "ContactOrganizerViewController.h"

@interface ContactOrganizerViewController ()

@end

@implementation ContactOrganizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *localizedSignUpString = NSLocalizedString(@"Contact Organizer", @"");
    self.navigationItem.title = localizedSignUpString;
    
    self.contact.layer.cornerRadius = 20.0;
    self.contact.clipsToBounds = YES;
    
}

- (IBAction)dismissKeyboard:(id)sender {
    
    [self.view endEditing:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
