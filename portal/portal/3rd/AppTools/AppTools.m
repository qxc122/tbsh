//
//  AppTools.m
//  wallet
//
//  Created by zhuanghonglin on 16/4/18.
//  Copyright © 2016年 xingxing. All rights reserved.
//

#import "AppTools.h"

static NSString *HasBeenOpened = @"HasBeenOpened";
static NSString *HasBeenOpenedForCurrentVersion = @"";

@implementation AppTools

+ (BOOL)isFirstStart {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpened = [defaults boolForKey:HasBeenOpened];
    if (hasBeenOpened != true) {
        return YES;
    } else {
        return NO;
    }
}

+ (void)onFirstStart:(void (^ _Nullable)(BOOL isFirstStart))block {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpened = [defaults boolForKey:HasBeenOpened];
    if (hasBeenOpened != true) {
        [defaults setBool:YES forKey:HasBeenOpened];
        [defaults synchronize];
    }
    
    block(!hasBeenOpened);
}

+ (void)onFirstStartForCurrentVersion:(void (^ _Nullable)(BOOL isFirstStartForCurrentVersion))block {
    HasBeenOpenedForCurrentVersion = [NSString stringWithFormat:@"%@%@", HasBeenOpened, APP_VERSION];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasBeenOpenedForCurrentVersion = [defaults boolForKey:HasBeenOpenedForCurrentVersion];
    if (hasBeenOpenedForCurrentVersion != true) {
        [defaults setBool:YES forKey:HasBeenOpenedForCurrentVersion];
        [defaults synchronize];
    }
    
    block(!hasBeenOpenedForCurrentVersion);
}

@end
