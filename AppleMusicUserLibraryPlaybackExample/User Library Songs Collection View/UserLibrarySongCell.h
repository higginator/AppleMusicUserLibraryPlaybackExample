//
//  UserLibrarySongCell.h
//  AppleMusicUserLibraryPlaybackExample
//
//  Created by Ryan Higgins on 10/3/18.
//  Copyright © 2018 Ryan Higgins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserLibrarySongCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *songName;
@property (weak, nonatomic) IBOutlet UILabel *artistName;

@end
