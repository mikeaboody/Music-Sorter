//
//  DescriptionViewController.h
//  Music Sorter
//
//  Created by Mike Aboody on 10/28/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongItem.h"
#import "ArtistItem.h"
#import "AlbumItem.h"
#import "GenreItem.h"

@interface DescriptionViewController : UIViewController
{
    SongItem *songItemPassed;
    ArtistItem *artistItemPassed;
    AlbumItem *albumItemPassed;
    GenreItem *genreItemPassed;
}
-(NSString*) getTimePlayedString : (long) timePlayed;

+(void) passObject : (NSObject*) objectArg;
@property (weak, nonatomic) IBOutlet UIImageView *artworkImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *extraInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timePlayedLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

@end
