//
//  VisitorTableViewCell.h
//  FaceBookSDK
//
//  Created by 10times on 28/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisitorTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *visitorProfileImage;

@property (weak, nonatomic) IBOutlet UILabel *visitorNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *visitorPosition;

@property (weak, nonatomic) IBOutlet UILabel *visitorLocation;

@property (weak, nonatomic) IBOutlet UIButton *visitorConnect;

- (IBAction)visitorConnectButton:(id)sender;

@end
