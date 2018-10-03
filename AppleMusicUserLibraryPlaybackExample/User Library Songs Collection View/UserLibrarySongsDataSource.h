//
//  UserLibrarySongsDataSource.h
//  AppleMusicUserLibraryPlaybackExample
//
//  Created by Ryan Higgins on 10/3/18.
//  Copyright © 2018 Ryan Higgins. All rights reserved.
//

@import UIKit;

@interface UserLibrarySongsDataSource : NSObject <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

- (void)updateSongsWithData:(NSDictionary *)appleMusicSongsData;


@end
