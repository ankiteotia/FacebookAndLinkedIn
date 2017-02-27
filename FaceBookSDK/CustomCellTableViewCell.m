//
//  CustomCellTableViewCell.m
//  CustomCell
//
//  Created by 10times on 21/12/16.
//  Copyright © 2016 10times. All rights reserved.
//

#import "CustomCellTableViewCell.h"
#import "DetailViewController.h"
#import <EventKitUI/EventKitUI.h>
#import "EventViewController.h"
#import "SVProgressHUD.h"
#import "VisitorViewController.h"

@interface MyCustomCell : UITableViewCell

@end

@implementation CustomCellTableViewCell
{

    EventViewController *setReminder;

    NSString *detail;
    NSString *dateDetail;
    NSString *dateEndDetail;
    NSString *nameDetail;
    
    UITableViewCell *selectedEventDate;
    UITableViewCell *selectedEventEndDate;
    UITableViewCell *selectedEventName;
    
}

@synthesize imageView, eventStore;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
      
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.imageView.layer.cornerRadius = 7.0;
    self.imageView.clipsToBounds = YES;
    
    self.attendButton.layer.cornerRadius = 7.0;
    self.attendButton.clipsToBounds = YES;
    
    self.followButton.layer.cornerRadius = 7.0;
    self.followButton.clipsToBounds = YES;
    
    self.secondView.layer.cornerRadius = 7.0;
    self.secondView.clipsToBounds = YES;
    
 self.attendButton.backgroundColor = [UIColor grayColor];
     self.followButton.backgroundColor = [UIColor grayColor];
}

- (IBAction)visitorButton:(id)sender {
    
    NSLog(@"this is your visitor list");
    
//    VisitorViewController *add = [[VisitorViewController alloc]
//                                  initWithNibName:@"VisitorViewController" bundle:nil];
//    [self.navigationController pushViewController:add animated:YES];
    
}
- (IBAction)followButton:(id)sender {
    
    NSLog(@"u have successfully follow this event");
}

- (IBAction)attendButton:(id)sender {
    
     NSLog(@"u have successfully attend this event");
}

- (IBAction)reminderButton:(id)sender {
    
    int x = (long)[sender tag];
    
        NSArray *jsonNameDetail = [[NSUserDefaults standardUserDefaults] objectForKey:@"JSONname"];
    
        NSArray *jsonDateDetail = [[NSUserDefaults standardUserDefaults] objectForKey:@"JSONdate"];
        NSArray *jsonEndDateDetail = [[NSUserDefaults standardUserDefaults] objectForKey:@"JSONendDate"];
    
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"yyy-MM-dd"];
        
        self.dateEndFormatter = [[NSDateFormatter alloc] init];
        [self.dateEndFormatter setDateFormat:@"yyy-MM-dd"];
        
        eventStore=[[EKEventStore alloc]init];
        
        EKEvent *event =[EKEvent eventWithEventStore:eventStore];
        
        NSDate *startDate=[[NSDate alloc]init];
        startDate = [self.dateFormatter dateFromString:jsonDateDetail[x]];
        
        NSDate *endDate =[[NSDate alloc]init];
        endDate = [self.dateEndFormatter dateFromString:jsonEndDateDetail[x]];
        
        event.title = jsonNameDetail[x];
        event.startDate = startDate;
        event.endDate = endDate;
        
        event.allDay=YES;
        
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent  error:&err];
    
        eventStore=[[EKEventStore alloc]init];
        
        __block BOOL accessGranted = NO;
    
        if([eventStore   respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
            
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            
            [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                
                accessGranted = granted;
                
                dispatch_semaphore_signal(sema);
                
            }];
            
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            
        } else {
            
            accessGranted = YES;
            
        }
        
        if (accessGranted) {
            
        }
    
    NSString *localizedAlertString = NSLocalizedString(@"Reminder is added successfully", @"");
    NSString *localizedOkString = NSLocalizedString(@"Ok", @"");
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:localizedAlertString
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:localizedOkString
                                              otherButtonTitles:nil];
        
        [alert show];

}

@end
