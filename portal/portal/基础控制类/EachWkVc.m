//
//  EachWkVc.m
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "EachWkVc.h"
#import "PortalHelper.h"
#import "Z_PopView.h"
#import "shareTo.h"
#import "CashierVc.h"
#import "HeaderAll.h"
#import "NSDictionary+Add.h"
@interface EachWkVc ()<WKScriptMessageHandler>
@property (strong, nonatomic) Z_PopView *popView;
//@property (nonatomic, assign) BOOL isSelected;
@property (weak, nonatomic) UIButton *btnRight;
@property (weak, nonatomic) shareTo *shareToview;

@property (assign, nonatomic) BOOL isCollection;
@end


@implementation EachWkVc
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.IsHaveRightBtn = NO;
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"pay"]; //支付
        [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"onload"]; //登陆
        [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"login"]; //登陆
        [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"OpenNewWkWebview"]; //打开新页面
        [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"finishWeb"]; //关闭当前控制器
        [userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"callPhone"]; //打电话

        
        NSString *PortalappIdAndSecret = @"";
        NSString *PortalaccessToken = @"";
        NSString *PortalUserInfo = @"";
        if ([PortalHelper sharedInstance].appid) {
            NSDictionary *dic = [[PortalHelper sharedInstance].appid mj_keyValues];
            if (dic) {
                PortalappIdAndSecret = [dic dictionaryToJsonForH5];
            }
        }
        if ([PortalHelper sharedInstance].token) {
            NSDictionary *dic = [[PortalHelper sharedInstance].token mj_keyValues];
            if (dic) {
                PortalaccessToken = [dic dictionaryToJsonForH5];
            }
        }
        if ([PortalHelper sharedInstance].userInfo) {
            NSDictionary *dic = [[PortalHelper sharedInstance].userInfo mj_keyValues];
            if (dic) {
                PortalUserInfo = [dic dictionaryToJsonForH5];
            }
        }
        NSString *cookieStr = [NSString stringWithFormat:@"document.cookie = 'PortalappIdAndSecret=%@',document.cookie = 'PortalaccessToken=%@',document.cookie = 'PortalUserInfo=%@',document.cookie = 'Portalchannel=%@',document.cookie = 'PortalaccessSource=%@',document.cookie = 'PortalaccessSourceType=%@',document.cookie = 'Portalversion=%@'",PortalappIdAndSecret,PortalaccessToken,PortalUserInfo,PORTALCHANNEL,PORTALACCESSSOURCE,PHONEVERSION,PORTALVERSION];
        WKUserScript * cookieScript = [[WKUserScript alloc]
                                       initWithSource:cookieStr
                                       injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [userContentController addUserScript:cookieScript];
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = userContentController;
        
        self.config = config;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    if (self.IsHaveRightBtn) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        self.btnRight = btn;
        [btn setImage:[UIImage imageNamed:SHARE_BLACK_PICTURES] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
}

- (void)rightBtn{
    if (_popView) {
        [self remove_popView];
    } else {
        if (!self.shareToview) {
            [self CreatpopView];
            [_popView showInView:self.view baseView:self.btnRight withPosition:ZShowBottom];
        }
    }
}
#pragma --mark< 去分享 >
- (void)remove_popView{
    kWeakSelf(self);
    [UIView animateWithDuration:.3 animations:^{
        [weakself.popView setAlpha:0];
    } completion:^(BOOL finished) {
        [weakself.popView removeFromSuperview];
        weakself.popView =  nil;
    }];
}
#pragma --mark< 去分享 >
- (void)Goshare{
    shareTo *view = [shareTo new];
    self.shareToview = view;
    kWeakSelf(self);
    view.shareClick = ^(int index) {
        [weakself shareTwoWebPageToPlatformType:index withTitle:@"腾邦生活" withDescr:weakself.merchName withWebOrImageUrl:weakself.url withThumImage:[UIImage imageNamed:LOGO_SHARE] IsImage:NO success:^(NSString *messg) {
            [MBProgressHUD showPrompt:messg toView:weakself.view];
        } failure:^(NSString *error) {
            [MBProgressHUD showPrompt:error toView:weakself.view];
        }];
    };
    [view windosViewshow];
}
#pragma --mark< 去收藏 >
- (void)GOCollection{
    if (self.isCollection) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"You have already collected ~!", @"You have already collected ~!") toView:self.view];
    }else{
        kWeakSelf(self);
        [MBProgressHUD showLoadingMessage:NSLocalizedString(@"In collection...", @"In collection...") toView:self.view];
        [[ToolRequest sharedInstance]URLBASIC_portaladdFavoriteWithmerchId:self.merchId title:self.merchName url:self.url sssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:NSLocalizedString(@"Successful collection", @"Successful collection") toView:weakself.view];
            weakself.isCollection = YES;
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:msg toView:weakself.view];
        }];
    }
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    //接受传过来的消息从而决定app调用的方法
    NSString *method = message.name;
    if ([method isEqualToString:@"pay"]) {
        [self jumpPay:message.body];
    }else if ([method isEqualToString:@"onload"] || [method isEqualToString:@"login"]){
        [self Land:message.body];
    }else if ([method isEqualToString:@"OpenNewWkWebview"]){
        [self OpenNewWkWebview:message.body];
    }else if ([method isEqualToString:@"callPhone"]){
        if ([message.body isKindOfClass:[NSString class]]) {
            NSString *Tel=[[NSMutableString alloc] initWithFormat:@"tel:%@",message.body];
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:Tel]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:Tel]];
            }
        }
    }else if ([method isEqualToString:@"finishWeb"]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    if ([navigationAction.request.URL.absoluteString isEqualToString:@"http://m.haidaowang.com/index.html#back_flag"]) {
        self.title = @"腾邦物流旗下跨境电商-海捣网";
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}



- (void)jumpPay:(NSString *)body{
    if ([body isKindOfClass:[NSString class]]) {
        payPre *data = [payPre mj_objectWithKeyValues:body];
        if (data.sysId && data.sign && data.timestamp && data.v && data.orderId) {
            CashierVc *payVc = [[CashierVc alloc]init];
            payVc.data = data;
            kWeakSelf(self);
            payVc.Successblock = ^(NSDictionary *dic) {
                if ([dic[PAYMENT_STATUS_NOTE] integerValue]== CANCEL_PAYMENT_STATUS) {
                    [weakself Execute_the_JS_statementWith:@"payCancel()"];
                } else {
                    NSDictionary *dicRes = @{@"retStatus":dic[PAYMENT_STATUS_NOTE],@"errorCode":@"100",@"errorMsg":dic[PAYMENT_STATUS_NOTESTR]};
                    NSString *jsStr = [NSString stringWithFormat:@"payFinish('%@')",[dicRes dictionaryToJsonForH5]];
                    [weakself Execute_the_JS_statementWith:jsStr];
                }
            };
            [self.navigationController pushViewController:payVc animated:YES];
            

//            UINavigationController *nnvc = [[UINavigationController alloc]initWithRootViewController:payVc];;
//            [self presentViewController:nnvc animated:YES completion:nil];
        } else {
            [MBProgressHUD showPrompt:NSLocalizedString(@"The argument for the jumpPay method is not valid", @"The argument for the jumpPay method is not valid") toView:self.view];
        }
    }else{
        [MBProgressHUD showPrompt:NSLocalizedString(@"The argument for the jumpPay method is not valid", @"The argument for the jumpPay method is not valid") toView:self.view];
    }
}

- (void)Execute_the_JS_statementWith:(NSString *)str{
    [self.webView evaluateJavaScript:str completionHandler:^(id data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"失败:%@",error.description);
        }
    }];
}

