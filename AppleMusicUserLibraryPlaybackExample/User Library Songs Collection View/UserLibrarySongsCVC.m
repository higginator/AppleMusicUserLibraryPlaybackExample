//
//  UserLibrarySongsCVC.m
//  AppleMusicUserLibraryPlaybackExample
//
//  Created by Ryan Higgins on 10/3/18.
//  Copyright © 2018 Ryan Higgins. All rights reserved.
//

#import "UserLibrarySongsCVC.h"
#import "UserLibrarySongsDataSource.h"
#import "UserLibraryConstants.h"
#import "AppleMusicNetworkController.h"
#import "AppleMusicAuthorizationController.h"

@interface UserLibrarySongsCVC ()

@property (nonatomic, strong) UserLibrarySongsDataSource *userLibraryDataSource;

@end

@implementation UserLibrarySongsCVC

- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        UserLibrarySongsDataSource *dataSource = [[UserLibrarySongsDataSource alloc] init];
        _userLibraryDataSource = dataSource;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor blackColor];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"UserLibrarySongCell" bundle:nil] forCellWithReuseIdentifier:UserLibrarySongCellReuseIdentifier];
    self.collectionView.dataSource = self.userLibraryDataSource;
    self.collectionView.delegate = self.userLibraryDataSource;
    
    [self setNavBarItems];
    
    
    NSLog(@"user library view did load");
//    [AppleMusicNetworkController getAppleMusicUserLibrarySongsWithCompletion:^(BOOL success, NSDictionary *results) {
//        if (success) {
//            [self.userLibraryDataSource updateSongsWithData:results];
//            [self.collectionView reloadData];
//        }
//    }];
}


- (void)setNavBarItems {
    // set authorize apple music button
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    [customView setTitle:@"Authorize" forState:UIControlStateNormal];
    [customView addTarget:self action:@selector(authorizeAppleMusic) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *authorizeAppleMusicButton = [[UIBarButtonItem alloc] initWithCustomView:customView];
    self.navigationItem.leftBarButtonItem = authorizeAppleMusicButton;
    
    // set request apple music user library songs button
    UIButton *requestSongsCustomView = [UIButton buttonWithType:UIButtonTypeCustom];
    [requestSongsCustomView setTitle:@"Request Songs" forState:UIControlStateNormal];
    [requestSongsCustomView addTarget:self action:@selector(requestAppleMusicSongs) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *requestAppleMusicSongsButton = [[UIBarButtonItem alloc] initWithCustomView:requestSongsCustomView];
    self.navigationItem.rightBarButtonItem = requestAppleMusicSongsButton;
}

#pragma mark - Authorize Apple Music

- (void)authorizeAppleMusic {
    NSLog(@"authorize");
    [AppleMusicAuthorizationController authorizeAppleMusic];
}

#pragma mark - Request Apple Music Songs

- (void)requestAppleMusicSongs {
    NSLog(@"request");
    [AppleMusicNetworkController getAppleMusicUserLibrarySongsWithCompletion:^(BOOL success, NSDictionary *results) {
        if (success) {
            NSLog(@"results: %@", results);
            [self.userLibraryDataSource updateSongsWithData:results];
            [self.collectionView reloadData];
        }
    }];
}

@end
