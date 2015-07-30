//
//  AlbumItem.m
//  Music Sorter
//
//  Created by Mike Aboody on 10/22/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "AlbumItem.h"

@implementation AlbumItem
@synthesize albumTitle, songAmount, totalPlayCount, totalTime, artwork, artistTitle;

-(id) init : (NSString*) albumTitleArg : (long) totalPlayCountArg : (int) songAmountArg : (long) totalTimeArg : (UIImage*) artworkArg : (NSString*) artistTitleArg
{
    albumTitle = albumTitleArg;
    totalPlayCount = totalPlayCountArg;
    totalTime = totalTimeArg;
    songAmount = songAmountArg;
    artwork = artworkArg;
    artistTitle = artistTitleArg;
    return self;
}

- (NSComparisonResult)comparePlayCount:(AlbumItem *)otherObject {
    return [[NSNumber numberWithLong:otherObject.totalPlayCount] compare:[NSNumber numberWithLong:self.totalPlayCount]];
}

- (NSComparisonResult)compareTotalTime:(AlbumItem *)otherObject {
    return [[NSNumber numberWithLong:otherObject.totalTime] compare:[NSNumber numberWithLong:self.totalTime]];
}

- (NSComparisonResult)compareAlpha:(AlbumItem *)otherObject {
    return [self.albumTitle compare:otherObject.albumTitle];
}


@end
