//
//  UserLibrarySongsDataSource.m
//  AppleMusicUserLibraryPlaybackExample
//
//  Created by Ryan Higgins on 10/3/18.
//  Copyright © 2018 Ryan Higgins. All rights reserved.
//

#import "UserLibrarySongsDataSource.h"
#import "UserLibraryConstants.h"
#import "UserLibrarySongCell.h"
#import "MusicPlayerVC.h"

@interface UserLibrarySongsDataSource ()

@property (nonatomic, strong) NSArray *userSongs;

@end

@implementation UserLibrarySongsDataSource

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        _userSongs = [NSArray array];
    }
    return self;
}

#pragma mark - Data Updates

- (void)updateSongsWithData:(NSDictionary *)appleMusicSongsData {
    NSArray *songsData = [appleMusicSongsData objectForKey:@"data"];
    //NSLog(@"songs data is %@", songsData);
    self.userSongs = songsData;
//    NSMutableArray *appleMusicUserLibrarySongs = [[NSMutableArray alloc] init];
//    for (NSDictionary *songData in songsData) {
//        SNGSWPAppleMusicUserLibrarySong *userLibrarySong = [[SNGSWPAppleMusicUserLibrarySong alloc] initWithData:songData];
//        [appleMusicUserLibrarySongs addObject:userLibrarySong];
//    }
//
//    self.userSongs = appleMusicUserLibrarySongs;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.userSongs count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UserLibrarySongCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UserLibrarySongCellReuseIdentifier forIndexPath:indexPath];
    
    NSDictionary *songData = [self.userSongs objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor blackColor];
    cell.songName.text = [[songData objectForKey:@"attributes"] objectForKey:@"name"];
    cell.artistName.text = [[songData objectForKey:@"attributes"] objectForKey:@"artistName"];

    return cell;
}

#pragma mark - Layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, 75);
}

#pragma mark - Cell Selection

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *appleMusicUserLibrarySong = self.userSongs[indexPath.row];
    NSString *songUserLibraryID = [appleMusicUserLibrarySong objectForKey:@"id"];
    NSLog(@"user library storeID is %@", songUserLibraryID);
    
    MusicPlayerVC *musicPlayerVC = [MusicPlayerVC sharedInstance];
    
    [musicPlayerVC.musicPlayer setQueueWithStoreIDs:@[songUserLibraryID]];
    [musicPlayerVC.musicPlayer
     prepareToPlayWithCompletionHandler:^(NSError * _Nullable error) {
         if (error) {
             NSLog(@"error is %@", error);
         } else {
             [musicPlayerVC.musicPlayer play];
             NSLog(@"now playing item: %@ %@ %f", musicPlayerVC.musicPlayer.nowPlayingItem.title, musicPlayerVC.musicPlayer.nowPlayingItem.artist, musicPlayerVC.musicPlayer.nowPlayingItem.playbackDuration);
         }
     }];
}

@end
