//
//  DKEchoJS.h
//  sonarJS
//
//  Created by Damien Klinnert on 18.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _DKEchoJSOrderMode {
    DKEchoJSOrderModeTop,
    DKEchoJSOrderModeLatest
} DKEchoJSOrderMode;

@interface DKEchoJS : NSObject
- (void)retrieveArticlesOrderedBy:(DKEchoJSOrderMode)orderMode startingAtIndex:(NSInteger)index withCount:(NSInteger)count success:(void (^)(id articles))success;
@end
