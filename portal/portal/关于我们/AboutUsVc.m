//
//  AboutUsVc.m
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AboutUsVc.h"
#import "aboutUsCell.h"
#import "MACRO_UI.h"
#import "AboutUsHead.h"
#import "SystemSetVc.h"
#import "OurBriefIntroductionVc.h"
#import "agreedAnnouncementVc.h"
#import "FeedbackVc.h"
#import "XAlertView.h"

@interface AboutUsVc ()
@property (nonatomic,strong) NSMutableArray *Arry_data;
@property (nonatomic,weak) AboutUsHead *head;
@end

@implementation AboutUsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *top = [UIView new];
    top.backgroundColor = VIEW_BACKGROUND_COLOR;
    [self.view addSubview:top];
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(HEIGHT_NAVBAR);
        make.height.equalTo(@10);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.top.equalTo(top.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    [self.tableView registerClass:[aboutUsCell class] forCellReuseIdentifier:NSStringFromClass([aboutUsCell class])];
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;
    
    AboutUsHead *head = [[AboutUsHead alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 160*PROPORTION_HEIGHT)];
    self.tableView.tableHeaderView = head;
    // Do any additional setup after loading the view.
    
    UILabel *des1 = [UILabel new];
    des1.font = PingFangSC_Regular(12);
    des1.textColor = ColorWithHex(0x2D2D2D, 0.5);
    des1.numberOfLines = 0;
    des1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:des1];
    
    UILabel *des2 = [UILabel new];
    des2.font = PingFangSC_Regular(10);
    des2.textColor = ColorWithHex(0x2D2D2D, 0.5);
    des2.numberOfLines = 0;
    des2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:des2];
    
    [des1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(des2.mas_top).offset(-10);
    }];
    [des2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
    }];
    des1.text = @"腾邦集团 版权所有";
    des2.text = @"©2017 Tempus Group Co., Ltd. All rights reserved.";
}

#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([aboutUsCell class]) configuration:^(aboutUsCell *cell) {
        [weakself configureaboutUsCell:cell atIndexPath:indexPath];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    leftData *data = self.Arry_data[indexPath.row];
    UIViewController *vc;
    if ([data.title isEqualToString:NSLocalizedString(@"Our brief introduction", @"Our brief introduction")]) {
        vc = [OurBriefIntroductionVc new];
        vc.title = NSLocalizedString(@"Our brief introduction", @"Our brief introduction");
    }else if ([data.title isEqualToString:NSLocalizedString(@"Feedback", @"Feedback")]) {
        vc = [FeedbackVc new];
        vc.title = NSLocalizedString(@"Feedback", @"Feedback");
    }else if ([data.title isEqualToString:NSLocalizedString(@"System settings", @"System settings")]) {
        vc = [SystemSetVc new];
        vc.title = NSLocalizedString(@"System settings", @"System settings");
    }else if ([data.title isEqualToString:NSLocalizedString(@"agreed announcement", @"agreed announcement")]) {
        vc = [agreedAnnouncementVc new];
        vc.title = NSLocalizedString(@"agreed announcement", @"agreed announcement");
    }else if ([data.title isEqualToString:NSLocalizedString(@"Check for updates", @"Check for updates")]) {
        [self checkAppVer];
    }
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma --mark< 检查更新 >
- (void)checkAppVer{
    kWeakSelf(self);
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Check for updates...", @"Check for updates...") toView:self.view];
    [[ToolRequest sharedInstance]URLBASIC_appappUpdatesuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        CheckApp *data = [CheckApp mj_objectWithKeyValues:dataDict];
        if ([data.updateType isEqualToString:@"0"]) {
            [MBProgressHUD showPrompt:NSLocalizedString(@"Congratulations, you have the latest version!", @"Congratulations, you have the latest version!") toView:weakself.view];
        } else if ([data.updateType isEqualToString:@"1"]) {
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
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
    }];
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    aboutUsCell *cell = [aboutUsCell returnCellWith:tableView];
    [self configureaboutUsCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configureaboutUsCell:(aboutUsCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.data = self.Arry_data[indexPath.row];
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Arry_data.count;
}


- (NSArray *)Arry_data{
    if (!_Arry_data) {
        _Arry_data = [NSMutableArray array];
        leftData *one = [leftData new];
        one.title = NSLocalizedString(@"Our brief introduction", @"Our brief introduction");
        [_Arry_data addObject:one];
        
        leftData *two = [leftData new];
        two.title = NSLocalizedString(@"Feedback", @"Feedback");
        [_Arry_data addObject:two];
#ifdef DEBUG
        leftData *three = [leftData new];
        three.title = NSLocalizedString(@"Check for updates", @"Check for updates");
        [_Arry_data addObject:three];
        
        
        leftData *four = [leftData new];
        four.title = NSLocalizedString(@"System settings", @"System settings");
        [_Arry_data addObject:four];
#else
        if ([[PortalHelper sharedInstance].globalParameter.isPassForIOS isEqualToString:STRING_1]){
            leftData *three = [leftData new];
            three.title = NSLocalizedString(@"Check for updates", @"Check for updates");
            [_Arry_data addObject:three];
            
            
            leftData *four = [leftData new];
            four.title = NSLocalizedString(@"System settings", @"System settings");
            [_Arry_data addObject:four];
        }
#endif
        
        leftData *five = [leftData new];
        five.title = NSLocalizedString(@"agreed announcement", @"agreed announcement");
        [_Arry_data addObject:five];
    }
    return _Arry_data;
}
@end
