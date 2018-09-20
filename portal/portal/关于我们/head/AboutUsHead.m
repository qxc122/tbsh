//
//  AboutUsHead.m
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AboutUsHead.h"
#import "UIImageView+Add.h"
#import "PortalHelper.h"

@interface AboutUsHead ()
@property (nonatomic,weak) UIImageView *Icon;
@end

@implementation AboutUsHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *Icon = [UIImageView new];
        [self addSubview:Icon];
        self.Icon = Icon;

        [Icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(Icon.mas_height);
            make.top.equalTo(self).offset(40*PROPORTION_HEIGHT);
            make.bottom.equalTo(self).offset(-20*PROPORTION_HEIGHT);
        }];
        [Icon SetContentModeScaleAspectFill];
        [Icon SetFilletWith:(160-60)*PROPORTION_HEIGHT];
        Icon.image = [UIImage imageNamed:LOGO_SHARE];
//        [Icon sd_setImageWithURL:[PortalHelper sharedInstance].userInfo.headUrl placeholderImage:[UIImage imageNamed:SD_ALTERNATIVE_PICTURES]];
#ifdef DEBUG
        UIButton *IconBtn = [UIButton new];
        [self addSubview:IconBtn];
        
        [IconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.width.equalTo(Icon.mas_height);
            make.top.equalTo(self).offset(40*PROPORTION_HEIGHT);
            make.bottom.equalTo(self).offset(-20*PROPORTION_HEIGHT);
        }];
        [IconBtn addTarget:self action:@selector(exitSelf) forControlEvents:UIControlEventTouchUpInside];
#endif
    }
    return self;
}
#ifdef DEBUG
#pragma -mark<退出登陆>
- (void)exitSelf{
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Drop out...", @"Drop out...")];
    [[ToolRequest sharedInstance]userlogoutssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showPrompt:NSLocalizedString(@"Quit successfully", @"Quit successfully")];

        
        [PortalHelper sharedInstance].userInfo = nil;
        [PortalHelper sharedInstance].token = nil;
        [PortalHelper sharedInstance].appid = nil;
        [PortalHelper sharedInstance].globalParameter = nil;
        [PortalHelper sharedInstance].homeData = nil;
        
        NSNotification *notification =[NSNotification notificationWithName:LOGIN_EXIT_NOTIFICATION object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        
        NSString *strles = [NSUserDefaults getObjectWithKey:URLAddress];
        if ([strles isEqualToString:tesetURLAddress]) {
            [NSUserDefaults setObject:productURLAddress withKey:URLAddress];
            [MBProgressHUD showLoadingMessage:NSLocalizedString(@"请退出重新登录,将是正式环境", @"请退出重新登录,将是正式环境")];
        }else if ([strles isEqualToString:productURLAddress]) {
            [NSUserDefaults setObject:tesetURLAddress withKey:URLAddress];
            [MBProgressHUD showLoadingMessage:NSLocalizedString(@"请退出重新登录,将是测试环境", @"请退出重新登录,将是测试环境")];
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showPrompt:msg];
    }];
}
#endif
@end
