//
//  UIApplication+NetworkActivityManager.h
//  sonarJS
//
//  Created by Damien Klinnert on 18.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (NetworkActivityManager)
- (void)showNetworkActivityIndicator;
- (void)hideNetworkActivityIndicator;
@end
