//
//  StartViewController.m
//  Music Sorter
//
//  Created by Mike Aboody on 10/21/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

//3.5 and test- description mainly maybe title
//CHECK- Fix 0 songs stuff and other fix stuff
//CHECK- Finalize title screen and progress bar
//Main icons
//CHECK- border around total play count
//CHECK- Fix artists and albums labels with nsattributed string
//CHECK- help icon
//CHECK- MEMORY

#import "StartViewController.h"
#import "SongItem.h"
#import "ArtistItem.h"
#import "GenreItem.h"
#import "GenreViewController.h"
#import "AlbumItem.h"
#import "SongViewController.h"
#import "ArtistViewController.h"
#import "AlbumViewController.h"
#import "GeneralViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

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
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    sortSegmentChooser = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Play Count", @"Time Played", nil]];
    sortSegmentChooser.selectedSegmentIndex = 0;
    sortSegmentChooser.center = CGPointMake(135, 277);
    CGRect frame= sortSegmentChooser.frame;
    [sortSegmentChooser setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width + 50, 60)];
    UIFont *font = [UIFont boldSystemFontOfSize:15.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [sortSegmentChooser setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
    
    iconBackgroundView.layer.cornerRadius = 100;
    iconBackgroundView.backgroundColor = [UIColor colorWithRed:153.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    iconBackgroundView.layer.borderWidth= 1;
    iconBackgroundView.layer.borderColor = [UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1.0f].CGColor;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStyleDone target:self action:@selector(loadHelp)];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = backgroundView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:135.0f/255.0f green:206.0f/255.0f blue:250.0f/255.0f alpha:1.0f] CGColor], (id)[[UIColor colorWithRed:240.0f/255.0f green:248.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor], nil];
    [backgroundView.layer insertSublayer:gradient atIndex:0];
    [backgroundView addSubview:sortSegmentChooser];
    sortButton.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.8f];
    self.navigationItem.title = @"Music Sorter";
    sortButton.layer.cornerRadius = 15;
    [[sortButton layer] setBorderWidth:1.0f];
    [[sortButton layer] setBorderColor:[UIColor colorWithRed:192.0f/255.0f green:192.0f/255.0f blue:192.0f/255.0f alpha:1.0f].CGColor];
    overallPlayCount = 0;
    overallTime = 0;
    if(self.view.bounds.size.height == 568) {
        activityView.center = CGPointMake(161, 450);
    } else {
        activityView.center = CGPointMake(275, 377);
    }
    
    activityView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    [backgroundView addSubview:activityView];
    [sortButton addTarget:self action:@selector(startActivity) forControlEvents: UIControlEventTouchDown];
	// CHECK MEMORY STUFF
   
}
-(void)startActivity
{
    [activityView startAnimating];
}
-(IBAction)clickButton:(id)sender
{
    NSArray *sendSongList;
    NSArray *sendArtistList;
    NSArray *sendAlbumList;
    NSArray *sendGenreList;
    int segmentIndex = 0;
    
    if ([sortSegmentChooser selectedSegmentIndex] == 0) {
        [self arrangeInfo];
        if (problem == 1) {
            [activityView stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"You must have at least one song in your iTunes library before this application can sort your music." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        if (problem == 2) {
            [activityView stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"At least one song in your iTunes library must have an artist specified before this application can sort your music." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        if (problem == 3) {
            [activityView stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"At least one song in your iTunes library must have an album specified before this application can sort your music." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        if (problem == 4) {
            [activityView stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"At least one song in your iTunes library must have an genre specified before this application can sort your music." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        sendSongList = [songItemList sortedArrayUsingSelector:@selector(comparePlayCount:)];
        sendArtistList = [artistItemList sortedArrayUsingSelector:@selector(comparePlayCount:)];
        sendAlbumList = [albumItemList sortedArrayUsingSelector:@selector(comparePlayCount:)];
        sendGenreList = [genreItemList sortedArrayUsingSelector:@selector(comparePlayCount:)];
    } else if([sortSegmentChooser selectedSegmentIndex] == 1) {
        segmentIndex = 1;
        [self arrangeInfo];
        if (problem == 1) {
            [activityView stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"You must have at least one song in your iTunes library before this application can sort your music." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        if (problem == 2) {
            [activityView stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"At least one song in your iTunes library must have an artist specified before this application can sort your music." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        if (problem == 3) {
            [activityView stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"At least one song in your iTunes library must have an album specified before this application can sort your music." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        if (problem == 4) {
            [activityView stopAnimating];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"At least one song in your iTunes library must have an genre specified before this application can sort your music." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        sendSongList = [songItemList sortedArrayUsingSelector:@selector(compareTotalTime:)];
        sendArtistList = [artistItemList sortedArrayUsingSelector:@selector(compareTotalTime:)];
        sendAlbumList = [albumItemList sortedArrayUsingSelector:@selector(compareTotalTime:)];
        sendGenreList = [genreItemList sortedArrayUsingSelector:@selector(compareTotalTime:)];
    }
    [SongViewController loadSongList:sendSongList:segmentIndex];
    [GenreViewController loadGenreList:sendGenreList :segmentIndex];
    [ArtistViewController loadArtistList:sendArtistList :segmentIndex];
    [AlbumViewController loadAlbumList:sendAlbumList :segmentIndex];
    
    long valueSend;
    if (segmentIndex == 0) {
        valueSend = overallPlayCount;
    } else {
        valueSend = overallTime;
    }
    [GeneralViewController loadInfo:[sendSongList objectAtIndex:0] :[sendArtistList objectAtIndex:0] :[sendAlbumList objectAtIndex:0] :[sendGenreList objectAtIndex:0] :valueSend :segmentIndex];
    [activityView stopAnimating];
    [self performSegueWithIdentifier:@"startToTab" sender:sender];

}
- (void) loadHelp
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"About" message:@"This application sorts your music by play count and time played. It will then organize these results into four categories: songs, artists, albums, and genres.\n\nTip: the more organized your iTunes library is, the better your results will be displayed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Memory Warning" message:@"Some features of the application may not work properly since there is very little memory left on your device. In order to ensure full functionality, free some of your device's memory or try closing some of your other running applications." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    // Dispose of any resources that can be recreated.
}

-(void) arrangeInfo
{
    songItemList = [[NSMutableArray alloc] init];
    
    //CHECK FOR NO SONGS
    //SONGS
    MPMediaPropertyPredicate *predicate = [MPMediaPropertyPredicate predicateWithValue:[NSNumber numberWithInteger:MPMediaTypeMusic] forProperty:MPMediaItemPropertyMediaType];
    //MPMediaPropertyPredicate *secondpredicate = [MPMediaPropertyPredicate predicateWithValue:[NSNumber numberWithInteger:MPMediaTypeMusic] forProperty:MPMediaItemPropertyIsCloudItem];
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    [everything addFilterPredicate:predicate];
    //[everything removeFilterPredicate:secondpredicate];
    
    NSArray *itemsFromGenericQuery = [everything items];
    if ([itemsFromGenericQuery count] == 0) {
        problem = 1;
        return;
    }
    for (MPMediaItem *song in itemsFromGenericQuery) {
        long playCount = [[song valueForProperty: MPMediaItemPropertyPlayCount] integerValue];
        long durationOfSong =[[song valueForProperty: MPMediaItemPropertyPlaybackDuration] integerValue];
        UIImage *albumArtwork = [[song valueForProperty: MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(120.0, 120.0)];
        if ([albumArtwork isKindOfClass:[NSNull class]] || albumArtwork == nil) {
            albumArtwork =[UIImage imageNamed:@"thedefaultpic.png"];
        }
        NSString *artist = [song valueForProperty: MPMediaItemPropertyArtist];
        NSString *album = [song valueForProperty: MPMediaItemPropertyAlbumTitle];
        NSString *genre = [song valueForProperty: MPMediaItemPropertyGenre];
        NSString *songTitle = [song valueForProperty: MPMediaItemPropertyTitle];
        [songItemList addObject:[[SongItem alloc] init:playCount:durationOfSong:albumArtwork:artist:album:genre: songTitle]];
        
    }
    //END SONGS
    //OVERALL
    overallPlayCount = 0;
    overallTime = 0;
    for (SongItem *song in songItemList) {
        overallPlayCount += song.playCount;
        overallTime += [song getTotalTime];
    }
    //END OVERALL
    
    //ARTISTS
    artistItemList = [[NSMutableArray alloc] init];
    NSMutableArray *sortedByArtist;
    sortedByArtist = [[songItemList sortedArrayUsingSelector:@selector(compareArtist:)] mutableCopy];
    for (int i = 0; i < [sortedByArtist count]; i++) {
        SongItem *tempSongItem = [sortedByArtist objectAtIndex:i];
        if ([tempSongItem.artist isKindOfClass:[NSNull class]] || tempSongItem.artist == nil || [tempSongItem.artist isEqualToString:@""]) {
            [sortedByArtist removeObject:tempSongItem];
            i--;
        } else {
            break;
        }
    }
    if ([sortedByArtist count] == 0) {
        problem = 2;
        return;
    }
    
    NSMutableArray *tempSongList = [[NSMutableArray alloc] init];
    NSString *currentArtist = @"";
    for (SongItem *song in sortedByArtist) {
        if([@"" isEqualToString:currentArtist]){
            currentArtist = song.artist;
            [tempSongList addObject:song];
            continue;
        }
        if(![song.artist isEqualToString:currentArtist]){
            [artistItemList addObject:[[ArtistItem alloc] init:tempSongList:currentArtist]];
            tempSongList = nil;
            tempSongList = [[NSMutableArray alloc] init];
            [tempSongList addObject:song];
            currentArtist = song.artist;
        } else {
            [tempSongList addObject:song];
        }
    }
    //END ARTISTS
    
    //GENRES
    
    genreItemList = [[NSMutableArray alloc] init];
    NSMutableArray *sortedByGenre;
    sortedByGenre = [[songItemList sortedArrayUsingSelector:@selector(compareGenre:)] mutableCopy];
    for (int i = 0; i < [sortedByGenre count]; i++) {
        SongItem *tempSongItem = [sortedByGenre objectAtIndex:i];
        if ([tempSongItem.genre isKindOfClass:[NSNull class]] || tempSongItem.genre == nil || [tempSongItem.genre isEqualToString:@""]) {
            [sortedByGenre removeObject:tempSongItem];
            i--;
        } else {
            break;
        }
    }
    if ([sortedByGenre count] == 0) {
        problem = 4;
        return;
    }
    
    long tempTotalTime = 0;
    long tempTotalPlayCount = 0;
    int tempSongAmount = 0;
    //UIImage *tempImage = [UIImage imageNamed:@"thedefaultpic.png"];
    UIImage *tempImage = nil;
    NSString *currentGenre = @"";
    for (SongItem *song in sortedByGenre) {
        if([@"" isEqualToString:currentGenre]){
            currentGenre = song.genre;
            tempTotalPlayCount += song.playCount;
            tempTotalTime += [song getTotalTime];
            tempSongAmount++;
            if (!([song.albumArtwork isEqual: [UIImage imageNamed:@"thedefaultpic.png"]])) {
                tempImage = song.albumArtwork;
            }
            continue;
        }
        if(![song.genre isEqualToString:currentGenre]){
            if ([tempImage isKindOfClass:[NSNull class]] || tempImage == nil) {
                tempImage = [UIImage imageNamed:@"thedefaultpic.png"];
            }
            [genreItemList addObject:[[GenreItem alloc] init:currentGenre:tempTotalPlayCount:tempSongAmount:tempTotalTime:tempImage]];
            tempTotalPlayCount = song.playCount;
            tempTotalTime = [song getTotalTime];
            tempSongAmount=1;
            tempImage = nil;
            if (!([song.albumArtwork isEqual: [UIImage imageNamed:@"thedefaultpic.png"]])) {
                tempImage = song.albumArtwork;
            }
            currentGenre = song.genre;
            
        } else {
            tempTotalPlayCount += song.playCount;
            tempTotalTime += [song getTotalTime];
            tempSongAmount++;
            if (!([song.albumArtwork isEqual: [UIImage imageNamed:@"thedefaultpic.png"]]) && ([tempImage isKindOfClass:[NSNull class]] || tempImage == nil)) {
                tempImage = song.albumArtwork;
            }
        }
    }
    //END GENRES
    
    
    //ALBUMS
    albumItemList = [[NSMutableArray alloc] init];
    
    NSMutableArray *sortedByAlbum;
    sortedByAlbum = [[songItemList sortedArrayUsingSelector:@selector(compareAlbum:)] mutableCopy];
    for (int i = 0; i < [sortedByAlbum count]; i++) {
        SongItem *tempSongItem = [sortedByAlbum objectAtIndex:i];
        if ([tempSongItem.album isKindOfClass:[NSNull class]] || tempSongItem.album == nil || [tempSongItem.album isEqualToString:@""]) {
            [sortedByAlbum removeObject:tempSongItem];
            i--;
        } else {
            break;
        }
    }
    if ([sortedByAlbum count] == 0) {
        problem = 3;
        return;
    }
    
    tempTotalTime = 0;
    tempTotalPlayCount = 0;
    tempSongAmount = 0;
    //UIImage *tempImage = [UIImage imageNamed:@"thedefaultpic.png"];
    tempImage = nil;
    NSString *currentAlbum = @"";
    NSString *currentArtistofAlbum = @"";
    for (SongItem *song in sortedByAlbum) {
        if([@"" isEqualToString:currentAlbum]){
            currentAlbum = song.album;
            currentArtistofAlbum = song.artist;
            tempTotalPlayCount += song.playCount;
            tempTotalTime += [song getTotalTime];
            tempSongAmount++;
            if (!([song.albumArtwork isEqual: [UIImage imageNamed:@"thedefaultpic.png"]])) {
                tempImage = song.albumArtwork;
            }
            continue;
        }
        if(![song.album isEqualToString:currentAlbum]){
            if ([tempImage isKindOfClass:[NSNull class]] || tempImage == nil) {
                tempImage = [UIImage imageNamed:@"thedefaultpic.png"];
            }
            [albumItemList addObject:[[AlbumItem alloc] init:currentAlbum:tempTotalPlayCount:tempSongAmount:tempTotalTime:tempImage: currentArtistofAlbum]];
            tempTotalPlayCount = song.playCount;
            tempTotalTime = [song getTotalTime];
            tempSongAmount=1;
            tempImage = nil;
            currentArtistofAlbum = song.artist;
            if (!([song.albumArtwork isEqual: [UIImage imageNamed:@"thedefaultpic.png"]])) {
                tempImage = song.albumArtwork;
            }
            currentAlbum = song.album;
            
        } else {
            tempTotalPlayCount += song.playCount;
            tempTotalTime += [song getTotalTime];
            tempSongAmount++;
            if (!([song.albumArtwork isEqual: [UIImage imageNamed:@"thedefaultpic.png"]]) && ([tempImage isKindOfClass:[NSNull class]] || tempImage == nil)) {
                tempImage = song.albumArtwork;
            }
        }
    }
    
    
    //END ALBUMS

}



@end
