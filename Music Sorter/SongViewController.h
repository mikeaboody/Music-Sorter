//
//  SongViewController.h
//  Music Sorter
//
//  Created by Mike Aboody on 10/23/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SongItem.h"

@interface SongViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

+(void) loadSongList : (NSArray*) arrayOfSongs : (int) segmentIndexArg;
-(NSString*) getTimePlayedString : (long) timePlayed;

@end
