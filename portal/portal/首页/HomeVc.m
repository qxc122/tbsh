//
//  HomeVc.m
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "HomeVc.h"
#import "HomeVcCell.h"
#import "PortalHelper.h"
#import "EachWkVc.h"
#import "sidebarVc.h"
#import "FinanceVc.h"
#import "XAlertView.h"
#import "NSDate+DateTools.h"

typedef void (^SuccessBlock)();

#define HOME_LANDING_BUTTON  @"HOME LANDING BUTTON"

@interface HomeVc ()<UINavigationControllerDelegate>
@property (nonatomic,strong)HomeData *data;
@property (nonatomic,weak)UIButton *Mybtn;

@property (nonatomic,weak)sidebarVc *sidebarvc;
@end

@implementation HomeVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LoadAppid];
    self.fd_prefersNavigationBarHidden = YES;
    [self SetHomeVcUi];
    [self LoadGlobalParam];
    if ([PortalHelper sharedInstance].homeData) {
        self.data = [PortalHelper sharedInstance].homeData;
        self.empty_type = succes_empty_num;
        [self loadNewData];
    }else{
        [self.header beginRefreshing];
    }
    [self checkAppVer];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(returnMyViewController:)
                                                 name:GO_FOR_A_STROLL
                                               object:nil];

}

- (void)returnMyViewController:(NSNotification *)user{
    [self.sidebarvc.view removeFromSuperview];
    [self.sidebarvc removeFromParentViewController];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)GET_NEW_TOKEN_NOTIFICATIONFunc:(NSNotification *)user{
    [self loadNewData];
    if (![PortalHelper sharedInstance].globalParameter) {
        kWeakSelf(self);
        [self LoadGlobalParam:^{
            if (weakself.data) {
                [weakself.tableView reloadData];
            }
        }];
    }
}

- (void)loadNewData{
    if ([PortalHelper sharedInstance].token) {
        kWeakSelf(self);
        [[ToolRequest sharedInstance]portalqueryMerchListssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            weakself.data = [HomeData mj_objectWithKeyValues:dataDict];
            [PortalHelper sharedInstance].homeData = weakself.data;
            
#ifdef DEBUG
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
            [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
        } failure:^(NSInteger errorCode, NSString *msg) {
            [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
        }];
    }
}

- (void)SetHomeVcUi{
    UIButton *btn = [UIButton new];
    self.Mybtn = btn;
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15-9);
        make.top.equalTo(self.view).offset(45-9);
        make.height.equalTo(@(44));
        make.width.equalTo(@(44));
    }];
    btn.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    btn.accessibilityIdentifier = HOME_LANDING_BUTTON;
    [btn setImage:[UIImage imageNamed:TOP_LEFT_CORNER_OF_HOME_PAGE] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView registerClass:[HomeVcCell class] forCellReuseIdentifier:NSStringFromClass([HomeVcCell class])];
    self.tableView.scrollEnabled = NO;
}
#pragma --mark< 点击左上角按钮>
- (void)btnClick:(UIButton *)btn{
    if ([btn.accessibilityIdentifier isEqual:HOME_LANDING_BUTTON]) {
        NSLog(@"%s",__func__);
        if ([PortalHelper sharedInstance].userInfo) {
            [self OpensidebarVc];
        }else{
            kWeakSelf(self);
            [self openLoginView:^{
                [weakself OpensidebarVc];
            }];
        }
    }
}
#pragma --mark<打开侧边栏控制器>
- (void)OpensidebarVc{
    sidebarVc *vc = [sidebarVc new];
    self.sidebarvc = vc;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    kWeakSelf(self);
    vc.ColoseSelf = ^{
        [weakself.sidebarvc.view removeFromSuperview];
        [weakself.sidebarvc removeFromParentViewController];
    };
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma --mark<登录退出的通知>
- (void)LOGIN_EXIT_NOTIFICATIONFunC:(NSNotification *)user{
    [super LOGIN_EXIT_NOTIFICATIONFunC:user];
    if (![PortalHelper sharedInstance].userInfo) {
        [self.sidebarvc.view removeFromSuperview];
        [self.sidebarvc removeFromParentViewController];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HomeVcCell class]) configuration:^(HomeVcCell *cell) {
        [weakself configureHomeVcCell:cell atIndexPath:indexPath];
    }];
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeVcCell *cell = [HomeVcCell returnCellWith:tableView];
    [self configureHomeVcCell:cell atIndexPath:indexPath];
    return  cell;
}
#pragma --mark< 配置HomeVcCell 的数据>
- (void)configureHomeVcCell:(HomeVcCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.data = self.data;
    kWeakSelf(self);
    cell.SelectIndex = ^(HomeDataOne *data) {
//        [weakself OpenEachWkVcOrFinanceVcVc:data];
        
        if (data.needLogin && ![PortalHelper sharedInstance].userInfo) {
            if (weakself.FLAG_IN_DATA_UPDATE) {
                [MBProgressHUD showPrompt:NSLocalizedString(@"Data is being refreshed...", @"Data is being refreshed...") toView:weakself.view];
            }else{
                [weakself openLoginView:^{

                }];
            }
        } else {
            [weakself OpenEachWkVcOrFinanceVcVc:data];
        }
    };
}
#pragma --mark< OpenEachWkVc Or FinanceVc>
- (void)OpenEachWkVcOrFinanceVcVc:(HomeDataOne *)data{
    if ([data.finFlag isEqualToString:STRING_1]) {
        [self OpenFinanceVc:data];
    }else{
        [self OpenEachWkVc:data];
    }
}

