//
//  BNRColorDescription.h
//  Colorboard
//
//  Created by disterics on 9/7/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;
@interface BNRColorDescription : NSObject

@property (nonatomic) UIColor *color;
@property (nonatomic, copy) NSString *name;

@end
