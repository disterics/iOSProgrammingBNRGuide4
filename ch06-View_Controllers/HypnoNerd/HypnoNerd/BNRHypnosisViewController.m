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

- (void)loadView
{
    // CReate a view
    CGRect frame = [UIScreen mainScreen].bounds;
    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] initWithFrame:frame];
    
    // set it as *the* view of this view controller
    self.view = backgroundView;
}
@end
