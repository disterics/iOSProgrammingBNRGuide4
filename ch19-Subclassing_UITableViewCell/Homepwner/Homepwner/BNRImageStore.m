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
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(clearCache:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    // [self.dictionary setObject:image forKey:key];
    self.dictionary[key] = image;
    // Create a full path for image
    NSString *imagePath = [self imagePathForKey:key];
    // turn image into JPEG data
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    
    // write to the full path
    [data writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)key
{
    // return [self.dictionary objectForKey:key];
    UIImage *result = self.dictionary[key];
    if (!result)
    {
        NSString *imagePath = [self imagePathForKey:key];
        result = [UIImage imageWithContentsOfFile:imagePath];
        
        // if we found the image on the fs, place it on the cache
        if (result)
        {
            self.dictionary[key] = result;
        }
        else
        {
            NSLog(@"Error: unable to find %@", imagePath);
        }
    }
    return result;
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key)
    {
        return;
    }
    [self.dictionary removeObjectForKey:key];
    NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

- (NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // get the document directory from that list
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}

- (void)clearCache:(NSNotification *)note
{
    NSLog(@"Flusing %lu images out of the cache", (unsigned long)[self.dictionary count]);
    [self.dictionary removeAllObjects];
}
@end
