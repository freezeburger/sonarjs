//
//  DKAppDelegate.m
//  echojs
//
//  Created by Damien Klinnert on 01.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKAppDelegate.h"

@implementation DKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    UIImage *image = [[UIImage alloc] init];
    [[UINavigationBar appearance] setShadowImage:image];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                         UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0, 0)]
     }];
    
    
    // [[UIBarButtonItem appearance] setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
//    [[UIBarItem appearance] setTitleTextAttributes:
//     [NSDictionary dictionaryWithObjectsAndKeys:
//      [UIColor colorWithRed:220.0/255.0 green:104.0/255.0 blue:1.0/255.0 alpha:1.0], UITextAttributeTextColor,
//      [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0], UITextAttributeTextShadowColor,
//      [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
//      [UIFont fontWithName:@"AmericanTypewriter" size:0.0], UITextAttributeFont,
//      nil] forState:UIControlStateNormal];

//    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:0.76f green:0.13f blue:0.00f alpha:1.00f]];
    
    
    [[UIBarButtonItem appearance] setBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIToolbar appearance] setBackgroundImage:image forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
