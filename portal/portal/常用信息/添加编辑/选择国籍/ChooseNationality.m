//
//  ChooseNationality.m
//  jipiao
//
//  Created by Store on 2017/5/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ChooseNationality.h"
#import "ChooseNationalityCell.h"
#import "ChooseNationalityHead.h"

@interface ChooseNationality ()
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation ChooseNationality

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Choose nationality", @"Choose nationality");  

    // Do any additional setup after loading the view.
    self.tableView.contentInset = UIEdgeInsetsMake(HEIGHT_NAVBAR, 0, 0, 0);
    [self.tableView registerClass:[ChooseNationalityCell class] forCellReuseIdentifier:NSStringFromClass([ChooseNationalityCell class])];
    if ([self.tableView respondsToSelector:@selector(setSectionIndexColor:)]) {
        /** 背景色 */
        self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        /** 字体颜色 */
        self.tableView.sectionIndexColor = ColorWithHex(0x000000, 0.3);
    }
    [self.header beginRefreshing];
}

- (void)loadNewData{
    kWeakSelf(self);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guojia" ofType:@"json"]];
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
        weakself.dataArray = dataArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself loadNewDataEndHeadsuccessSet:nil code:succes_empty_num footerIsShow:NO hasMore:nil];
        });
    });
}
#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([ChooseNationalityCell class]) configuration:^(ChooseNationalityCell *cell) {
        [weakself configureChooseNationalityCell:cell atIndexPath:indexPath];
    }];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ChooseNationalityHead *head = [ChooseNationalityHead new];
    NSDictionary *tmp = self.dataArray[section];
    NSArray *tmpTwo = [tmp allKeys];
    head.headStr = [tmpTwo firstObject];
    head.headStr = [head.headStr uppercaseString];
    return head;
}
#pragma --mark<配置cell>
- (void)configureChooseNationalityCell:(ChooseNationalityCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *tmp = self.dataArray[indexPath.section];
    NSArray *tmpTwo = [tmp allValues];
    NSArray *tmpThree = [tmpTwo firstObject];
    if (tmpTwo.count) {
        NSDictionary *ttt= tmpThree[indexPath.row];
        cell.headStr = ttt[@"countryName"];
    }
}
#pragma mark 右侧索引
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *tmp = [NSMutableArray array];
    for (NSDictionary *dic in self.dataArray) {
        NSArray *tmpTwo = [dic allKeys];
        [tmp addObjectsFromArray:tmpTwo];
    }
    return tmp;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 31;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *tmp = self.dataArray[section];
    NSArray *tmpTwo = [tmp allValues];
    NSInteger cout=0;
    for (NSArray *ttt in tmpTwo) {
        cout += ttt.count;
    }
    return cout;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
#pragma --mark< 点击了  cell >
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.ChoseOK) {
        NSDictionary *tmp = self.dataArray[indexPath.section];
        NSArray *tmpTwo = [tmp allValues];
        NSArray *tmpThree = [tmpTwo firstObject];
        if (tmpTwo.count) {
            NSDictionary *ttt= tmpThree[indexPath.row];
            self.ChoseOK(ttt);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseNationalityCell *cell = [ChooseNationalityCell returnCellWith:tableView];
    [self configureChooseNationalityCell:cell atIndexPath:indexPath];
    return  cell;
}
@end
