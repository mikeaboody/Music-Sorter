//
//  StartViewController.h
//  Music Sorter
//
//  Created by Mike Aboody on 10/21/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SongItem.h"
#import "ArtistItem.h"
#import "GenreItem.h"
#import "AlbumItem.h"
#import "SongViewController.h"

@interface StartViewController : UIViewController
{
    IBOutlet UIView *backgroundView;
    UISegmentedControl *sortSegmentChooser;
    UIActivityIndicatorView *activityView;
    IBOutlet UIButton *sortButton;
    NSMutableArray *songItemList;
    NSMutableArray *artistItemList;
    NSMutableArray *albumItemList;
    NSMutableArray *genreItemList;
    long overallTime;
    long overallPlayCount;
    IBOutlet UIView *iconBackgroundView;
    int problem;
}

-(void) arrangeInfo;
-(IBAction)clickButton:(id)sender;
-(void)startActivity;
-(void) loadHelp;




@end
