//
//  CustomCellTableViewCell.h
//  CustomCell
//
//  Created by 10times on 21/12/16.
//  Copyright © 2016 10times. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKitUI/EventKitUI.h>

@interface CustomCellTableViewCell : UITableViewCell
{
    EKEventStore *eventStore;
    
}

@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *attendButton;
@property (weak, nonatomic) IBOutlet UIButton *followButton;

- (IBAction)followButton:(id)sender;

- (IBAction)attendButton:(id)sender;

- (IBAction)reminderButton:(id)sender;

- (IBAction)visitorButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *reminderButton;
@property (weak, nonatomic) IBOutlet UIButton *visitorButton;

@property (weak, nonatomic) IBOutlet UIView *secondView;

@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;

@property (strong, nonatomic) EKEventStore *eventStore;

@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic,strong) NSDateFormatter *dateEndFormatter;
@property (nonatomic) BOOL isAccessToEventStoreGranted;

@property (strong, nonatomic) NSMutableArray *todoItems;


@end
