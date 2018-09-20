//
//  shareTo.h
//  TourismT
//
//  Created by Store on 16/12/31.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "windosView.h"
#import <UMSocialCore/UMSocialCore.h>

@interface shareTo : windosView
/**
 *  分享目标
 */
@property (nonatomic, copy) void (^shareClick)(int index);
@end
