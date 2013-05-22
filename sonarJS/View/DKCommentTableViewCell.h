//
//  DKCommentTableViewCell.h
//  sonarJS
//
//  Created by Damien Klinnert on 22.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKCommentTableViewCell : UITableViewCell
@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSString *author;
@property (nonatomic) NSInteger created;
@end
