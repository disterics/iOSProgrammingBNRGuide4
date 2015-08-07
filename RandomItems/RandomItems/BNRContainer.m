//
//  BNRContainer.m
//  RandomItems
//
//  Created by disterics on 8/1/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRContainer.h"

@implementation BNRContainer

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber
                        subItems:(NSArray *)sItems
{
    self = [super initWithItemName:name valueInDollars:value serialNumber:sNumber];
    
    // did the superclass designated initialize succeed?
    if (self) {
        _subItems = [NSMutableArray arrayWithArray:sItems];
    }
    // return the newly initialized object
    return self;
}

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber
{
    return [self initWithItemName:name valueInDollars:value serialNumber:sNumber subItems:@[]];
}

- (int)containerValueInDollars
{
    return [super valueInDollars];
}

- (int)valueInDollars
{
    int value = [self containerValueInDollars];
    for (BNRItem *item in self.subItems)
    {
        value += item.valueInDollars;
    }
    return value;
}

- (void)setSubItems: (NSArray *)items
{
    _subItems = [NSMutableArray arrayWithArray:items];
}

- (NSArray *)subItems
{
    return _subItems;
}

- (void)addSubItem:(BNRItem *)item
{
    [_subItems addObject:item];
}

- (NSString *)description
{
    NSString *descriptionString = [[NSString alloc] initWithFormat:@"Container %@ (C%@): Worth $%d, recorded on %@\n%@",
                                   self.itemName, self.serialNumber,
                                   self.valueInDollars, self.dateCreated,
                                   [self.subItems componentsJoinedByString:@"\n"]];
    return descriptionString;
}

@end
