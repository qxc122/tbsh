//
//  LoginRegis.m
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "LoginRegis.h"
#import "UIColor+Add.h"
#import "PortalHelper.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UMMobClick/MobClick.h"
#import "NSString+Add.h"

#define close_accessibilityIdentifier  @"close"
#define login_accessibilityIdentifier  @"login"
#define reSend_accessibilityIdentifier  @"reSend"
#define QQLogin_accessibilityIdentifier  @"QQLogin"
#define WXLogin_accessibilityIdentifier  @"WXLogin"

@interface LoginRegis ()<UITextFieldDelegate>
@property (nonatomic,weak) UILabel *titlee;
@property (nonatomic,weak) UIImageView *back;
@property (nonatomic,weak) UIButton *close;
@property (nonatomic,weak) UIView *line1;
@property (nonatomic,weak) UIView *line2;
@property (nonatomic,weak) UIButton *login;

@property (nonatomic,weak) UITextField *phone;
@property (nonatomic,weak) UITextField *sms;
@property (nonatomic,weak) UIView *Vline;
@property (nonatomic,weak) UIButton *reSend;

@property (nonatomic,weak) UIView *ThirdBack;
@property (nonatomic,weak) UILabel *thirdTitle;
@property (nonatomic,weak) UIView *lineL;
@property (nonatomic,weak) UIView *lineR;
@property (nonatomic,weak) UIButton *WXLogin;
@property (nonatomic,weak) UIButton *QQLogin;


@property (nonatomic,strong) NSTimer *scrollTimer;
@property (nonatomic,assign) NSInteger num;

@property (nonatomic,strong) NSString *unionid; //第三方登录用的
@end

@implementation LoginRegis
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.IsLogin = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopDisabled = YES;
#ifdef DEBUGFF
    UIButton *close = [UIButton new];
    self.close  =close;
    [self.view addSubview:close];
    
    close.imageEdgeInsets = UIEdgeInsetsMake(12.5, 12.5, 12.5, 12.5);
    [close setImage:[UIImage imageNamed:LOGIN_CLOSE_BUTTON] forState:UIControlStateNormal];
    
    //    [close setBackgroundImage:[UIImage imageNamed:LOGIN_CLOSE_BUTTON] forState:UIControlStateNormal];
    close.accessibilityIdentifier = close_accessibilityIdentifier;
    [close addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15-12.5);
        make.top.equalTo(self.view).offset(34-12.5);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
#else
    UIImageView *back = [UIImageView new];
    self.back  =back;
    [self.view addSubview:back];
    
    UILabel *titlee = [UILabel new];
    self.titlee  =titlee;
    [self.view addSubview:titlee];
    
    UIButton *close = [UIButton new];
    self.close  =close;
    [self.view addSubview:close];
    
    UITextField *phone = [UITextField new];
    self.phone  =phone;
    [self.view addSubview:phone];
    
    UIView *line1 = [UIView new];
    self.line1  =line1;
    [self.view addSubview:line1];
    
    UITextField *sms = [UITextField new];
    self.sms  =sms;
    [self.view addSubview:sms];
    
    UIView *Vline = [UIView new];
    self.Vline  =Vline;
    [self.view addSubview:Vline];
    
    UIButton *reSend = [UIButton new];
    self.reSend  =reSend;
    [self.view addSubview:reSend];
    
    UIView *line2 = [UIView new];
    self.line2  =line2;
    [self.view addSubview:line2];
    
    UIButton *login = [UIButton new];
    self.login  =login;
    [self.view addSubview:login];
    
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [titlee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(close);
    }];
    [close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15-12.5);
        make.top.equalTo(self.view).offset(34-12.5);
        make.width.equalTo(@40);
        make.height.equalTo(@40);
    }];
    
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1);
        make.right.equalTo(line1);
        make.bottom.equalTo(line1.mas_top).offset(-10);
        make.height.equalTo(@36);
    }];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(38*PROPORTION_WIDTH);
        make.right.equalTo(self.view).offset(-38*PROPORTION_HEIGHT);
        make.top.equalTo(self.view).offset(200*PROPORTION_HEIGHT);
        make.height.equalTo(@0.5);
    }];
    [sms mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1);
        make.right.equalTo(Vline.mas_left).offset(-15);
        make.bottom.equalTo(line2.mas_top).offset(-10);
        make.height.equalTo(@35);
    }];
    [Vline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(reSend.mas_left);
        make.centerY.equalTo(sms);
        make.height.equalTo(@15);
        make.width.equalTo(@2);
    }];
    [reSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(line1);
        make.height.equalTo(@40);
        make.width.equalTo(@100);
        make.centerY.equalTo(sms);
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1);
        make.right.equalTo(line1);
        make.top.equalTo(line1.mas_bottom).offset(70);
        make.height.equalTo(line1);
    }];
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line1);
        make.right.equalTo(line1);
        make.top.equalTo(line2.mas_bottom).offset(21);
        make.height.equalTo(@50);
    }];
    //set
    [back SetContentModeScaleAspectFill];
    
    close.imageEdgeInsets = UIEdgeInsetsMake(12.5, 12.5, 12.5, 12.5);
    [close setImage:[UIImage imageNamed:LOGIN_CLOSE_BUTTON] forState:UIControlStateNormal];
    
