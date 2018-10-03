//
//  MusicPlayerVC.h
//  AppleMusicUserLibraryPlaybackExample
//
//  Created by Ryan Higgins on 10/3/18.
//  Copyright © 2018 Ryan Higgins. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MediaPlayer;

@interface MusicPlayerVC : UIViewController

+ (MusicPlayerVC *)sharedInstance;

@property (nonatomic, strong) MPMusicPlayerController *musicPlayer;

@end
