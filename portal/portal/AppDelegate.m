//
//  AppDelegate.m
//  portal
//
//  Created by Store on 2017/8/30.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AppDelegate.h"
#import "HeaderAll.h"
#import "MACRO_PIC.h"
#import "MACRO_PORTAL.h"
#import "HomeVc.h"
#import "UIColor+Add.h"
#import "AppDelegate+Umeng.h"
#import "LaunchIntroductionView.h"
#import "AppTools.h"
@interface AppDelegate ()
@property (nonatomic,weak) LaunchIntroductionView *bootPage;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[HomeVc alloc] init]];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    [self setupUMeng];
    if ([PHONEVERSION floatValue] >= 7.0) {
        [[UINavigationBar appearance] setBackgroundImage:[ColorWithHex(0xFFFFFF, 1.0) imageWithColor] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setShadowImage:[ColorWithHex(0xFFFFFF, 1.0) imageWithColor]];
    }
//    if ([PHONEVERSION floatValue] >= 7.0) {
//        [[UINavigationBar appearance] setBackgroundImage:[ColorWithHex(0xFFFFFF, 0.98) imageWithColor] forBarMetrics:UIBarMetricsDefault];
//        [[UINavigationBar appearance] setShadowImage:[ColorWithHex(0x979797, 0.2) imageWithColor]];
//    }
    [self BootPage];
    return YES;
}

- (void)BootPage{
    [AppTools onFirstStartForCurrentVersion:^(BOOL isFirstStartForCurrentVersion) {
        LaunchIntroductionView *launch = [LaunchIntroductionView sharedWithImages:@[@"launch0",@"launch1",@"launch2",@"launch3"] buttonImage:IMMEDIATE_EXPERIENCE_BTN buttonFrame:CGRectMake(kScreen_width/2 - 150/2, kScreen_height - 81-35, 150, 35) skipbuttonImage:SKIP_BTN skipbuttonFrame:CGRectMake(kScreen_width - 45-15, 51, 45, 25)];
        launch.currentColor = ColorWithHex(0x4EA2FF, 1.0);
        launch.nomalColor = ColorWithHex(0x4EA2FF, 0.25);
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        result = [self Tpay:url];
    }
    
    return result;
}

- (BOOL)Tpay:(NSURL *)url{  //T钱包支付
    BOOL tmp;
    if ([[url absoluteString] hasPrefix:SCHEML]) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        NSData *dataAll = [pasteboard dataForPasteboardType:@"dataToZeji"];
        if (dataAll) {
            NSDictionary *data = [self returnDictionaryWithDataPath:dataAll];
            NSDictionary *dataRaw = data[PAYMENT_STATUS_NOTE_RAW_DATA];
            NSString *strMsg = data[@"mmssgg"];

            PAYMENT_STATUS errCode=0;
            if ([strMsg isEqualToString:PAYSUCCESSFUL]) {
                errCode = SUCCESS_PAYMENT_STATUS;
            } else if ([strMsg isEqualToString:PAYCANCELLED]){
                errCode = CANCEL_PAYMENT_STATUS;
            }else if ([strMsg isEqualToString:PAYFAILURE]){
                errCode = FAIL_PAYMENT_STATUS;
            }
            NSMutableDictionary *dictTmp = [@{PAYMENT_STATUS_NOTE:@(errCode),PAYMENT_STATUS_NOTESTR:strMsg} mutableCopy];
            if (dataRaw) {
                [dictTmp setObject:dataRaw forKey:PAYMENT_STATUS_NOTE_RAW_DATA];
            }
            NSNotification *notification = [NSNotification notificationWithName:TPAY_PAYMENT_NOTIFICATION object:nil userInfo:dictTmp];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [UIPasteboard removePasteboardWithName:@"dataToZeji"];
        }
        tmp = YES;
    }else{
        tmp = NO;
    }
    return  tmp;
}
-(NSDictionary*)returnDictionaryWithDataPath:(NSData*)data

{
    
    //  NSData* data = [[NSMutableData alloc]initWithContentsOfFile:path]; 拿路径文件
    
    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    
    NSDictionary* myDictionary = [unarchiver decodeObjectForKey:@"talkData"];
    
    [unarchiver finishDecoding];
    
    return myDictionary;
    
}
@end