//    [close setBackgroundImage:[UIImage imageNamed:LOGIN_CLOSE_BUTTON] forState:UIControlStateNormal];
    close.accessibilityIdentifier = close_accessibilityIdentifier;
    [close addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [login setBackgroundImage:[UIImage imageNamed:LANDING_BUTTON_BACKGROUND] forState:UIControlStateNormal];
    login.accessibilityIdentifier = login_accessibilityIdentifier;
    if (self.IsLogin) {
        [login setTitle:NSLocalizedString(@"Land", @"Land") forState:UIControlStateNormal];
    }else{
        [login setTitle:NSLocalizedString(@"Bind immediately", @"Bind immediately") forState:UIControlStateNormal];
    }
    [login setTitleColor:ColorWithHex(0xFFFFFF, 1.0) forState:UIControlStateNormal];
    login.titleLabel.font = PingFangSC_Regular(16);
    [login addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    reSend.accessibilityIdentifier = reSend_accessibilityIdentifier;
    [reSend setTitleColor:ColorWithHex(0xFFFFFF, 0.8) forState:UIControlStateNormal];
    reSend.titleLabel.font = PingFangSC_Regular(15);
    [reSend setTitle:NSLocalizedString(@"Get validation code", @"Get validation code") forState:UIControlStateNormal];
    [reSend addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [reSend setBackgroundImage:[ColorWithHex(0xFFFFFF, 0.01) imageWithColor] forState:UIControlStateNormal];
    
    line1.backgroundColor  =ColorWithHex(0xFFFFFF, 0.5);
    line2.backgroundColor  =ColorWithHex(0xFFFFFF, 0.5);
    Vline.backgroundColor  =ColorWithHex(0xFFFFFF, 0.5);
    
    phone.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    [phone setValue:PLACEHOLDERLABELTEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
    sms.keyboardType = UIKeyboardTypeASCIICapableNumberPad;
    [sms setValue:PLACEHOLDERLABELTEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
    titlee.font = PingFangSC_Regular(17);
    titlee.textColor = ColorWithHex(0xFFFFFF, 1.0);
    
    phone.placeholder = NSLocalizedString(@"Please enter your cell phone number", @"Please enter your cell phone number");
    sms.placeholder = NSLocalizedString(@"Please enter a verification code", @"Please enter a verification code");
    phone.clearButtonMode = UITextFieldViewModeWhileEditing;
    sms.clearButtonMode = UITextFieldViewModeWhileEditing;
    phone.textColor = ColorWithHex(0xFFFFFF, 0.8);
    phone.font = PingFangSC_Regular(15);
    sms.textColor = ColorWithHex(0xFFFFFF, 0.8);
    sms.font = PingFangSC_Regular(15);
    sms.delegate =self;
    phone.delegate =self;
    [sms addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [phone addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.login.enabled = NO;
    back.image = [UIImage imageNamed:LANDING_BACKGROUND_PICTURES];
    

    if (!self.IsLogin) {
        if ( [self.phone canBecomeFirstResponder]) {
            [self.phone becomeFirstResponder];
        }
        titlee.text =NSLocalizedString(@"Bind mobile phone number",@"Bind mobile phone number");
    }else{
        titlee.text =NSLocalizedString(@"LandTitle",@"LandTitle");
        [self Third_party_loginUI];
    }
#endif
}
#pragma  -mark<第三方登录 UI 设置>
- (void)Third_party_loginUI{
    UIView *ThirdBack =[UIView new];
    [self.view addSubview:ThirdBack];
    
    UILabel *thirdTitle =[UILabel new];
    [ThirdBack addSubview:thirdTitle];
    
    UIView *lineL =[UIView new];
    [ThirdBack addSubview:lineL];
    
    UIView *lineR =[UIView new];
    [ThirdBack addSubview:lineR];
    
    UIButton *WXLogin;
    if ([[UMSocialManager defaultManager]isInstall:UMSocialPlatformType_WechatSession]) {
        WXLogin = [UIButton new];
        [ThirdBack addSubview:WXLogin];
        self.WXLogin = WXLogin;
    }

    UIButton *QQLogin;
//    if ([[PortalHelper sharedInstance].globalParameter.isPassForIOSQQ isEqualToString:STRING_1]) {
        QQLogin =[UIButton new];
        [ThirdBack addSubview:QQLogin];
        self.QQLogin = QQLogin;
//    }
    
    self.ThirdBack = ThirdBack;
    self.thirdTitle = thirdTitle;
    self.lineL = lineL;
    self.lineR = lineR;
    
    [ThirdBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(thirdTitle);
        make.bottom.equalTo(self.view);
    }];
    
    [thirdTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-PROPORTION_HEIGHT*30.0-21*PROPORTION_HEIGHT-40*PROPORTION_HEIGHT);
    }];
    [lineL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(thirdTitle);
        make.left.equalTo(self.line1);
        make.right.equalTo(thirdTitle.mas_left).offset(-5);
        make.height.equalTo(@0.5);
    }];
    [lineR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(thirdTitle);
        make.right.equalTo(self.line1);
        make.left.equalTo(thirdTitle.mas_right).offset(5);
        make.height.equalTo(lineL);
    }];
    if (WXLogin && QQLogin) {
        [WXLogin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-21*PROPORTION_HEIGHT);
            make.right.equalTo(self.view.mas_centerX).offset(-25*PROPORTION_WIDTH);
            make.width.equalTo(@(40*PROPORTION_HEIGHT));
            make.height.equalTo(WXLogin.mas_width);
        }];
        [QQLogin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(WXLogin);
            make.left.equalTo(self.view.mas_centerX).offset(25*PROPORTION_WIDTH);
            make.width.equalTo(WXLogin);
            make.height.equalTo(WXLogin);
        }];
    }else if (WXLogin || QQLogin){
        if (WXLogin) {
            [WXLogin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view).offset(-21*PROPORTION_HEIGHT);
                make.centerX.equalTo(self.view);
                make.width.equalTo(@(40*PROPORTION_HEIGHT));
                make.height.equalTo(WXLogin.mas_width);
            }];
        } else if(QQLogin){
            [QQLogin mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.view).offset(-21*PROPORTION_HEIGHT);
                make.centerX.equalTo(self.view);
                make.width.equalTo(@(40*PROPORTION_HEIGHT));
                make.height.equalTo(QQLogin.mas_width);
            }];
        }
    }else if (!WXLogin && !QQLogin){
        ThirdBack.hidden = YES;
    }
    if (WXLogin ) {
        WXLogin.accessibilityIdentifier = WXLogin_accessibilityIdentifier;
        WXLogin.tag = UMSocialPlatformType_WechatSession;
        [WXLogin addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [WXLogin setBackgroundImage:[UIImage imageNamed:WECHAT_LOGIN_BUTTON] forState:UIControlStateNormal];
    }
    if (QQLogin) {
        [QQLogin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view).offset(-21*PROPORTION_HEIGHT);
            make.width.equalTo(@(40*PROPORTION_HEIGHT));
            make.height.equalTo(QQLogin.mas_width);
        }];
        QQLogin.accessibilityIdentifier = QQLogin_accessibilityIdentifier;
        QQLogin.tag = UMSocialPlatformType_QQ;
        [QQLogin addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [QQLogin setBackgroundImage:[UIImage imageNamed:QQ_LOGIN_BUTTON] forState:UIControlStateNormal];
    }
    
    
    lineL.backgroundColor = ColorWithHex(0xFFFFFF, 0.3);
    lineR.backgroundColor = ColorWithHex(0xFFFFFF, 0.3);
    thirdTitle.font = PingFangSC_Regular(12);
    thirdTitle.textColor = ColorWithHex(0xFFFFFF, 0.5);
    thirdTitle.text = NSLocalizedString(@"Third party account login", @"Third party account login");
}

