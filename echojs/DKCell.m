//
//  DKCell.m
//  echojs
//
//  Created by Damien Klinnert on 03.05.13.
//  Copyright (c) 2013 Damien Klinnert. All rights reserved.
//

#import "DKCell.h"

@implementation DKCell

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
