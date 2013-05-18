//
//  DKEchoJS.m
//  sonarJS
//
//  Created by Damien Klinnert on 18.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKEchoJS.h"
#import "AFNetworking.h"

@implementation DKEchoJS

- (void)retrieveArticlesOrderedBy:(DKEchoJSOrderMode)orderMode startingAtIndex:(NSInteger)index withCount:(NSInteger)count success:(void (^)(id JSON))success
{
    NSString *urlString = (orderMode == DKEchoJSOrderModeTop) ?
    [NSString stringWithFormat:@"http://www.echojs.com/api/getnews/top/%d/%d", index, count] :
    [NSString stringWithFormat:@"http://www.echojs.com/api/getnews/latest/%d/%d", index, count];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    dispatch_queue_t q = dispatch_queue_create("articles", NULL); // serial
    dispatch_async(q, ^{
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id articles) {
            
            // @TODO: check for errors

            dispatch_async(dispatch_get_main_queue(), ^{
                success([articles valueForKeyPath:@"news"]);
            });
        } failure:nil];
        [operation start];
    });
}

@end
