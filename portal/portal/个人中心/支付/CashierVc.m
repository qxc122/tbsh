//
//  CashierVc.m
//  portal
//
//  Created by Store on 2017/9/7.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "CashierVc.h"
#import "CashierCell.h"
#import "XAlertView.h"
@interface CashierVc ()
@property (nonatomic,strong)payData *paydata;
@end

@implementation CashierVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_interactivePopDisabled = YES;
    self.view.backgroundColor = VIEW_BACKGROUND_COLOR;
//    self.tableView.contentInset = UIEdgeInsetsMake(HEIGHT_NAVBAR, 0, 0, 0);
    [self.tableView registerClass:[CashierCell class] forCellReuseIdentifier:NSStringFromClass([CashierCell class])];

    [self.header beginRefreshing];
    self.title = NSLocalizedString(@"Cashier", @"Cashier");
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(TPAY_PAYMENT_NOTIFICATIONFunc:)
                                                 name:TPAY_PAYMENT_NOTIFICATION
                                               object:nil];
}
- (void)loadNewData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_portalqueryOrderInfoWithsysId:self.data.sysId sign:self.data.sign timestamp:self.data.timestamp v:self.data.v orderId:self.data.orderId sssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        
        weakself.paydata = [payData mj_objectWithKeyValues:dataDict];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
    }];
}
- (void)TPAY_PAYMENT_NOTIFICATIONFunc:(NSNotification *)user{
    if (self.Successblock) {
#ifdef DEBUG
        NSDictionary *tmp = user.userInfo;
        NSLog(@"支付=%@",tmp[PAYMENT_STATUS_NOTESTR]);
        NSLog(@"支付=%@",tmp[PAYMENT_STATUS_NOTE]);
#endif
//        [MBProgressHUD showPrompt:tmp[PAYMENT_STATUS_NOTESTR] toView:self.view];
        kWeakSelf(self);
//        [self dismissViewControllerAnimated:YES completion:^{
//            weakself.Successblock(user.userInfo);
//        }];
        weakself.Successblock(user.userInfo);
        [weakself.navigationController popViewControllerAnimated:YES];
    }
}

#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([CashierCell class]) configuration:^(CashierCell *cell) {
        [weakself configureCashierCell:cell atIndexPath:indexPath];
    }];
}


#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CashierCell *cell = [CashierCell returnCellWith:tableView];
    [self configureCashierCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configureCashierCell:(CashierCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.paydata = self.paydata;
    kWeakSelf(self);
    cell.gpPayT = ^{
        [weakself tPayMethod:weakself.paydata];
    };
}

- (void)popSelf{
//    kWeakSelf(self);
//    [self dismissViewControllerAnimated:YES completion:^{
//        if (weakself.Successblock) {
//            NSDictionary *dictTmp = @{PAYMENT_STATUS_NOTE:@(CANCEL_PAYMENT_STATUS)};
//            weakself.Successblock(dictTmp);
//        }
//    }];
    if (self.Successblock) {
        NSDictionary *dictTmp = @{PAYMENT_STATUS_NOTE:@(CANCEL_PAYMENT_STATUS)};
        self.Successblock(dictTmp);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)tPayMethod:(payData *)paydata{
    
    //    NSDictionary *datajsonData = thirdPayment;
    NSString *TUlr = @"togetherTPay://";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:TUlr]]){
        
        //        NSNumber *mone = [];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        NSDictionary *data = @{
                               @"WhoCalls":SCHEML,
                               @"WhoCallsName":NSLocalizedString(@"Living in the country", @"Living in the country"),
                               @"businessID":paydata.orderId,
                               @"businessType":@"10",
                               @"businessName":paydata.orderName,
                               @"money":[NSString stringWithFormat:@"%.2f",[paydata.orderPrice floatValue]],
                               @"supportTcoin":paydata.supportTcoin,
                               };
        [pasteboard setData:[NSDictionary returnDataWithDictionary:data] forPasteboardType:@"data"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:TUlr]];
    }else{
        XAlertView *alert = [[XAlertView alloc]initWithTitle:NSLocalizedString(@"Prompt", @"Prompt")  message:NSLocalizedString(@"You did not install the T wallet client", @"You did not install the T wallet client") clickedBlock:^(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex) {
            if (!canceled) {
                NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/t-qian-bao/id1061514008?mt=8"];
                if ([[UIApplication sharedApplication] canOpenURL:url]){
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        } cancelButtonTitle:NSLocalizedString(@"cancel", @"cancel") otherButtonTitles:NSLocalizedString(@"Determine", @"Determine"), nil];
        [alert show];
    }
}
@end
