//
//  UIApplication+NetworkActivityManager.m
//  sonarJS
//
//  Created by Damien Klinnert on 18.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "UIApplication+NetworkActivityManager.h"

static NSInteger counter = 0;

@implementation UIApplication (NetworkActivityManager)

- (void)showNetworkActivityIndicator
{
     @synchronized (self) {
         if (counter == 0) {
             self.networkActivityIndicatorVisible = YES;
         }
         counter += 1;
     }
}

- (void)hideNetworkActivityIndicator
{
    @synchronized (self) {
        counter -= 1;
        if (counter == 0) {
            self.networkActivityIndicatorVisible = NO;
        }
    }
}

@end
