//
//  ArtistViewController.m
//  Music Sorter
//
//  Created by Mike Aboody on 10/27/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "ArtistViewController.h"
#import "ArtistCell.h"
#import "ArtistItem.h"
#import "DescriptionViewController.h"

@interface ArtistViewController ()

@end
static NSArray *artistList;
static int segmentIndex;
@implementation ArtistViewController
@synthesize myCollectionView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+ (void) loadArtistList:(NSArray *)arrayOfArtists :(int)segmentIndexArg
{
    artistList = arrayOfArtists;
    segmentIndex = segmentIndexArg;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self myCollectionView] setDataSource:self];
    [[self myCollectionView] setDelegate:self];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [artistList count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ArtistID";
    ArtistCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    ArtistItem *tempArtist = [artistList objectAtIndex:indexPath.row];
    [cell.artworkButton setBackgroundImage:[tempArtist getArtwork] forState:UIControlStateNormal];
    
    [cell.artworkButton addTarget:self action:@selector(buttonInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.artistLabel.text = [NSString stringWithFormat:@"%ld. %@",(long)(indexPath.row + 1), tempArtist.artistTitle];
    
    if (segmentIndex == 0) {
        if (tempArtist.getTotalPlayCount == 1) {
            cell.descriptionLabel.text = [NSString stringWithFormat:@"%ld play", tempArtist.getTotalPlayCount];
        } else {
            cell.descriptionLabel.text = [NSString stringWithFormat:@"%ld plays", tempArtist.getTotalPlayCount];
        }
    } else {
      cell.descriptionLabel.text = [NSString stringWithFormat:@"%@", [self getTimePlayedString:tempArtist.getTotalTime]];
    }
    
    return cell;
}

-(void)buttonInfo:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myCollectionView];
    NSIndexPath *indexPath = [self.myCollectionView indexPathForItemAtPoint:buttonPosition];
    if (indexPath != nil)
    {
        [DescriptionViewController passObject:[artistList objectAtIndex:indexPath.row]];
    }
    [self performSegueWithIdentifier:@"artistToDescription" sender:sender];
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
