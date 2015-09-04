//
//  BNRImageStore.m
//  Homepwner
//
//  Created by disterics on 9/3/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic,strong) NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore

+ (instancetype)sharedStore
{
    static BNRImageStore *sharedStore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    return sharedStore;
}

// throw an error if init is called
- (instancetype)init
{
    [NSException raise:@"Singleton" format:@"Use +[BNRImageStore sharedStore]"];
    return nil;
}

// here is the secret initializer
- (instancetype)initPrivate
{
    self = [super init];
    if (self)
    {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    // [self.dictionary setObject:image forKey:key];
    self.dictionary[key] = image;
}

- (UIImage *)imageForKey:(NSString *)key
{
    // return [self.dictionary objectForKey:key];
    return self.dictionary[key];
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key)
    {
        return;
    }
    [self.dictionary removeObjectForKey:key];
}


@end
