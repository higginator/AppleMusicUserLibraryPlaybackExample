//
//  AppleMusicTokenController.h
//  AppleMusicUserLibraryExample
//
//  Created by Ryan Higgins on 10/3/18.
//  Copyright © 2018 Ryan Higgins. All rights reserved.
//

#import <Foundation/Foundation.h>
@import StoreKit;

@interface AppleMusicTokenController : NSObject

+ (AppleMusicTokenController *)sharedInstance;
+ (void)requestAppleMusicUserTokenWithCompletion:(void(^)(BOOL success, NSString *appleMusicUserToken))completionBlock;
+ (void)requestAppleMusicDeveloperTokenWithCompletion:(void(^)(NSString *appleMusicDeveloperToken))completionBlock;

@end
