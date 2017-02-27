//
//  VisitorTableViewCell.m
//  FaceBookSDK
//
//  Created by 10times on 28/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import "VisitorTableViewCell.h"

@implementation VisitorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.visitorProfileImage.layer.cornerRadius = 50.0;
    self.imageView.clipsToBounds = YES;

}

- (IBAction)visitorConnectButton:(id)sender {
    
    NSLog(@"Now You r connected");
}
@end