#pragma --mark< FinanceVc >
- (void)OpenFinanceVc:(HomeDataOne *)data{
    FinanceVc *vc = [FinanceVc new];
    vc.merchId = data.merchId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma --mark< OpenEachWkVc >
- (void)OpenEachWkVc:(id)data{
    EachWkVc *vc = [EachWkVc new];
    HomeDataOne *tmp = data;
    vc.url = tmp.merchLink;
    vc.merchName = tmp.merchName;
    vc.merchId = tmp.merchId;
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkToken];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma --mark< 检查更新 >
- (void)checkAppVer{
    [[ToolRequest sharedInstance]URLBASIC_appappUpdatesuccess:^(id dataDict, NSString *msg, NSInteger code) {
        CheckApp *data = [CheckApp mj_objectWithKeyValues:dataDict];
        if ([data.updateType isEqualToString:@"1"]) {
            XAlertView *alert = [[XAlertView alloc]initWithTitle:NSLocalizedString(@"Prompt", @"Prompt") message:NSLocalizedString(@"Find new version", @"Find new version") clickedBlock:^(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex) {
                if (!canceled) {
                    NSURL *url = [NSURL URLWithString:PORTALAPPID];
                    if ([[UIApplication sharedApplication] canOpenURL:url]){
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }
            } cancelButtonTitle:NSLocalizedString(@"cancel", @"cancel") otherButtonTitles:NSLocalizedString(@"Determine", @"Determine"), nil];
            [alert show];
        }else if ([data.updateType isEqualToString:@"2"]){
            [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Please go to update and use again!", @"Please go to update and use again!")];
        }
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
    }];
}

#pragma --mark< 检查  Token>
- (void)checkToken{
    accessToken *tmp = [PortalHelper sharedInstance].token;
    if (tmp) {
        if ([tmp.expireTime hoursLaterThan:[NSDate date]] < 5) {
            kWeakSelf(self);
            [self LoadTokenWithSuccessBlock:^{
                [weakself loadticket];
            }];
        }
    }
}

#pragma --mark< 刷新  登陆验证票>
- (void)loadticket{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_userrefreshLoginWithnisssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        UserInfo *userInfo =[UserInfo mj_objectWithKeyValues:dataDict];
        UserInfo *tmp = [PortalHelper sharedInstance].userInfo;
        tmp.authenTicket = userInfo.authenTicket;
        tmp.authenUserId = userInfo.authenUserId;
        [PortalHelper sharedInstance].userInfo = tmp;
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself performSelector:@selector(loadticket) withObject:nil afterDelay:0.5];
    }];
}


- (void)LoadTokenWithSuccessBlock:(SuccessBlock)blcok{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]apptokenApplysuccess:^(id dataDict, NSString *msg, NSInteger code) {
        accessToken *accesstoken =[accessToken mj_objectWithKeyValues:dataDict];
        [PortalHelper sharedInstance].token = accesstoken;
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        if (blcok) {
            blcok();
        }
        if ([PortalHelper sharedInstance].userInfo) {
            [weakself loadticket];
        }
        NSNotification *notification =[NSNotification notificationWithName:GET_NEW_TOKEN_NOTIFICATION object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself performSelector:@selector(LoadTokenWithSuccessBlock:) withObject:blcok afterDelay:0.5];
    }];
}
- (void)LoadAppid{
    if (![PortalHelper sharedInstance].appid || ![PortalHelper sharedInstance].token) {
        kWeakSelf(self);
        [[ToolRequest sharedInstance]tpurseappappIdApplysuccess:^(id dataDict, NSString *msg, NSInteger code) {
            appIdAndSecret *appid =[appIdAndSecret mj_objectWithKeyValues:dataDict];
            [PortalHelper sharedInstance].appid = appid;
            [weakself LoadTokenWithSuccessBlock:nil];
#ifdef DEBUG
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
        } failure:^(NSInteger errorCode, NSString *msg) {
            [weakself performSelector:@selector(LoadAppid) withObject:nil afterDelay:0.5];
        }];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
