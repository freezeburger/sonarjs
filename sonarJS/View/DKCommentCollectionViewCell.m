//
//  DKCommentCollectionViewCell.m
//  echojs
//
//  Created by Damien Klinnert on 12.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKCommentCollectionViewCell.h"

@interface DKCommentCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation DKCommentCollectionViewCell

- (void)setComment:(NSString *)comment
{
    _comment = comment;
    [self updateUI];
}

- (void)updateUI
{
    self.textView.text = self.comment;
 
    NSLog(@"%f", self.textView.contentSize.height);
    // recalculate height
    CGRect cellFrame = self.frame;
    CGRect textViewFrame = self.textView.frame;
    cellFrame.size.height = self.textView.contentSize.height;
    textViewFrame.size.height = self.textView.contentSize.height;
    self.frame = cellFrame;
    self.textView.frame = textViewFrame;
}

@end
