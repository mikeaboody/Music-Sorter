//
//  AlbumItem.h
//  Music Sorter
//
//  Created by Mike Aboody on 10/22/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlbumItem : NSObject
{
    NSString *albumTitle;
    long totalPlayCount;
    int songAmount;
    long totalTime;
    NSString *artistTitle;
    UIImage *artwork;
}

-(id) init : (NSString*) albumTitleArg : (long) totalPlayCountArg : (int) songAmountArg : (long) totalTimeArg : (UIImage*) artworkArg : (NSString*) artistTitleArg;

@property (nonatomic, readwrite) NSString *albumTitle;
@property (nonatomic, readwrite) long totalPlayCount;
@property (nonatomic, readwrite) int songAmount;
@property (nonatomic, readwrite) long totalTime;
@property (nonatomic, readwrite) UIImage *artwork;
@property (nonatomic, readwrite) NSString *artistTitle;
@end
