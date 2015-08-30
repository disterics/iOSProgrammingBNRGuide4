//
//  BNRItemStore.m
//  Homepwner
//
//  Created by disterics on 8/27/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemStore.h"

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
    return self;
}
@end
