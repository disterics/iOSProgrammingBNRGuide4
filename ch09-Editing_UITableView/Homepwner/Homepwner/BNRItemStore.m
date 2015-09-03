//
//  BNRItemStore.m
//  Homepwner
//
//  Created by disterics on 8/27/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore;
    if (!sharedStore)
    {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

// throw an error if init is called
- (instancetype)init
{
    [NSException raise:@"Singleton" format:@"Use +[BNRItemStore sharedStore]"];
    return nil;
}

// here is the secret initializer
- (instancetype)initPrivate
{
    self = [super init];
    if (self)
    {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allItems
{
    return [self.privateItems copy];
}

- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    [self.privateItems addObject:item];
    return item;
}

- (void)removeItem:(BNRItem *)item
{
    [self.privateItems removeObjectIdenticalTo:item];
}
@end
