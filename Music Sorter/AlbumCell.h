//
//  AlbumCell.h
//  Music Sorter
//
//  Created by Mike Aboody on 10/27/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *artworkButton;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;



@end
