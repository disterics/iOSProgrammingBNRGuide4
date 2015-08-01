//
//  main.m
//  RandomItems
//
//  Created by disterics on 7/28/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRItem.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Create a mutable array object, store its address in items variable
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 10; ++i)
        {
            BNRItem *item = [BNRItem randomItem];
            [items addObject:item];
        }
        // Print items in the array
        for (BNRItem *item in items) {
            // Log the description of item
            NSLog(@"%@", item);
        }
        
        // Destory the mutable array object
        items = nil;
    }
    return 0;
}
