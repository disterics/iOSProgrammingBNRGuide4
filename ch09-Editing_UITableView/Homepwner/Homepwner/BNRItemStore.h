//
//  BNRItemStore.h
//  Homepwner
//
//  Created by disterics on 8/27/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly, copy) NSArray *allItems;

+ (instancetype)sharedStore;

- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;

@end
