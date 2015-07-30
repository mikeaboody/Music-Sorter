//
//  AlbumViewController.h
//  Music Sorter
//
//  Created by Mike Aboody on 10/27/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>


+(void) loadAlbumList : (NSArray*) arrayOfAlbums : (int) segmentIndexArg;
-(NSString*) getTimePlayedString : (long) timePlayed;
-(void)buttonInfo:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@end
