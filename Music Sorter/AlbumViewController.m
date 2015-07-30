//
//  AlbumViewController.m
//  Music Sorter
//
//  Created by Mike Aboody on 10/27/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "AlbumViewController.h"
#import "AlbumCell.h"
#import "AlbumItem.h"
#import "DescriptionViewController.h"

@interface AlbumViewController ()

@end
static NSArray *albumList;
static int segmentIndex;
@implementation AlbumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+ (void) loadAlbumList:(NSArray *) arrayOfAlbums :(int)segmentIndexArg
{
    albumList = arrayOfAlbums;
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
    return [albumList count];
}
-(void)buttonInfo:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myCollectionView];
    NSIndexPath *indexPath = [self.myCollectionView indexPathForItemAtPoint:buttonPosition];
    if (indexPath != nil)
    {
        [DescriptionViewController passObject:[albumList objectAtIndex:indexPath.row]];
    }
    [self performSegueWithIdentifier:@"albumToDescription" sender:sender];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"AlbumID";
    AlbumCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    AlbumItem *tempAlbum = [albumList objectAtIndex:indexPath.row];
    [cell.artworkButton setBackgroundImage:tempAlbum.artwork forState:UIControlStateNormal];
    [cell.artworkButton addTarget:self action:@selector(buttonInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.albumLabel.text = [NSString stringWithFormat:@"%ld. %@",(long)(indexPath.row + 1), tempAlbum.albumTitle];
    
    if (segmentIndex == 0) {
        if (tempAlbum.totalPlayCount == 1) {
            cell.descriptionLabel.text = [NSString stringWithFormat:@"%ld play", tempAlbum.totalPlayCount];
        } else {
            cell.descriptionLabel.text = [NSString stringWithFormat:@"%ld plays", tempAlbum.totalPlayCount];
        }
    } else {
        cell.descriptionLabel.text = [NSString stringWithFormat:@"%@", [self getTimePlayedString:tempAlbum.totalTime]];
    }
    
    
    
    return cell;
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
