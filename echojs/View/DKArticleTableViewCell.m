//
//  DKArticleTableViewCell.m
//  echojs
//
//  Created by Damien Klinnert on 02.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKArticleTableViewCell.h"
#import "../NSDate-TimeAgo/NSDate+TimeAgo.h"

@interface DKArticleTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@end

@implementation DKArticleTableViewCell

- (void)updateUI
{
    // calculate helpers for url and date
    NSURL *url = [NSURL URLWithString:self.articleUrl];
    NSString *hostname = [url host];
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:self.articleCreated];
    NSString *timeAgo = [date timeAgo];

    // set outlets
    self.titleLabel.text = self.articleTitle;
    self.urlLabel.text = [NSString stringWithFormat:@"%@ at %@", timeAgo, hostname];
    self.commentsLabel.text = [NSString stringWithFormat:@"%d up, %d down, %d comments",
                          self.articleUpvotes, self.articleDownvotes, self.articleComments];

}

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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
