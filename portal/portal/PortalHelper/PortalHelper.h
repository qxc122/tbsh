//
//  PortalHelper.h
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToolModeldata.h"
#import "SuPhotoManager.h"

typedef void (^photoSHouquanSuccess)();
typedef void (^photoSHouquanFailure)();

@interface PortalHelper : NSObject
+ (PortalHelper *)sharedInstance;
@property (nonatomic,strong) appIdAndSecret *appid;
@property (nonatomic,strong) accessToken *token;
@property (nonatomic,strong) GlobalParameter *globalParameter;
@property (nonatomic,strong) HomeData *homeData;
@property (nonatomic,strong) UserInfo *userInfo;

- (void)photoSHouquanOKsuccess:(photoSHouquanSuccess)successBlock failure:(photoSHouquanFailure)failureBlock;
- (void)photoSHouquan;

- (setUp *)getsetUp;
- (void)setsetUp:(setUp *)data;
@end
