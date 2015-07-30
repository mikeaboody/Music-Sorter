//
//  GenreViewController.h
//  Music Sorter
//
//  Created by Mike Aboody on 10/26/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

+(void) loadGenreList : (NSArray*) arrayOfGenres : (int) segmentIndexArg;
-(NSString*) getTimePlayedString : (long) timePlayed;

@end
