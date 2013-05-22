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

+ (DKEchoJS *)sharedInstance;

- (void)retrieveArticlesOrderedBy:(DKEchoJSOrderMode)orderMode startingAtIndex:(NSInteger)index withCount:(NSInteger)count success:(void (^)(id articles))success;

- (void)retrieveCommentsForArticleId:(NSInteger)articleId success:(void (^)(id comments))success;

@end