#pragma  -mark<输入框改变了>
-(void)textFieldDidChange :(UITextField *)textField{
    if (self.phone.text.length == 11 && self.sms.text.length == 4) {
        self.login.enabled = YES;
    }else{
        self.login.enabled = NO;
    }
    if (self.phone.text.length == 11) {
        [self removeTimer];
        [self.reSend setTitle:NSLocalizedString(@"Get validation code", @"Get validation code") forState:UIControlStateNormal];
        if ([textField.text isEqualToString:@"18888888888"]) {
            [self SendSms];
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    if (string.length && ![string isEqualToString:@"➋"]  && ![string isEqualToString:@"➌"] && ![string isEqualToString:@"➍"] && ![string isEqualToString:@"➎"] && ![string isEqualToString:@"➏"] && ![string isEqualToString:@"➐"] && ![string isEqualToString:@"➑"] && ![string isEqualToString:@"➒"] ) {
        if (![string deptNumInputShouldNumber]) {
            return NO;
        }
        if ([textField isEqual:self.phone]) {
            NSUInteger length = textField.text.length + string.length;
            if (length > 11) {
                return NO;
            }
        } else if ([textField isEqual:self.sms]) {
            NSUInteger length = textField.text.length + string.length;
            if (length > 4) {
                return NO;
            }
        }
    }
    return YES;
}

- (void)BtnClick:(UIButton *)btn{
    if ([btn.accessibilityIdentifier isEqualToString:close_accessibilityIdentifier]) {
        if (self.blockWithStaue) {
            self.blockWithStaue(@"1");
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([btn.accessibilityIdentifier isEqualToString:login_accessibilityIdentifier]) {
        if (self.sms.isFirstResponder) {
            [self.sms resignFirstResponder];
        }
        if (self.IsLogin) {
            [self SmsLogin];
        } else {
            [self SmsBind];
        }
    }else if ([btn.accessibilityIdentifier isEqualToString:reSend_accessibilityIdentifier]) {
        if ([self.phone.text IsTelNumber]) {
            [self SendSms];
        } else {
            [MBProgressHUD showPrompt:NSLocalizedString(@"Please enter the correct cell phone number", @"Please enter the correct cell phone number") toView:self.view];
        }
    }else if ([btn.accessibilityIdentifier isEqualToString:WXLogin_accessibilityIdentifier] || [btn.accessibilityIdentifier isEqualToString:QQLogin_accessibilityIdentifier]) {
        [self getUserInfoWithPlatform:btn.tag];
    }
}
- (void)Send_LOGIN_EXIT_NOTIFICATION{
    NSNotification *notification =[NSNotification notificationWithName:LOGIN_EXIT_NOTIFICATION object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}
#pragma  --mark<绑定手机号>
- (void)SmsBind{
    kWeakSelf(self);
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Bound...", @"Bound...") toView:self.view];
    [[ToolRequest sharedInstance]userthirdUserBindWithunionId:self.unionid mobile:self.phone.text verifyCode:self.sms.text ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:NSLocalizedString(@"Login successful", @"Login successful")];
        [PortalHelper sharedInstance].userInfo= [UserInfo mj_objectWithKeyValues:dataDict];
        [weakself Send_LOGIN_EXIT_NOTIFICATION];
        if (weakself.Successblock) {
            weakself.Successblock();
        }
        if (weakself.blockWithStaue) {
            weakself.blockWithStaue(@"0");
        }
        [weakself.navigationController popViewControllerAnimated:YES];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
    }];
}
#pragma  --mark<验证码登陆>
- (void)SmsLogin{
    kWeakSelf(self);
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Landing...", @"Landing...") toView:self.view];
    [[ToolRequest sharedInstance]userloginWithmobile:self.phone.text verifyCode:self.sms.text success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:NSLocalizedString(@"Login successful", @"Login successful")];
        [PortalHelper sharedInstance].userInfo= [UserInfo mj_objectWithKeyValues:dataDict];
        [weakself Send_LOGIN_EXIT_NOTIFICATION];
        if (weakself.Successblock) {
            weakself.Successblock();
        }
        if (weakself.blockWithStaue) {
            weakself.blockWithStaue(@"0");
        }
        [weakself.navigationController popViewControllerAnimated:YES];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"sdf");
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
    }];
}

