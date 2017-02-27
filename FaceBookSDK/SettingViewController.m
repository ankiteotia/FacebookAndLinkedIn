//
//  SettingViewController.m
//  FaceBookSDK
//
//  Created by 10times on 18/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import "SettingViewController.h"
#import "SWRevealViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController
BOOL toggleIsOn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    
//    self.settingChangeLabel.text = @"Turn Notification OFF";
}

- (IBAction)settingSwitch:(id)sender {

//    if(toggleIsOn){
//       
//        self.settingChangeLabel.text = @"Turn Notification OFF";
//        
//        toggleIsOn = false;
//        
//    }
//    else {
//        
//        self.settingChangeLabel.text = @"Turn Notification ON";
//        
//        toggleIsOn = true;
//    
//    }
}

- (IBAction)englishLanguage:(id)sender {
    
}

- (IBAction)chinessLanguage:(id)sender {
    
}

- (IBAction)spanishLanguage:(id)sender {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
