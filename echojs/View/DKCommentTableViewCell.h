//
//  DKCommentTableViewCell.h
//  echojs
//
//  Created by Damien Klinnert on 11.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKCommentTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString *comment;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end
