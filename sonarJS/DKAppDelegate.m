//
//  DKAppDelegate.m
//  echojs
//
//  Created by Damien Klinnert on 01.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKAppDelegate.h"
#import "UIBarButtonItem+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "ECSlidingViewController.h"

@implementation DKAppDelegate

#pragma mark - Helpers

- (void)configureFlatUI
{
    UIColor *redColor  = [UIColor colorWithRed:0.73f green:0.09f blue:0.00f alpha:1.00f];
    UIColor *reallyDark  = [UIColor colorWithRed:0.34f green:0.04f blue:0.00f alpha:1.00f];
    UIColor *darkRedColor = [UIColor colorWithRed:0.64f green:0.08f blue:0.00f alpha:1.00f];

    ECSlidingViewController *con = (ECSlidingViewController *)self.window.rootViewController;
    UINavigationController *navCon = (UINavigationController *)con.topViewController;
    
    [navCon.navigationBar configureFlatNavigationBarWithColor:redColor];
    [navCon.navigationBar setTitleTextAttributes:@{UITextAttributeTextShadowColor: redColor}];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[ECSlidingViewController class], nil] setTitleTextAttributes:@{UITextAttributeTextShadowColor: redColor} forState:UIControlStateNormal];
    [UIBarButtonItem configureFlatButtonsWithColor:darkRedColor highlightedColor:reallyDark cornerRadius:3 whenContainedIn:[ECSlidingViewController class]];
    
    [[UIToolbar appearance] setBackgroundImage:[[UIImage alloc] init] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
}



#pragma mark - app delegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    ECSlidingViewController *con = (ECSlidingViewController *)self.window.rootViewController;
    con.topViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"Articles"];
    
    [self configureFlatUI];
    
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
