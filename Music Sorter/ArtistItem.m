//
//  ArtistItem.m
//  Music Sorter
//
//  Created by Mike Aboody on 10/22/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "ArtistItem.h"
#import "SongItem.h"

@implementation ArtistItem
@synthesize songList, artistTitle;

-(id) init : (NSMutableArray*) songListArg : (NSString*) artistTitleArg
{
    songList = songListArg;
    artistTitle = artistTitleArg;
    return self;
}
-(long) getTotalPlayCount
{
    long total = 0;
    for (SongItem *song in songList) {
        total += song.playCount;
    }
    return total;
}
-(int) getSongAmount
{
    return (int)[songList count];
}
-(long) getTotalTime
{
    long total = 0;
    for (SongItem *song in songList) {
        total += [song getTotalTime];
    }
    return total;
}

- (NSComparisonResult)comparePlayCount:(ArtistItem *)otherObject {
    return [[NSNumber numberWithLong:[otherObject getTotalPlayCount]] compare:[NSNumber numberWithLong:[self getTotalPlayCount]]];
}

- (NSComparisonResult)compareTotalTime:(ArtistItem *)otherObject {
    return [[NSNumber numberWithLong:[otherObject getTotalTime]] compare:[NSNumber numberWithLong:[self getTotalTime]]];
}
-(UIImage*) getArtwork
{
    for (SongItem *song in songList) {
        if (![song.albumArtwork isEqual: [UIImage imageNamed:@"thedefaultpic.png"]]) {
            return song.albumArtwork;
        }
    }
    return [UIImage imageNamed:@"thedefaultpic.png"];
}

@end
