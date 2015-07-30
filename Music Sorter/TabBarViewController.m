//
//  TabBarViewController.m
//  Music Sorter
//
//  Created by Mike Aboody on 10/27/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "TabBarViewController.h"
#import "SongViewController.h"
#import "GenreViewController.h"
#import "ArtistViewController.h"
#import "AlbumViewController.h"

@interface TabBarViewController ()

@end
static NSString *title;
@implementation TabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Songs";
    self.delegate = self;
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"General" style:UIBarButtonItemStyleDone
                                    target:self action:@selector(loadGeneralView)];
    
    //CHECK ERROR ABOVE
	// Do any additional setup after loading the view.
}

-(void) loadGeneralView
{
    [self performSegueWithIdentifier:@"tabToGeneral" sender:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tabBarController:(UITabBarController *)tbController shouldSelectViewController:(UIViewController *)viewController
{
    
    if ([viewController class] == [SongViewController class]) {
        self.navigationItem.title = @"Songs";
    } else if ([viewController class] == [GenreViewController class]) {
        self.navigationItem.title = @"Genres";
    } else if ([viewController class] == [ArtistViewController class]) {
        self.navigationItem.title = @"Artists";
    } else if ([viewController class] == [AlbumViewController class]) {
        self.navigationItem.title = @"Albums";
    }
    
    return YES;
}


@end
