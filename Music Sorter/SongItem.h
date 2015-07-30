//
//  SongItem.h
//  Music Sorter
//
//  Created by Mike Aboody on 10/21/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SongItem : NSObject
{
    long playCount;
    long durationOfSong;
    UIImage *albumArtwork;
    NSString *songTitle;
    NSString *artist;
    NSString *album;
    NSString *genre;
    
}

- (long) getTotalTime;
-(id) init : (long) playCountArg : (long) durationOfSongArg : (UIImage*) albumArtworkArg : (NSString*) artistArg : (NSString*) albumArg : (NSString*) genreArg : (NSString*) songTitleArg;
@property (nonatomic, readwrite) long playCount;
@property (nonatomic, readwrite) long durationOfSong;
@property (nonatomic, readwrite) UIImage *albumArtwork;
@property (nonatomic, readwrite) NSString *artist;
@property (nonatomic, readwrite) NSString *album;
@property (nonatomic, readwrite) NSString *songTitle;
@property (nonatomic, readwrite) NSString *genre;

@end
