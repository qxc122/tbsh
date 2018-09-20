//
//  MyNewsVc.m
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "MyNewsVc.h"
#import "MyNewsCell.h"
#import "baseWkVc.h"

@interface MyNewsVc ()
@property (nonatomic,strong) MyNewsData *data;
@end

@implementation MyNewsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[MyNewsCell class] forCellReuseIdentifier:NSStringFromClass([MyNewsCell class])];
    self.view.backgroundColor = VIEW_BACKGROUND_COLOR;
    self.tableView.contentInset = UIEdgeInsetsMake(HEIGHT_NAVBAR, 0, 15, 0);
    [self.header beginRefreshing];
    
}

- (void)loadNewData{
    [self loadData:NO];
}
- (void)loadMoreData{
    [self loadData:YES];
}
- (void)loadData:(BOOL)isMore{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]portalusermyNewWithPageNum:self.Pagenumber ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        MyNewsData *data = [MyNewsData mj_objectWithKeyValues:dataDict];
        if (isMore) {
            [weakself.data.Arry_newsList addObjectsFromArray:data.Arry_newsList];
            [weakself loadMoreDataEndFootsuccessSet:nil hasMore:weakself.data.hasMore];
        }else{
            weakself.data = [MyNewsData mj_objectWithKeyValues:dataDict];
            [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:YES hasMore:weakself.data.hasMore];
        }
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
    }];
}

#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([MyNewsCell class]) configuration:^(MyNewsCell *cell) {
        [weakself configureMyNewsCell:cell atIndexPath:indexPath];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyNewsData_One *data = self.data.Arry_newsList[indexPath.row];
    baseWkVc *vc =[baseWkVc new];
    vc.url = data.newsLink;
    vc.title = data.newsTitle;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyNewsCell *cell = [MyNewsCell returnCellWith:tableView];
    [self configureMyNewsCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configureMyNewsCell:(MyNewsCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.data = self.data.Arry_newsList[indexPath.row];
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.Arry_newsList.count;
}
@end
