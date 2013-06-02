//
//  DKArticleTableViewCell.m
//  echojs
//
//  Created by Damien Klinnert on 02.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKArticleTableViewCell.h"
#import "NSDate+TimeAgo.h"

@interface DKArticleTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@end

@implementation DKArticleTableViewCell

#pragma mark - Getters / Setters

- (void)setArticleTitle:(NSString *)articleTitle
{
    _articleTitle = articleTitle;
    [self updateUI];
}

- (void)setArticleUrl:(NSString *)articleUrl
{
    _articleUrl = articleUrl;
    [self updateUI];
}

- (void)setArticleUpvotes:(NSInteger)articleUpvotes
{
    _articleUpvotes = articleUpvotes;
    [self updateUI];
}

- (void)setArticleDownvotes:(NSInteger)articleDownvotes
{
    _articleDownvotes = articleDownvotes;
    [self updateUI];
}

- (void)setArticleComments:(NSInteger)articleComments
{
    _articleComments = articleComments;
    [self updateUI];
}

- (void)setArticleCreated:(NSInteger)articleCreated
{
    _articleCreated = articleCreated;
    [self updateUI];
}



#pragma mark - View helpers

- (void)updateUI
{
    // calculate helpers for url and date
    NSURL *url = [NSURL URLWithString:self.articleUrl];
    NSString *hostname = [url host];
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:self.articleCreated];
    NSString *timeAgo = [date timeAgo];

    // set outlets
    self.titleLabel.text = self.articleTitle;
    self.urlLabel.text = [NSString stringWithFormat:@"%@ - %@", timeAgo, hostname];
    self.commentsLabel.text = [NSString stringWithFormat:@"%d up, %d down, %d comments", self.articleUpvotes, self.articleDownvotes, self.articleComments];
}

@end
