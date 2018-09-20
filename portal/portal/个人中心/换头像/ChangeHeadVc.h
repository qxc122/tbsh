//
//  ChangeHeadVc.h
//  portal
//
//  Created by Store on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import "HeaderAll.h"

@interface ChangeHeadVc : MWPhotoBrowser
@property (nonatomic,strong) UserInfo *data;
@property (nonatomic,assign) BOOL IsItACroppedPicture;  //是否是裁剪图片
@property (nonatomic, copy) void (^returnImage)(id image);
@end
