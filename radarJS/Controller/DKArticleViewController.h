//
//  DKArticleViewController.h
//  echojs
//
//  Created by Damien Klinnert on 01.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKArticleViewController : UIViewController
@property (nonatomic, strong) NSString *articleTitle;
@property (nonatomic, strong) NSString *articleUrl;
@property (nonatomic) NSInteger articleId;
@property (nonatomic) NSInteger articleComments;
@end
