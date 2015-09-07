//
//  AppDelegate.m
//  Homepwner
//
//  Created by disterics on 8/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "AppDelegate.h"

#import "BNRItemStore.h"
#import "BNRItemsViewController.h"

NSString * const BNRNextItemValuePrefsKey = @"NextItemValue";
NSString * const BNRNextItemNamePrefsKey = @"NextItemName";


@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)initialize
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *factorySettings = @{ BNRNextItemValuePrefsKey : @75,
                                       BNRNextItemNamePrefsKey : @"Coffee Cup"
                                       };
    [defaults registerDefaults:factorySettings];
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // if state restoration did not occur
    if (!self.window.rootViewController) {
        // Override point for customization after application launch.
        BNRItemsViewController *itemsViewController = [[BNRItemsViewController alloc] init];
    
        // create a navigationcontroller
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:itemsViewController];
    
        // Give the navigation controller a restoration identifier that is the name of the class
        navController.restorationIdentifier = NSStringFromClass([navController class]);
    
        // place the navigation controller in the window hierarchy
        self.window.rootViewController = navController;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    BOOL success = [[BNRItemStore sharedStore] saveChanges];
    if (success)
    {
        NSLog(@"Saved all of the BNRItems");
    }
    else
    {
        NSLog(@"Could not save any of the BNRItems");
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    return YES;
}

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    // Create a new navigation controller
    UIViewController *vc = [[UINavigationController alloc] init];
    //the last object in the path array is the restoration identiier for this view controller
    vc.restorationIdentifier = [identifierComponents lastObject];
    if ([identifierComponents count] == 1)
    {
        // since there is only 1, this is th eroot view controller
        self.window.rootViewController = vc;
    }
    else
    {
        // it s the nav controller for a new item
        // so set the modela presentation style
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    return vc;
}

@end
