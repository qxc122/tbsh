//
//  PortalHelper.m
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "PortalHelper.h"
#import "MACRO_PORTAL.h"
#import "XAlertView.h"
#import "HeaderAll.h"
@interface PortalHelper ()

@end

@implementation PortalHelper
+ (PortalHelper *)sharedInstance
{
    static PortalHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.appid = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_APPIDANDSECRET];
        self.token = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_TOKEN];
        self.globalParameter = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_APPCOMMONGLOBAL];
        self.homeData = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_HOMEDATA];
        self.userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_USERINFO];
    }
    return self;
}
- (void)setUserInfo:(UserInfo *)userInfo{
    _userInfo = userInfo;
    if (userInfo) {
        [NSKeyedArchiver archiveRootObject:userInfo toFile:PATH_USERINFO];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_USERINFO error:nil];
    }
}
- (void)setAppid:(appIdAndSecret *)appid{
    _appid = appid;
    [NSKeyedArchiver archiveRootObject:appid toFile:PATH_APPIDANDSECRET];
}
- (void)setToken:(accessToken *)token{
    _token = token;
    [NSKeyedArchiver archiveRootObject:token toFile:PATH_TOKEN];
}
- (void)setGlobalParameter:(GlobalParameter *)globalParameter{
    _globalParameter = globalParameter;
    [NSKeyedArchiver archiveRootObject:globalParameter toFile:PATH_APPCOMMONGLOBAL];
}

- (void)setHomeData:(HomeData *)homeData{
    _homeData = homeData;
    [NSKeyedArchiver archiveRootObject:homeData toFile:PATH_HOMEDATA];
}


- (void)photoSHouquanOKsuccess:(photoSHouquanSuccess)successBlock failure:(photoSHouquanFailure)failureBlock{
    PHAuthorizationStatus authoriation = [PHPhotoLibrary authorizationStatus];
    if (authoriation == PHAuthorizationStatusNotDetermined) {
        kWeakSelf(self);
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            //这里非主线程，选择完成后会出发相册变化代理方法
            if (status == PHAuthorizationStatusAuthorized) {
                successBlock();
            } else {
                [weakself SetWithfailure:failureBlock];
            }
        }];
    }else if (authoriation == PHAuthorizationStatusAuthorized) {
        successBlock();
    }else {
        [self SetWithfailure:failureBlock];
    }
}

- (void)SetWithfailure:(photoSHouquanFailure)failureBlock{
    XAlertView *tmp = [[XAlertView alloc]initWithTitle:NSLocalizedString(@"Cannot preview pictures", @"Cannot preview pictures") message:NSLocalizedString(@"The application has no access to photo permissions", @"The application has no access to photo permissions") clickedBlock:^(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex) {
        if (canceled) {
            failureBlock();
        } else {
            // 去设置权限
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    } cancelButtonTitle:NSLocalizedString(@"cancel", @"cancel") otherButtonTitles:NSLocalizedString(@"Go setup", @"Go setup"), nil];
    [tmp show];
}

- (void)photoSHouquan{
    PHAuthorizationStatus authoriation = [PHPhotoLibrary authorizationStatus];
    if (authoriation == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            //这里非主线程，选择完成后会出发相册变化代理方法
        }];
    }
}

- (setUp *)getsetUp{
    setUp *data =  [NSKeyedUnarchiver unarchiveObjectWithFile:PATH_SET_UP];
    if (!data) {
        data = [setUp new];
        data.ReceiveNotification = YES;
        data.ReceiveNotification = YES;
        [NSKeyedArchiver archiveRootObject:data toFile:PATH_SET_UP];
    }
    return data;
}
- (void)setsetUp:(setUp *)data{
    if (data) {
        [NSKeyedArchiver archiveRootObject:data toFile:PATH_SET_UP];
    }else{
        NSFileManager *manager = [NSFileManager defaultManager];
        [manager removeItemAtPath:PATH_SET_UP error:nil];
    }
}
@end
