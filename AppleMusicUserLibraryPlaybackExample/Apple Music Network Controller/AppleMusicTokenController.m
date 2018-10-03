//
//  AppleMusicTokenController.m
//  AppleMusicUserLibraryExample
//
//  Created by Ryan Higgins on 10/3/18.
//  Copyright © 2018 Ryan Higgins. All rights reserved.
//

#import "AppleMusicTokenController.h"
@import StoreKit;

@interface AppleMusicTokenController ()

@property (nonatomic, strong) SKCloudServiceController *cloudServiceController;
@property (nonatomic, strong) NSString *developerToken;

@end

@implementation AppleMusicTokenController

#pragma mark - Initialization

+ (AppleMusicTokenController *)sharedInstance {
    static AppleMusicTokenController *tokenController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tokenController = [[AppleMusicTokenController alloc] init];
    });
    return tokenController;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _cloudServiceController = [[SKCloudServiceController alloc] init];
        // TO DO: SET DEVELOPER TOKEN
        _developerToken = @"";
    }
    return self;
}

#pragma mark - Apple Music User Token

+ (void)requestAppleMusicUserTokenWithCompletion:(void(^)(BOOL success, NSString *appleMusicUserToken))completionBlock {
    
    SKCloudServiceController *cloudServiceController = [AppleMusicTokenController sharedInstance].cloudServiceController;
    [cloudServiceController
     requestUserTokenForDeveloperToken:[[AppleMusicTokenController sharedInstance] developerToken]  completionHandler:^(NSString * _Nullable userToken, NSError * _Nullable error) {
         if (error) {
             NSLog(@"apple music user token error: %@", [error localizedDescription]);
             [[error userInfo] objectForKey:SKErrorDomain];
             completionBlock(NO, nil);
         } else {
             NSLog(@"user token is %@", userToken);
             completionBlock(YES, userToken);
         }
     }];
}

+ (void)requestAppleMusicDeveloperTokenWithCompletion:(void (^)(NSString *))completionBlock {
    completionBlock([[AppleMusicTokenController sharedInstance] developerToken]);
}

@end
