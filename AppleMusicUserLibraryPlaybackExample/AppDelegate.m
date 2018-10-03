//
//  AppDelegate.m
//  AppleMusicUserLibraryPlaybackExample
//
//  Created by Ryan Higgins on 10/3/18.
//  Copyright © 2018 Ryan Higgins. All rights reserved.
//

#import "AppDelegate.h"
#import "UserLibrarySongsCVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // create user library collection view controller
    UICollectionViewFlowLayout *userLibraryLayout = [[UICollectionViewFlowLayout alloc] init];
    userLibraryLayout.itemSize = CGSizeMake([UIApplication sharedApplication].delegate.window.frame.size.width, 75);
    //userLibraryLayout.sectionInset = UIEdgeInsetsMake(0, 0, 25, 0);
    userLibraryLayout.minimumLineSpacing = 0;
    UserLibrarySongsCVC *userLibrarySongsCVC = [[UserLibrarySongsCVC alloc] initWithCollectionViewLayout:userLibraryLayout];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:userLibrarySongsCVC];
    
    self.window.rootViewController = navVC;
    
    return YES;
}





@end
