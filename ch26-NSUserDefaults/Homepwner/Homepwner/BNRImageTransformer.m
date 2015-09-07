//
//  BNRImageTransformer.m
//  Homepwner
//
//  Created by disterics on 9/5/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRImageTransformer.h"
#import <UIKit/UIImage.h>

@implementation BNRImageTransformer

+ (Class)transformedValueClass
{
    return [NSData class];
}

- (id)transformedValue:(id)value
{
    if (!value)
    {
        return nil;
    }
    
    if ([value isKindOfClass:[NSData class]])
    {
        return value;
    }
    
    return UIImagePNGRepresentation(value);
}

- (id)reverseTransformedValue:(id)value
{
    return [UIImage imageWithData:value];
}
@end
