//
//  SongTableCell.m
//  Music Sorter
//
//  Created by Mike Aboody on 10/26/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "SongTableCell.h"

@implementation SongTableCell
@synthesize songNameLabel, thumbnailImageView,characteristicInfoLabel, sortLabel;
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
