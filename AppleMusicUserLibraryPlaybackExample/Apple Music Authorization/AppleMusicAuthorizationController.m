//
//  AppleMusicAuthorizationController.m
//  AppleMusicUserLibraryPlaybackExample
//
//  Created by Ryan Higgins on 10/3/18.
//  Copyright © 2018 Ryan Higgins. All rights reserved.
//

#import "AppleMusicAuthorizationController.h"
@import StoreKit;

@interface AppleMusicAuthorizationController ()

@property (nonatomic, strong) SKCloudServiceController *cloudServiceController;
@property (nonatomic, strong) SKCloudServiceSetupViewController *setUpVC;

@end

@implementation AppleMusicAuthorizationController

+ (AppleMusicAuthorizationController *)sharedInstance {
    static AppleMusicAuthorizationController *authController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        authController = [[AppleMusicAuthorizationController alloc] init];
    });
    return authController;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _cloudServiceController = [[SKCloudServiceController alloc] init];
        _setUpVC = [[SKCloudServiceSetupViewController alloc] init];
    }
    return self;
}

+ (void)authorizeAppleMusic {
    switch ([SKCloudServiceController authorizationStatus]) {
        case SKCloudServiceAuthorizationStatusNotDetermined:
            NSLog(@"Specific CVC not determined");
            [[AppleMusicAuthorizationController sharedInstance] appleMusicRequestAuthorization];
            break;
        case SKCloudServiceAuthorizationStatusDenied:
            NSLog(@"Specific CVC denied");
            break;
        case SKCloudServiceAuthorizationStatusRestricted:
            NSLog(@"Specific CVC restricted");
            break;
        case SKCloudServiceAuthorizationStatusAuthorized:
            NSLog(@"Specific CVC authorized");
            [[AppleMusicAuthorizationController sharedInstance] appleMusicRequestCapabilities];
            break;
    }
}

- (void)appleMusicRequestAuthorization {
    [SKCloudServiceController requestAuthorization:^(SKCloudServiceAuthorizationStatus status) {
        if (status == SKCloudServiceAuthorizationStatusDenied) {
            NSLog(@"cloud auth status denied");
        } else if (status == SKCloudServiceAuthorizationStatusNotDetermined) {
            NSLog(@"cloud auth status not determined");
        } else if (status == SKCloudServiceAuthorizationStatusRestricted) {
            NSLog(@"cloud auth restricted");
        } else if (status == SKCloudServiceAuthorizationStatusAuthorized) {
            NSLog(@"cloud authorized");
            [[AppleMusicAuthorizationController sharedInstance] appleMusicRequestCapabilities];
        }
    }];
}


- (void)appleMusicRequestCapabilities {
    [[AppleMusicAuthorizationController sharedInstance].cloudServiceController
     requestCapabilitiesWithCompletionHandler:
     ^(SKCloudServiceCapability capabilities, NSError * _Nullable error) {
         if (error) {
             NSLog(@"error requesting apple music capability: %@", [error localizedDescription]);
         } else {
             // capabilities is a bit to save space
             if (capabilities == SKCloudServiceCapabilityNone) {
                 NSLog(@"not capable");
             }
             if (capabilities & SKCloudServiceCapabilityMusicCatalogPlayback) {
                 NSLog(@"playback capable");
             }
             if (capabilities & SKCloudServiceCapabilityMusicCatalogSubscriptionEligible) {
                 NSLog(@"subscription eligible capable");
                 [self setUpSubscriptionView];
             }
             if (capabilities & SKCloudServiceCapabilityAddToCloudMusicLibrary) {
                 NSLog(@"addtocloudmusiclibrary capable");
             }
         }
     }];
}

-(void)setUpSubscriptionView {
    NSLog(@"setup subscription view");
    //SKCloudServiceSetupOptionsActionKey : SKCloudServiceSetupActionSubscribe,
    NSDictionary<SKCloudServiceSetupOptionsKey, id> *options = @{SKCloudServiceSetupOptionsActionKey: SKCloudServiceSetupActionSubscribe};
    [[AppleMusicAuthorizationController sharedInstance].setUpVC loadWithOptions:options
           completionHandler:^(BOOL result, NSError * _Nullable error) {
               NSLog(@"load completion");
               if(result) {
                   [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:[AppleMusicAuthorizationController sharedInstance].setUpVC animated:YES completion:nil];
               }
               if (error) {
                   NSLog(@"error: %@", [error localizedDescription]);
               }
           }];
}

@end
