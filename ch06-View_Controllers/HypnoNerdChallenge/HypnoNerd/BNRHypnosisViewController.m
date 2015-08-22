//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by disterics on 8/18/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController() {
    BNRHypnosisView *hypnosisView;
}

@end

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
    UIView *backgroundView = [[UIView alloc] initWithFrame:frame];
    hypnosisView = [[BNRHypnosisView alloc] initWithFrame:frame];
    UISegmentedControl *csView = [[UISegmentedControl alloc] initWithItems:@[@"Red", @"Green", @"Blue"]];
    csView.momentary = YES;
    [csView addTarget:self action:@selector(colorSelectorChanged:)
               forControlEvents:UIControlEventValueChanged];
    // offset found by experimentation
    // until we find out a way to programmatically detemine this, we hard code it there
    CGRect csFrame = csView.bounds;
    csFrame.origin.y = frame.size.height - 80.0;
    csFrame.origin.x = (frame.size.width - csFrame.size.width) / 2.0;
    csView.frame = csFrame;
    [backgroundView addSubview:hypnosisView];
    [backgroundView addSubview:csView];
    // set it as *the* view of this view controller
    self.view = backgroundView;
}

- (void)viewDidLoad
{
    // Always call the super implementation of viewDidLoad
    [super viewDidLoad];
    
    NSLog(@"BNRHypnosisViewController loaded its view.");
}

- (void) colorSelectorChanged:(UISegmentedControl *)item
{
    long index = [item selectedSegmentIndex];
    if (0 == index)
    {
        [hypnosisView setCircleColor:[UIColor redColor]];
    }
    else if (1 == index)
    {
        [hypnosisView setCircleColor:[UIColor greenColor]];
    }
    else if (2 == index)
    {
        [hypnosisView setCircleColor:[UIColor blueColor]];
    }
    NSLog(@"ColorSlector fired %ld", (long)[item selectedSegmentIndex]);
}

@end
