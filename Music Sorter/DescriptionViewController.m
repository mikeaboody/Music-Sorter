//
//  DescriptionViewController.m
//  Music Sorter
//
//  Created by Mike Aboody on 10/28/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "DescriptionViewController.h"
#import "SongItem.h"
#import "ArtistItem.h"
#import "AlbumItem.h"
#import "GenreItem.h"

@interface DescriptionViewController ()

@end
static NSObject *passedObject;
@implementation DescriptionViewController
@synthesize artworkImageView, nameLabel, extraInfoLabel, playCountLabel, timePlayedLabel, backgroundView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = backgroundView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:135.0f/255.0f green:206.0f/255.0f blue:250.0f/255.0f alpha:1.0f] CGColor], (id)[[UIColor colorWithRed:240.0f/255.0f green:248.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor], nil];
    [backgroundView.layer insertSublayer:gradient atIndex:0];
    
    
    if ([passedObject class] == [SongItem class]) {
        self.navigationItem.title = @"Song Info";
        songItemPassed = (SongItem*) passedObject;
        artworkImageView.image = songItemPassed.albumArtwork;
        nameLabel.text = songItemPassed.songTitle;
        NSString *tempArtistString = songItemPassed.artist;
        NSString *tempGenreString = songItemPassed.genre;
        
        if ([tempArtistString isKindOfClass:[NSNull class]] || tempArtistString == nil || [tempArtistString isEqualToString:@""]) {
            tempArtistString = @"Uknown";
        }
        
        if ([tempGenreString isKindOfClass:[NSNull class]] || tempGenreString == nil || [tempGenreString isEqualToString:@""]) {
            tempGenreString = @"Uknown";
        }
        
        extraInfoLabel.text = [NSString stringWithFormat:@"%@ - %@", tempArtistString, tempGenreString];
        if (songItemPassed.playCount == 1) {
            playCountLabel.text = [NSString stringWithFormat:@"%ld play", songItemPassed.playCount];
        } else {
            playCountLabel.text = [NSString stringWithFormat:@"%ld plays", songItemPassed.playCount];
        }
        
        timePlayedLabel.text = [self getTimePlayedString:[songItemPassed getTotalTime]];
    } else if ([passedObject class] == [ArtistItem class]) {
        self.navigationItem.title = @"Artist Info";
        artistItemPassed = (ArtistItem*) passedObject;
        
        artworkImageView.image = [artistItemPassed getArtwork];
        nameLabel.text = artistItemPassed.artistTitle;
        if (artistItemPassed.getSongAmount == 1) {
            extraInfoLabel.text = [NSString stringWithFormat:@"%d song", artistItemPassed.getSongAmount];
        } else {
            extraInfoLabel.text = [NSString stringWithFormat:@"%d songs", artistItemPassed.getSongAmount];
        }
        if (artistItemPassed.getTotalPlayCount == 1) {
            playCountLabel.text = [NSString stringWithFormat:@"%ld play", artistItemPassed.getTotalPlayCount];
        } else {
            playCountLabel.text = [NSString stringWithFormat:@"%ld plays", artistItemPassed.getTotalPlayCount];
        }
        
        timePlayedLabel.text = [self getTimePlayedString:artistItemPassed.getTotalTime];
        
    } else if ([passedObject class] == [AlbumItem class]) {
        self.navigationItem.title = @"Album Info";
        albumItemPassed = (AlbumItem*) passedObject;
        artworkImageView.image = albumItemPassed.artwork;
        nameLabel.text = albumItemPassed.albumTitle;
        NSString *tempArtistString = albumItemPassed.artistTitle;
        
        if ([tempArtistString isKindOfClass:[NSNull class]] || tempArtistString == nil || [tempArtistString isEqualToString:@""]) {
            tempArtistString = @"Uknown";
        }
        
        if (albumItemPassed.songAmount == 1) {
            extraInfoLabel.text = [NSString stringWithFormat:@"%@ - %d song", tempArtistString, albumItemPassed.songAmount];
        } else {
            extraInfoLabel.text = [NSString stringWithFormat:@"%@ - %d songs", tempArtistString, albumItemPassed.songAmount];
        }
        
        if(albumItemPassed.totalPlayCount == 1) {
            playCountLabel.text = [NSString stringWithFormat:@"%ld play", albumItemPassed.totalPlayCount];
        } else {
            playCountLabel.text = [NSString stringWithFormat:@"%ld plays", albumItemPassed.totalPlayCount];
        }
        
        timePlayedLabel.text = [self getTimePlayedString:albumItemPassed.totalTime];
        
    } else if ([passedObject class] == [GenreItem class]) {
        self.navigationItem.title = @"Genre Info";
        genreItemPassed = (GenreItem*) passedObject;
        artworkImageView.image = genreItemPassed.artwork;
        nameLabel.text = genreItemPassed.genreTitle;
        if (genreItemPassed.songAmount == 1) {
            extraInfoLabel.text = [NSString stringWithFormat:@"%d song", genreItemPassed.songAmount];
        } else {
            extraInfoLabel.text = [NSString stringWithFormat:@"%d songs", genreItemPassed.songAmount];
        }
        
        if (genreItemPassed.totalPlayCount == 1) {
           playCountLabel.text = [NSString stringWithFormat:@"%ld play", genreItemPassed.totalPlayCount];
        } else {
            playCountLabel.text = [NSString stringWithFormat:@"%ld plays", genreItemPassed.totalPlayCount];
        }
        
        timePlayedLabel.text = [self getTimePlayedString:genreItemPassed.totalTime];
    }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void) passObject : (NSObject*) objectArg
{
    passedObject = objectArg;
}

-(NSString*) getTimePlayedString : (long) timePlayed
{
    long tempTimePlayed = timePlayed;
    long numDays = tempTimePlayed / (60 * 60 * 24);
    tempTimePlayed -= numDays * 60 * 60 * 24;
    long numHours =tempTimePlayed / (60 * 60);
    tempTimePlayed -= numHours * 60 * 60;
    long numMinutes = tempTimePlayed / (60);
    tempTimePlayed -= numMinutes * 60;
    long numSeconds = tempTimePlayed;
    
    NSString *numDayString;
    
    numDayString = [NSString stringWithFormat:@"%ldd",numDays];
   
    
    NSString *numHourString;
    
    numHourString = [NSString stringWithFormat:@"%ldh",numHours];
    
    NSString *numMinuteString;
    
    numMinuteString = [NSString stringWithFormat:@"%ldm",numMinutes];
    
    NSString *numSecondString;
   
    numSecondString = [NSString stringWithFormat:@"%lds",numSeconds];
    
    
    
    if (numDays > 0) {
        return [NSString stringWithFormat:@"%@, %@, %@, %@",numDayString,numHourString, numMinuteString, numSecondString];
    } else if (numHours > 0) {
        return [NSString stringWithFormat:@"%@, %@, %@",numHourString, numMinuteString, numSecondString];
    } else if (numMinutes > 0) {
        return [NSString stringWithFormat:@"%@, %@",numMinuteString, numSecondString];
    } else {
        return [NSString stringWithFormat:@"%@", numSecondString];
    }
    
}

@end
