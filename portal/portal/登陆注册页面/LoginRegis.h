//
//  LoginRegis.h
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicVc.h"

@interface LoginRegis : basicVc
@property (nonatomic,assign) BOOL IsLogin; //默认是
@property (nonatomic,copy) LoginSuccess Successblock;
@property (nonatomic,copy) LoginSuccessWithStaue blockWithStaue;
@end
