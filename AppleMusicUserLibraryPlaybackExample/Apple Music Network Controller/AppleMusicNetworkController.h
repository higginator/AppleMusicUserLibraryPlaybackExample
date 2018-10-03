//
//  AppleMusicNetworkController.h
//  AppleMusicUserLibraryExample
//
//  Created by Ryan Higgins on 10/3/18.
//  Copyright © 2018 Ryan Higgins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppleMusicNetworkController : NSObject

+ (void)getAppleMusicUserLibrarySongsWithCompletion:(void(^)(BOOL success, NSDictionary *results))completion;

@end