#pragma  --mark<发送验证码>
- (void)SendSms{
    kWeakSelf(self);
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Send in...", @"Send in...") toView:self.view];
    [[ToolRequest sharedInstance]systemsendVerifyCodeWithmobile:self.phone.text type:LOGIN_TYPE success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:NSLocalizedString(@"Send successfully", @"Send successfully") toView:weakself.view];
        if ([weakself.sms canBecomeFirstResponder]) {
            [weakself.sms becomeFirstResponder];
        }
        weakself.reSend.enabled = NO;
        weakself.num = 60;
        [weakself creatTimer];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
        NSLog(@"sdf");
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark----创建定时器
-(void)creatTimer
{
    _scrollTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishiRunning) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_scrollTimer forMode:NSRunLoopCommonModes];
    [self.reSend setTitle:[NSString stringWithFormat:@"60s%@",NSLocalizedString(@"Post retransmission", @"Post retransmission")] forState:UIControlStateNormal];
}
#pragma mark----倒计时
-(void)daojishiRunning{
    self.num--;
    if (self.num == 0) {
        [self removeTimer];
    }else{
        [self.reSend setTitle:[NSString stringWithFormat:@"%lds%@",(long)self.num,NSLocalizedString(@"Post retransmission", @"Post retransmission")] forState:UIControlStateNormal];
    }
}
#pragma mark----移除定时器
-(void)removeTimer
{
    self.reSend.enabled = YES;
    [self.reSend setTitle:NSLocalizedString(@"Resend", @"Resend") forState:UIControlStateNormal];
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
}
- (void)dealloc{
    [self removeTimer];
}

