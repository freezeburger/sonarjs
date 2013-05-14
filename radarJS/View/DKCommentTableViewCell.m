//
//  DKCommentTableViewCell.m
//  echojs
//
//  Created by Damien Klinnert on 11.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKCommentTableViewCell.h"

@implementation DKCommentTableViewCell

- (void)setComment:(NSString *)comment
{
    _comment = comment;
    [self updateUI];
}

- (void)updateUI
{
    self.textView.text = self.comment;
    
    NSLog(@"%f", self.textView.frame.size.height);
    NSLog(@"%f", self.textView.contentSize.height);
    
    // resize textview to content height
    CGRect frame = self.textView.frame;
    frame.size.height = self.textView.contentSize.height;
    self.textView.frame = frame;
}

@end
