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
        
        // Send the message addObject: to the NSMutableArray pointed to
        // by the variable items, passing a string each time
        [items addObject:@"One"];
        [items addObject:@"Two"];
        [items addObject:@"Three"];
        
        //Send another message insertObject:atIndex:, to that same array object
        [items insertObject:@"Zero" atIndex:0];
        
        // Print items in the array
        for (NSString *item in items) {
            // Log the description of item
            NSLog(@"%@", item);
        }
        
        BNRItem *item = [[BNRItem alloc] init];
        item.itemName =  @"Red Sofa";
        item.serialNumber = @"A1B2C";
        item.valueInDollars = 100;

        NSLog(@"%@", item);
        // Destory the mutable array object
        items = nil;
    }
    return 0;
}