#pragma --mark<友盟登陆>
- (void)getUserInfoWithPlatform:(UMSocialPlatformType)platformType{
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Landing...", @"Landing...") toView:self.view];
    kWeakSelf(self);
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        if (resp) {
            // 第三方登录数据(为空表示平台未提供)
            // 授权数据
            NSLog(@" uid: %@", resp.uid);
            NSLog(@" openid: %@", resp.openid);
            NSLog(@" accessToken: %@", resp.accessToken);
            NSLog(@" refreshToken: %@", resp.refreshToken);
            NSLog(@" expiration: %@", resp.expiration);
            
            // 用户数据
            NSLog(@" name: %@", resp.name);
            NSLog(@" iconurl: %@", resp.iconurl);
            NSLog(@" gender: %@", resp.gender);
            
            // 第三方平台SDK原始数据
            NSLog(@" originalResponse: %@", resp.originalResponse);
            
            NSString *chlType;
            if (platformType == UMSocialPlatformType_WechatSession){
                chlType = @"WECHAT";
            } else if (platformType == UMSocialPlatformType_QQ){
                chlType = @"QQ";
            }
//            NSString *gender = NSLocalizedString(@"female", @"female");
//            if ([resp.gender isEqualToString:@"m"]){
//                gender = NSLocalizedString(@"male", @"male");
//            } else if ([resp.gender isEqualToString:@"f"]){
//                gender = NSLocalizedString(@"female", @"female");
//            }
            
            [[ToolRequest sharedInstance]userthirdUserLoginWithchlType:chlType nickname:resp.name province:nil city:nil gender:resp.unionGender avatar:resp.iconurl country:nil openId:resp.openid unionid:resp.uid ssuccess:^(id dataDict, NSString *msg, NSInteger code) {

                UserInfo *BindPre = [UserInfo mj_objectWithKeyValues:dataDict];
                if ([BindPre.bindFlag isEqualToString:STRING_0]) {
                    weakself.unionid = resp.uid;
                    weakself.ThirdBack.hidden = YES;
                    weakself.sms.text = nil;
                    weakself.phone.text = nil;
                    [weakself removeTimer];
                    [weakself.login setTitle:NSLocalizedString(@"Bind immediately", @"Bind immediately") forState:UIControlStateNormal];
                    weakself.IsLogin = NO;
                    weakself.titlee.text =NSLocalizedString(@"Bind mobile phone number",@"Bind mobile phone number");
                    if (!weakself.IsLogin && [weakself.phone canBecomeFirstResponder]) {
                        [weakself.phone becomeFirstResponder];
                    }
                    [MBProgressHUD hideHUDForView:weakself.view];
                    [MBProgressHUD showPrompt:NSLocalizedString(@"You have not bound your cell phone number. Please bind your cell phone number first", @"You have not bound your cell phone number. Please bind your cell phone number first")];
                } else {
                    [PortalHelper sharedInstance].userInfo= BindPre;
                    if (weakself.Successblock) {
                        weakself.Successblock();
                    }
                    if (weakself.blockWithStaue) {
                        weakself.blockWithStaue(@"0");
                    }
                    [MBProgressHUD hideHUDForView:weakself.view];
                    [MBProgressHUD showPrompt:NSLocalizedString(@"Login successful", @"Login successful")];
                    [weakself.navigationController popViewControllerAnimated:YES];
                }
#ifdef DEBUG
                NSString *strTmp = [dataDict DicToJsonstr];
                NSLog(@"strTmp=%@",strTmp);
#endif
            } failure:^(NSInteger errorCode, NSString *msg) {
                [MBProgressHUD hideHUDForView:weakself.view];
                [MBProgressHUD showPrompt:msg toView:weakself.view];
            }];
        } else {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:NSLocalizedString(@"Landing failure", @"Landing failure") toView:weakself.view];
        }
    }];
}
@end
