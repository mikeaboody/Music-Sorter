//
//  ArtistItem.h
//  Music Sorter
//
//  Created by Mike Aboody on 10/22/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SongItem.h"

@interface ArtistItem : NSObject
{
    UIImage *artwork;
    NSString *artistTitle;
    NSMutableArray *songList;
}

-(long) getTotalPlayCount;
-(int) getSongAmount;
-(long) getTotalTime;
-(id) init : (NSMutableArray*) songListArg : (NSString*) artistTitleArg;
-(UIImage*) getArtwork;

@property (nonatomic, readwrite) NSMutableArray *songList;
@property (nonatomic, readwrite) NSString *artistTitle;

@end
