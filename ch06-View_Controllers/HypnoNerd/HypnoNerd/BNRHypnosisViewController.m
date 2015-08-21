//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by disterics on 8/18/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@implementation BNRHypnosisViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // set the tab item's title
        self.tabBarItem.title = @"Hypnotize";
        
        // create a UIImage from a file
        // will use Hypno@2x.png for retina display devices
        UIImage *image = [UIImage imageNamed:@"Hypno.png"];
        
        // put the image on the tab bar item
        self.tabBarItem.image = image;
    }
    return self;
}

- (void)loadView
{
    // CReate a view
    CGRect frame = [UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] initWithFrame:frame];
    
    // set it as *the* view of this view controller
    self.view = backgroundView;
}

- (void)viewDidLoad
{
    // Always call the super implementation of viewDidLoad
    [super viewDidLoad];
    
    NSLog(@"BNRHypnosisViewController loaded its view.");
}
@end
