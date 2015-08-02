//
//  BNRContainer.h
//  RandomItems
//
//  Created by disterics on 8/1/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRItem.h"

@interface BNRContainer : BNRItem
{
    NSMutableArray *_subItems;
}

// Designated initializer for BNRContainer
- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber
                        subItems:(NSArray *)sItems;

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber;


- (void)setSubItems: (NSArray *)items;
- (NSArray *)subItems;
- (void)addSubItem:(BNRItem *)item;

- (int)containerValueInDollars;

@end
