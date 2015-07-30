//
//  GenreTableCell.h
//  Music Sorter
//
//  Created by Mike Aboody on 10/26/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenreTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *genreNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *characteristicInfoLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;
@property (nonatomic, weak) IBOutlet UILabel *sortLabel;

@end
