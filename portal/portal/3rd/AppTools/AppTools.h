//
//  AppTools.h
//  wallet
//
//  Created by zhuanghonglin on 16/4/18.
//  Copyright © 2016年 xingxing. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

@interface AppTools : NSObject

/**
 *  是否第一次启动App
 */
+ (BOOL)isFirstStart;

/**
 *  第一次启动App时执行
 */
+ (void)onFirstStart:(void (^ _Nullable)(BOOL isFirstStart))block;

/**
 *  在当前版本第一次启动App时执行
 */
+ (void)onFirstStartForCurrentVersion:(void (^ _Nullable)(BOOL isFirstStartForCurrentVersion))block;

@end
