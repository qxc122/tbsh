//
//  agreedAnnouncementVc.m
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "agreedAnnouncementVc.h"
#import "aboutUsCell.h"
#import "aboutUsWk.h"
@interface agreedAnnouncementVc ()
@property (nonatomic,strong) NSArray *Arry_data;
@end

@implementation agreedAnnouncementVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = VIEW_BACKGROUND_COLOR;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(HEIGHT_NAVBAR+10);
        make.bottom.equalTo(self.view);
    }];
    [self.tableView registerClass:[aboutUsCell class] forCellReuseIdentifier:NSStringFromClass([aboutUsCell class])];
    if ([PortalHelper sharedInstance].globalParameter) {
        self.empty_type = succes_empty_num;
        self.header.hidden = YES;
    }else{
        [self.header beginRefreshing];
    }
}
- (void)loadNewData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]appgetGlobalParamssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [PortalHelper sharedInstance].globalParameter = [GlobalParameter mj_objectWithKeyValues:dataDict];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
        [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
    }];
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
    aboutUsWk *vc = [aboutUsWk new];
    vc.title = data.title;
    if ([data.title isEqualToString:NSLocalizedString(@"User agreement", @"User agreement")]) {
        vc.url = [PortalHelper sharedInstance].globalParameter.userAgreementUrl;
    } else if ([data.title isEqualToString:NSLocalizedString(@"Privacy protocols", @"Privacy protocols")]) {
        vc.url = [PortalHelper sharedInstance].globalParameter.privacyAgreementUrl;
    } else if ([data.title isEqualToString:NSLocalizedString(@"Service agreement", @"Service agreement")]) {
        vc.url = [PortalHelper sharedInstance].globalParameter.serviceAgreementUrl;
    }
    [self.navigationController pushViewController:vc animated:YES];
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
    cell.backgroundColor = [UIColor whiteColor];
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Arry_data.count;
}


- (NSArray *)Arry_data{
    if (!_Arry_data) {
        leftData *one = [leftData new];
        one.title = NSLocalizedString(@"User agreement", @"User agreement");
        
        leftData *two = [leftData new];
        two.title = NSLocalizedString(@"Privacy protocols", @"Privacy protocols");

        leftData *three = [leftData new];
        three.title = NSLocalizedString(@"Service agreement", @"Service agreement");

        _Arry_data = @[one,two,three];
    }
    return _Arry_data;
}
@end
