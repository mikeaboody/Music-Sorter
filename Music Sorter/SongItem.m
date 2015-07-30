//
//  SongItem.m
//  Music Sorter
//
//  Created by Mike Aboody on 10/21/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "SongItem.h"

@implementation SongItem
@synthesize playCount, durationOfSong, albumArtwork, artist, album, genre, songTitle;
-(id) init : (long) playCountArg : (long) durationOfSongArg : (UIImage*) albumArtworkArg : (NSString*) artistArg : (NSString*) albumArg : (NSString*) genreArg : (NSString*) songTitleArg;
{
    playCount = playCountArg;
    durationOfSong = durationOfSongArg;
    albumArtwork = albumArtworkArg;
    artist = artistArg;
    album = albumArg;
    genre = genreArg;
    songTitle = songTitleArg;
    
    return self;
}

-(long) getTotalTime
{
    return playCount * durationOfSong;
}

- (NSComparisonResult)compareArtist:(SongItem *)otherObject {
    return [self.artist compare:otherObject.artist];
}

- (NSComparisonResult)compareGenre:(SongItem *)otherObject {
    return [self.genre compare:otherObject.genre];
}

- (NSComparisonResult)compareAlbum:(SongItem *)otherObject {
    return [self.album compare:otherObject.album];
}

- (NSComparisonResult)comparePlayCount:(SongItem *)otherObject {
    return [[NSNumber numberWithLong:otherObject.playCount] compare:[NSNumber numberWithLong:self.playCount]];
}

- (NSComparisonResult)compareTotalTime:(SongItem *)otherObject {
    return [[NSNumber numberWithLong:[otherObject getTotalTime]] compare:[NSNumber numberWithLong:[self getTotalTime]]];
}


@end
