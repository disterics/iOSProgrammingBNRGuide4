//
//  main.m
//  RandomItems
//
//  Created by disterics on 7/28/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRContainer.h"
#import "BNRItem.h"

#pragma mark - gold challenge

void testContainers()
{
#ifdef RUN_GOLD_CHALLENGE
    BNRContainer *superContainer = [BNRContainer randomItem];
    for (int i = 0; i < 10; ++i)
    {
        bool isContainer = ((arc4random() % 2) == 0);
        if (isContainer)
        {
            BNRContainer *tempContainer = [BNRContainer randomItem];
            for (int i = 0; i < 10; ++i)
            {
                [tempContainer addSubItem:[BNRItem randomItem]];
            }
            [superContainer addSubItem:tempContainer];
        }
        else
        {
            [superContainer addSubItem:[BNRItem randomItem]];
        }
    }
    NSLog(@"Super Container: \n%@", superContainer);
    superContainer = nil;
#endif
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Create a mutable array object, store its address in items variable
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        BNRItem *backPack = [[BNRItem alloc] initWithItemName:@"Backpack"];
        [items addObject:backPack];
        
        BNRItem *calculator = [[BNRItem alloc] initWithItemName:@"Calculator"];
        [items addObject:calculator];
        
        backPack.containedItem = calculator;
        
        backPack = nil;
        calculator = nil;
        // Print items in the array
        for (BNRItem *item in items) {
            // Log the description of item
            NSLog(@"%@", item);
        }
        testContainers();
        // Destory the mutable array object
        NSLog(@"Seting items to nil ...");
        items = nil;
    }
    return 0;
}

