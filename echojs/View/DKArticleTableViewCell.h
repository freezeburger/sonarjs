//
//  DKArticleTableViewCell.h
//  echojs
//
//  Created by Damien Klinnert on 02.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKArticleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *articleUser;
@property (weak, nonatomic) IBOutlet UILabel *articleUrl;
@property (weak, nonatomic) IBOutlet UILabel *articleAge;
@property (weak, nonatomic) IBOutlet UILabel *articleComments;

@end
