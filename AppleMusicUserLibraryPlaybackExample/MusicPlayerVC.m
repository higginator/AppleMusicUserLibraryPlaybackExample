//
//  MusicPlayerVC.m
//  AppleMusicUserLibraryPlaybackExample
//
//  Created by Ryan Higgins on 10/3/18.
//  Copyright © 2018 Ryan Higgins. All rights reserved.
//

#import "MusicPlayerVC.h"

@interface MusicPlayerVC ()

@end

@implementation MusicPlayerVC

+ (MusicPlayerVC *)sharedInstance {
    static MusicPlayerVC *musicPlayerVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        musicPlayerVC = [[MusicPlayerVC alloc] init];
    });
    return musicPlayerVC;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _musicPlayer = [MPMusicPlayerController systemMusicPlayer];
        [_musicPlayer beginGeneratingPlaybackNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNowPlayingItemDidChange) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification
                                                   object:_musicPlayer];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMusicPlaybackStateDidChange) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                                                   object:_musicPlayer];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - MPMusicPlayerController Notifications

- (void)handleNowPlayingItemDidChange {
    if (self.musicPlayer.indexOfNowPlayingItem != NSNotFound) {
        
    } else {
        // no song in music player queue
        NSLog(@"index of now playing item is nil");
    }
}

- (void)handleMusicPlaybackStateDidChange {
    switch (self.musicPlayer.playbackState) {
        case MPMusicPlaybackStateStopped:
            NSLog(@"music playback stopped");
            // playlist, song, album ended
            break;
        case MPMusicPlaybackStatePlaying:
            NSLog(@"music playback playing");
            break;
        case MPMusicPlaybackStatePaused:
            NSLog(@"music playback paused");
            break;
        case MPMusicPlaybackStateInterrupted:
            NSLog(@"music playback interrupted");
            break;
        case MPMusicPlaybackStateSeekingForward:
            NSLog(@"music playback seeking forward");
            break;
        case MPMusicPlaybackStateSeekingBackward:
            NSLog(@"music playback seeking backward");
            break;
    }
}


@end
