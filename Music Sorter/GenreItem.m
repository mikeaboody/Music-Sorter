//
//  GenreItem.m
//  Music Sorter
//
//  Created by Mike Aboody on 10/22/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "GenreItem.h"
#import "SongItem.h"

@implementation GenreItem
@synthesize genreTitle, songAmount, totalPlayCount, totalTime, artwork;

-(id) init : (NSString*) genreTitleArg : (long) totalPlayCountArg : (int) songAmountArg : (long) totalTimeArg : (UIImage*) artworkArg;
{
    genreTitle = genreTitleArg;
    totalPlayCount = totalPlayCountArg;
    totalTime = totalTimeArg;
    songAmount = songAmountArg;
    artwork = artworkArg;
    return self;
}

- (NSComparisonResult)comparePlayCount:(GenreItem *)otherObject {
    return [[NSNumber numberWithLong:otherObject.totalPlayCount] compare:[NSNumber numberWithLong:self.totalPlayCount]];
}

- (NSComparisonResult)compareTotalTime:(GenreItem *)otherObject {
    return [[NSNumber numberWithLong:otherObject.totalTime] compare:[NSNumber numberWithLong:self.totalTime]];
}

@end
