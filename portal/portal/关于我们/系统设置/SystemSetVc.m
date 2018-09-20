//
//  SystemSetVc.m
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "SystemSetVc.h"
#import "SystemSetCell.h"
@interface SystemSetVc ()

@end

@implementation SystemSetVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(HEIGHT_NAVBAR);
        make.bottom.equalTo(self.view);
    }];
    self.view.backgroundColor = VIEW_BACKGROUND_COLOR;
    [self.tableView registerClass:[SystemSetCell class] forCellReuseIdentifier:NSStringFromClass([SystemSetCell class])];
    // Do any additional setup after loading the view.
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;
}

#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([SystemSetCell class]) configuration:^(SystemSetCell *cell) {
        [weakself configureSystemSetCell:cell atIndexPath:indexPath];
    }];
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SystemSetCell *cell = [SystemSetCell returnCellWith:tableView];
    [self configureSystemSetCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configureSystemSetCell:(SystemSetCell *)cell atIndexPath:(NSIndexPath *)indexPath {

}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

@end
