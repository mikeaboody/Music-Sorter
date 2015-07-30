//
//  GenreItem.h
//  Music Sorter
//
//  Created by Mike Aboody on 10/22/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SongItem.h"

@interface GenreItem : NSObject
{
    NSString *genreTitle;
    long totalPlayCount;
    int songAmount;
    long totalTime;
    UIImage *artwork;
}

-(id) init : (NSString*) genreTitleArg : (long) totalPlayCountArg : (int) songAmountArg : (long) totalTimeArg : (UIImage*) artworkArg;

@property (nonatomic, readwrite) NSString *genreTitle;
@property (nonatomic, readwrite) long totalPlayCount;
@property (nonatomic, readwrite) int songAmount;
@property (nonatomic, readwrite) long totalTime;
@property (nonatomic, readwrite) UIImage *artwork;
@end
