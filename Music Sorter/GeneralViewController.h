//
//  GeneralViewController.h
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

@interface GeneralViewController : UIViewController


+(void) loadInfo : (SongItem*) topSongArg : (ArtistItem*) topArtistArg : (AlbumItem*) topAlbumArg : (GenreItem*) topGenreArg : (long) value : (int) segmentIndexArg;
-(IBAction)closeWindow:(id)sender;
-(NSString*) getTimePlayedString : (long) timePlayed;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *songArtwork;
@property (weak, nonatomic) IBOutlet UIImageView *artistArtwork;
@property (weak, nonatomic) IBOutlet UIImageView *albumArtwork;
@property (weak, nonatomic) IBOutlet UIImageView *genreArtwork;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *wholeTitle;
@property (weak, nonatomic) IBOutlet UIView *smallView;

@end
