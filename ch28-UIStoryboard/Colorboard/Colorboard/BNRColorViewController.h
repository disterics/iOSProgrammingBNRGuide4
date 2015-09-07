//
//  BNRColorViewController.h
//  Colorboard
//
//  Created by disterics on 9/7/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

@import UIKit;

@class BNRColorDescription;

@interface BNRColorViewController : UIViewController

@property (nonatomic) BOOL existingColor;
@property (nonatomic) BNRColorDescription *colorDescription;

@end
