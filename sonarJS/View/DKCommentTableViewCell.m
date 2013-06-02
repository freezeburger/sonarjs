//
//  DKCommentTableViewCell.m
//  sonarJS
//
//  Created by Damien Klinnert on 22.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKCommentTableViewCell.h"
#import "NSDate+TimeAgo.h"

@interface DKCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *commentTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@end

@implementation DKCommentTableViewCell

#pragma mark - Getters / Setters

- (void)setComment:(NSString *)comment
{
    _comment = comment;
    
    [self updateUI];
}

- (void)setAuthor:(NSString *)author
{
    _author = author;
    
    [self updateUI];
}

- (void)setCreated:(NSInteger)created
{
    _created = created;
    
    [self updateUI];
}



#pragma mark - UI

- (void)updateUI
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:self.created];
    NSString *timeAgo = [date timeAgo];
    self.commentTitleLabel.text = [NSString stringWithFormat: @"%@ - %@", timeAgo, self.author];
    self.commentTextView.text = self.comment;
    
//    [self.commentTextView sizeToFit];
    
    CGRect bodyFrame = self.commentTextView.frame;
    bodyFrame.size = self.commentTextView.contentSize;
    bodyFrame.size.height += 280.0f;
    self.commentTextView.frame = bodyFrame;
    
    self.commentTextView.contentInset = UIEdgeInsetsMake(-8, -8, 0, 0);

//    [self setNeedsDisplay];
//    [self setNeedsLayout];
//    [self setNeedsUpdateConstraints];
}

//- (void)prepareForReuse
//{
//    [self updateUI];
//    [self setNeedsDisplay];
//    [self setNeedsLayout];
//    [self setNeedsUpdateConstraints];
//}

@end
