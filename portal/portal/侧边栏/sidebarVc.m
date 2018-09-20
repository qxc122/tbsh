//
//  sidebarVc.m
//  portal
//
//  Created by Store on 2017/9/1.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "sidebarVc.h"
#import "sidebarVcHead.h"
#import "sidebarCell.h"
#import "MyNewsVc.h"
#import "CommonInformationVc.h"
#import "AboutUsVc.h" 
#import "MyCollectionVc.h"
#import "PersonalCenterVc.h"
#import "sidebarVcHeadPre.h"
#import "PortalHelper.h"
@interface sidebarVc ()<UIScrollViewDelegate>
@property (nonatomic,strong) UserInfo *data;
@property (nonatomic,weak) UIView *back;
@property (nonatomic,weak) sidebarVcHead *Head;
@property (nonatomic,strong) sidebarVcHeadPre *placeHead;
@property (nonatomic,strong) NSArray *Arry_data;
@end

@implementation sidebarVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UIButton *closeSelf = [UIButton new];
    closeSelf.backgroundColor =[UIColor clearColor];
    [self.view addSubview:closeSelf];
    [closeSelf addTarget:self action:@selector(CloseSelf) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *back = [UIView new];
    self.back = back;
    [self.view addSubview:back];
    [self.view  sendSubviewToBack:back];
    back.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = ColorWithHex(0x000000, 0.3);
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view).offset(-139*PROPORTION_WIDTH);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [back mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView);
        make.right.equalTo(self.tableView);
        make.top.equalTo(self.tableView);
        make.bottom.equalTo(self.tableView);
    }];
    
    [closeSelf mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tableView.mas_right);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.tableView.backgroundColor =[UIColor clearColor];
    [self.tableView registerClass:[sidebarCell class] forCellReuseIdentifier:NSStringFromClass([sidebarCell class])];
    
    self.data = [PortalHelper sharedInstance].userInfo;
    if (self.data) {
        self.empty_type = succes_empty_num;
        self.header.hidden = YES;
        self.tableView.tableHeaderView = self.placeHead;
        self.Head.data = self.data;
    } else {
        [self.header beginRefreshing];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(CHANGE_NAME_NOTIFICATIONFunc:)
                                                 name:CHANGE_NAME_NOTIFICATION
                                               object:nil];
    
}

#pragma --mark<登录退出的通知>
- (void)LOGIN_EXIT_NOTIFICATIONFunC:(NSNotification *)user{
    if (![PortalHelper sharedInstance].userInfo && [self.navigationController.topViewController isEqual:self]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)CHANGE_NAME_NOTIFICATIONFunc:(NSNotification *)user{
    self.data = [PortalHelper sharedInstance].userInfo;
    self.Head.data = self.data;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.data) {
        CGFloat yy = scrollView.contentOffset.y;
        NSLog(@"yy=%f",yy);
        if (yy > 0) {
            self.Head.frame = CGRectMake(0, -yy, SCREENWIDTH-139*PROPORTION_WIDTH, 270*PROPORTION_HEIGHT);
        } else if (yy < 0) {
            self.Head.frame = CGRectMake(0, 0, SCREENWIDTH-139*PROPORTION_WIDTH, 270*PROPORTION_HEIGHT-yy);
        }
    }
}
#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([sidebarCell class]) configuration:^(sidebarCell *cell) {
        [weakself configuresidebarCell:cell atIndexPath:indexPath];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    leftData *data = self.Arry_data[indexPath.row];
    UIViewController *vc;
    if ([data.title isEqualToString:NSLocalizedString(@"Common information", @"Common information")]) {
        vc = [CommonInformationVc new];
        vc.title = NSLocalizedString(@"Common information", @"Common information");
    }else if ([data.title isEqualToString:NSLocalizedString(@"My collection", @"My collection")]) {
        vc = [MyCollectionVc new];
        vc.title = NSLocalizedString(@"My collection", @"My collection");
    }else if ([data.title isEqualToString:NSLocalizedString(@"Browse history", @"Browse history")]) {
//        vc = [BrowseHistoryVc new];
//        vc.title = NSLocalizedString(@"Browse history", @"Browse history");
    }else if ([data.title isEqualToString:NSLocalizedString(@"My news", @"My news")]) {
        vc = [MyNewsVc new];
        vc.title = NSLocalizedString(@"My news", @"My news");
    }else if ([data.title isEqualToString:NSLocalizedString(@"About us", @"About us")]) {
        vc = [AboutUsVc new];
        vc.title = NSLocalizedString(@"About us", @"About us");
    }
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    sidebarCell *cell = [sidebarCell returnCellWith:tableView];
    [self configuresidebarCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configuresidebarCell:(sidebarCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    leftData *data = self.Arry_data[indexPath.row];
    cell.data = data;
    if ([data.title isEqualToString:NSLocalizedString(@"My news", @"My news")]) {
        cell.hasUnreadNews = self.data.hasUnreadNews;
    }
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.data) {
        return self.Arry_data.count;
    }
    return 0;
}

- (void)loadNewData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]usermyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
        weakself.data = [UserInfo mj_objectWithKeyValues:dataDict];
        [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
        weakself.tableView.tableHeaderView = weakself.placeHead;
        weakself.Head.data = weakself.data;
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"sdf");
        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
    }];
}

- (sidebarVcHead *)Head{
    if (!_Head) {
        sidebarVcHead *head = [[sidebarVcHead alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-139*PROPORTION_WIDTH, 270*PROPORTION_HEIGHT)];
        [self.view addSubview:head];
        [self.view  sendSubviewToBack:head];
        [self.view  sendSubviewToBack:self.back];
        _Head = head;
    }
    return _Head;
}
- (sidebarVcHeadPre *)placeHead{
    if (!_placeHead) {
        sidebarVcHeadPre *placeHead = [[sidebarVcHeadPre alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-139*PROPORTION_WIDTH, 270*PROPORTION_HEIGHT)];
        kWeakSelf(self);
        placeHead.GoToThePersonalCenter = ^{
            [weakself OpenPersonalCenterVc];
        };
        _placeHead= placeHead;
    }
    return _placeHead;
}


#pragma --mark<关闭本页面>
- (void)CloseSelf{
    if (self.ColoseSelf) {
        self.ColoseSelf();
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)Arry_data{
    if (!_Arry_data) {
        leftData *one = [leftData new];
        one.title = NSLocalizedString(@"Common information", @"Common information");
        one.image = COMMON_INFORMATION;
        
        leftData *two = [leftData new];
        two.title = NSLocalizedString(@"My collection", @"My collection");
        two.image = MY_COLLECTION;
        
//        leftData *three = [leftData new];
//        three.title = NSLocalizedString(@"Browse history", @"Browse history");
//        three.image = BROWSE_HISTORY;
        
        leftData *four = [leftData new];
        four.title = NSLocalizedString(@"My news", @"My news");
        four.image = MY_NEWS;
        
        leftData *five = [leftData new];
        five.title = NSLocalizedString(@"About us", @"About us");
        five.image = ABOUT_US;
        
        _Arry_data = @[one,two,four,five];
    }
    return _Arry_data;
}
- (void)OpenPersonalCenterVc{
    PersonalCenterVc *vc = [PersonalCenterVc new];
    vc.data = self.data;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated{
    if (self.data) {
        [self loadNewData];
    }
}
@end
