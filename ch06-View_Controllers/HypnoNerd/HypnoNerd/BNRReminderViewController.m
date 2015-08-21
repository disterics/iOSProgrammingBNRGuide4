//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by disterics on 8/21/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRReminderViewController.h"

@interface BNRReminderViewController()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end


@implementation BNRReminderViewController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // set the tab item's title
        self.tabBarItem.title = @"Reminder";
        
        // create a UIImage from a file
        // will use Hypno@2x.png for retina display devices
        UIImage *image = [UIImage imageNamed:@"Time.png"];
        
        // put the image on the tab bar item
        self.tabBarItem.image = image;
    }
    return self;
}


- (IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
}

@end
