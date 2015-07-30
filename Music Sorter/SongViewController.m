//
//  SongViewController.m
//  Music Sorter
//
//  Created by Mike Aboody on 10/23/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "SongViewController.h"
#import "SongItem.h"
#import "SongTableCell.h"
#import "DescriptionViewController.h"
@interface SongViewController ()

@end

static NSArray *songList;
static int segmentIndex;
@implementation SongViewController
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
    self.title = @"Songs";
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void) loadSongList : (NSArray*) arrayOfSongs : (int) segmentIndexArg
{
    songList = arrayOfSongs;
    segmentIndex = segmentIndexArg;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [songList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SongTableCell";
    
    SongTableCell *cell = (SongTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SongTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    SongItem *tempSong = [songList objectAtIndex:indexPath.row];
    cell.songNameLabel.text = tempSong.songTitle;
    if (segmentIndex == 0) {
        cell.characteristicInfoLabel.text = [NSString stringWithFormat:@"Play Count: %ld", tempSong.playCount];
    } else {
        cell.characteristicInfoLabel.text = [NSString stringWithFormat:@"Time Played: %@", [self getTimePlayedString:[tempSong getTotalTime]]];
    }
    cell.thumbnailImageView.image = tempSong.albumArtwork;
    cell.sortLabel.text = [NSString stringWithFormat:@"%ld",(long)(indexPath.row + 1)];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [DescriptionViewController passObject:[songList objectAtIndex:indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"songToDescription" sender:nil];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 129;
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
    if (numDays == 1) {
        numDayString = [NSString stringWithFormat:@"%ld day",numDays];
    } else {
        numDayString = [NSString stringWithFormat:@"%ld days",numDays];
    }
    
    NSString *numHourString;
    if (numHours == 1) {
        numHourString = [NSString stringWithFormat:@"%ld hour",numHours];
    } else {
        numHourString = [NSString stringWithFormat:@"%ld hours",numHours];
    }
    
    NSString *numMinuteString;
    if (numMinutes == 1) {
        numMinuteString = [NSString stringWithFormat:@"%ld minute",numMinutes];
    } else {
        numMinuteString = [NSString stringWithFormat:@"%ld minutes",numMinutes];
    }
    
    NSString *numSecondString;
    if (numSeconds == 1) {
        numSecondString = [NSString stringWithFormat:@"%ld second",numSeconds];
    } else {
        numSecondString = [NSString stringWithFormat:@"%ld seconds",numSeconds];
    }
    
    
    
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