- (void)dealloc{
    NSLog(@"%s",__func__);
    NSLog(@"%s",__func__);
}
- (void)Land:(NSDictionary *)body{
    kWeakSelf(self);
    [self openLoginViewisCacel:^(NSString *isCacel) {
        if ([isCacel isEqualToString:STRING_1]) {
            [weakself Execute_the_JS_statementWith:@"loginCancel()"];
        } else if ([isCacel isEqualToString:STRING_0]){
            NSDictionary *dicRes = @{@"retStatus":@"0",@"errorCode":@"100",@"errorMsg":@"",@"userId":[PortalHelper sharedInstance].userInfo.userId,@"sign":@""};
            NSString *jsStr = [NSString stringWithFormat:@"loginFinish('%@')",[dicRes dictionaryToJsonForH5]];
            [weakself Execute_the_JS_statementWith:jsStr];
        }
    }];
}

#pragma --mark< OpenEachWkVc >
- (void)OpenNewWkWebview:(NSDictionary *)body{
    EachWkVc *vc = [EachWkVc new];
    vc.url = body[@"url"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.shareToview) {
        [self.shareToview closeClisck];
    }
}
- (void)CreatpopView{
    if (!_popView) {
        kWeakSelf(self);
        _popView = [[Z_PopView alloc] initWithArray:@[NSLocalizedString(@"share", @"share"),NSLocalizedString(@"Collection", @"Collection")] WithImageArray:@[SHARE_POPVIEW,COLLECTION_POPVIEW]];
        _popView.chooseBlock = ^(NSString *chooseItem) {
            [weakself remove_popView];
            if ([chooseItem isEqualToString:NSLocalizedString(@"share", @"share")]) {
                [weakself Goshare];
            } else if ([chooseItem isEqualToString:NSLocalizedString(@"Collection", @"Collection")]) {
                if ([PortalHelper sharedInstance].userInfo) {
                    [weakself GOCollection];
                }else{
                    [weakself openLoginView:^{
                        [weakself GOCollection];
                    }];
                }
            }
        };
    }
}
@end

@implementation WeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate
{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}
@end
