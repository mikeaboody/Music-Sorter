//
//  GeneralViewController.m
//  Music Sorter
//
//  Created by Mike Aboody on 10/28/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "GeneralViewController.h"
#import "SongItem.h"
#import "ArtistItem.h"
#import "AlbumItem.h"
#import "GenreItem.h"
@interface GeneralViewController ()

@end

static SongItem *topSong;
static ArtistItem *topArtist;
static AlbumItem *topAlbum;
static GenreItem *topGenre;
static long valueOfTotal;
static long segmentIndex;
@implementation GeneralViewController
@synthesize closeButton, backgroundView, songLabel, songArtwork, artistArtwork, artistLabel, genreArtwork, genreLabel, albumArtwork, albumLabel, titleLabel, valueLabel, wholeTitle, smallView;

+(void) loadInfo : (SongItem*) topSongArg : (ArtistItem*) topArtistArg : (AlbumItem*) topAlbumArg : (GenreItem*) topGenreArg : (long) value : (int) segmentIndexArg;
{
    topSong = topSongArg;
    topArtist = topArtistArg;
    topAlbum = topAlbumArg;
    topGenre = topGenreArg;
    valueOfTotal = value;
    segmentIndex = segmentIndexArg;
}
-(IBAction)closeWindow:(id)sender
{
    [self dismissViewControllerAnimated:YES completion: nil];
}
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
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    wholeTitle.textColor = [UIColor colorWithRed:19/255.0 green:144/255.0 blue:255/255.0 alpha:1.0];
    wholeTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0];
    if (segmentIndex == 0) {
        wholeTitle.text = @"Play Count";
    } else {
        wholeTitle.text = @"Time Played";
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:183.0f/255.0f green:226.0f/255.0f blue:252.0f/255.0f alpha:1.0f];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = backgroundView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:135.0f/255.0f green:206.0f/255.0f blue:250.0f/255.0f alpha:1.0f] CGColor], (id)[[UIColor colorWithRed:240.0f/255.0f green:248.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor], nil];
    [backgroundView.layer insertSublayer:gradient atIndex:0];
    smallView.layer.cornerRadius = 10;
    smallView.layer.borderWidth= 3;
    smallView.layer.borderColor = [UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1.0f].CGColor;
    
    
    songLabel.text = topSong.songTitle;
    artistLabel.text = topArtist.artistTitle;
    albumLabel.text = topAlbum.albumTitle;
    genreLabel.text = topGenre.genreTitle;
    
    songArtwork.image = topSong.albumArtwork;
    artistArtwork.image = [topArtist getArtwork];
    albumArtwork.image = topAlbum.artwork;
    genreArtwork.image = topGenre.artwork;
    if (segmentIndex == 0) {
        titleLabel.text = @"Total Play Count:";
        if (valueOfTotal == 1) {
            valueLabel.text = [NSString stringWithFormat:@"%ld play", valueOfTotal];
        } else {
            valueLabel.text = [NSString stringWithFormat:@"%ld plays", valueOfTotal];
        }
        
    } else {
        titleLabel.text = @"Total Time Played:";
        valueLabel.text = [self getTimePlayedString:valueOfTotal];
    }
    
    //[[UIColor colorWithRed:135.0f/255.0f green:206.0f/255.0f blue:250.0f/255.0f alpha:1.0f]
    
	// Do any additional setup after loading the view.
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
