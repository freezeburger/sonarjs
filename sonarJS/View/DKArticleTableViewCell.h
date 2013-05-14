//
//  DKArticleTableViewCell.h
//  echojs
//
//  Created by Damien Klinnert on 02.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKArticleTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString *articleTitle;
@property (nonatomic, strong) NSString *articleUrl;
@property (nonatomic) NSInteger articleUpvotes;
@property (nonatomic) NSInteger articleDownvotes;
@property (nonatomic) NSInteger articleComments;
@property (nonatomic) NSInteger articleCreated;

@end
