//
//  AppleMusicNetworkController.m
//  AppleMusicUserLibraryExample
//
//  Created by Ryan Higgins on 10/3/18.
//  Copyright © 2018 Ryan Higgins. All rights reserved.
//

#import "AppleMusicNetworkController.h"
#import "AppleMusicTokenController.h"
@import StoreKit;
#import <AFNetworking/AFNetworking.h>

@interface AppleMusicNetworkController ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation AppleMusicNetworkController

#pragma mark - Initialization

+ (AppleMusicNetworkController *)sharedInstance {
    static AppleMusicNetworkController *networkController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkController = [[AppleMusicNetworkController alloc] init];
    });
    return networkController;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    }
    return self;
}

#pragma mark - Apple Music User Library Request

+ (void)getAppleMusicUserLibrarySongsWithCompletion:(void (^)(BOOL, NSDictionary *))completion {
    // Create HTTP GET Request
    
    [AppleMusicTokenController requestAppleMusicDeveloperTokenWithCompletion:^(NSString *appleMusicDeveloperToken) {
        [AppleMusicTokenController requestAppleMusicUserTokenWithCompletion:^(BOOL success, NSString *appleMusicUserToken) {
            
            NSString *URLString = @"https://api.music.apple.com/v1/me/library/songs";
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            //        [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:SNGSWPAppleMusicStorefrontCountryCode] forKey:SNGSWPAppleMusicStorefrontCountryCode];
            
            NSString *developerTokenHeader = [NSString stringWithFormat:@"Bearer %@", appleMusicDeveloperToken];
            [[AppleMusicNetworkController sharedInstance].sessionManager.requestSerializer setValue:developerTokenHeader forHTTPHeaderField:@"Authorization"];
            
            
            [[AppleMusicNetworkController sharedInstance].sessionManager.requestSerializer setValue:appleMusicUserToken forHTTPHeaderField:@"Music-User-Token"];
            
            NSURLSessionDataTask *task =
            [[AppleMusicNetworkController sharedInstance].sessionManager GET:URLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                completion(YES, responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    NSLog(@"error is %@", error);
                }
                completion(NO, nil);
            }];
            
        }];
    }];
}

@end
