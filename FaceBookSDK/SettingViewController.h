//
//  SettingViewController.h
//  FaceBookSDK
//
//  Created by 10times on 18/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *settingChangeLabel;

- (IBAction)settingSwitch:(id)sender;
- (IBAction)englishLanguage:(id)sender;
- (IBAction)chinessLanguage:(id)sender;

- (IBAction)spanishLanguage:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@end
