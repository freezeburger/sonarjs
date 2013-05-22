//
//  DKCommentTableViewCell.m
//  sonarJS
//
//  Created by Damien Klinnert on 22.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKCommentTableViewCell.h"

@interface DKCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@end

@implementation DKCommentTableViewCell

#pragma mark - Getters / Setters

- (void)setComment:(NSString *)comment
{
    _comment = comment;
    self.commentTextView.text = comment;
}

@end
