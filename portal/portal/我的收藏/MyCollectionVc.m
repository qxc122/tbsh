//
//  MyCollectionVc.m
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "MyCollectionVc.h"
#import "BrowseHistoryCell.h"
#import "EachWkVc.h"
#import "UIImage+Add.h"
#import "NSString+Add.h"
#import "deleteBrowseHistoryCell.h"
#import "XAlertView.h"
@interface MyCollectionVc ()
@property (nonatomic,strong) MyCollecData *data;
@property (nonatomic,weak) UIButton *deleteBtn;
@property (nonatomic,strong) NSMutableArray *deleteArry;
@end

@implementation MyCollectionVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.header beginRefreshing];
    self.deleteArry = [NSMutableArray array];
    [self.tableView registerClass:[BrowseHistoryCell class] forCellReuseIdentifier:NSStringFromClass([BrowseHistoryCell class])];
    [self.tableView registerClass:[deleteBrowseHistoryCell class] forCellReuseIdentifier:NSStringFromClass([deleteBrowseHistoryCell class])];

    self.tableView.contentInset = UIEdgeInsetsMake(HEIGHT_NAVBAR, 0, 0, 0);
    [self.header beginRefreshing];
    self.NodataTitle = @"暂无收藏，快去逛逛吧";
}


- (void)CreatRightBtn{
    UIButton *clear = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [clear setTitle:NSLocalizedString(@"编辑", @"编辑") forState:UIControlStateNormal];
    [clear setTitleColor:ColorWithHex(0x4EA2FF , 1.0) forState:UIControlStateNormal];
    clear.titleLabel.font = PingFangSC_Regular(17);
    self.deleteBtn = clear;
    [clear addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:clear];
    
    UIButton *deleteBtn = [UIButton new];
    [self.view addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.tableView.mas_bottom);
        make.height.equalTo(@(50));
    }];
    [deleteBtn addTarget:self action:@selector(deleteArry:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.backgroundColor = ColorWithHex(0xFB704B, 1.0);
    [deleteBtn setTitle:NSLocalizedString(@"取消收藏", @"取消收藏") forState:UIControlStateNormal];
    [deleteBtn setTitleColor:ColorWithHex(0xFFFFFF, 1.0) forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = PingFangSC_Regular(16);
    
}
- (void)deleteArry:(UIButton *)btn{
    if (self.deleteArry.count) {
        [self delsetshouc:self.deleteArry];
    }else{
        [MBProgressHUD showPrompt:NSLocalizedString(@"请先选择要删除的项", @"请先选择要删除的项") toView:self.view];
    }
}
- (void)clearClick{
    if (self.deleteBtn.tag == 0) {
        self.deleteBtn.tag = 1;
        [self.deleteBtn setTitle:NSLocalizedString(@"完成", @"完成") forState:UIControlStateNormal];
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view);
            make.left.equalTo(self.view);
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-50);
        }];
    } else if (self.deleteBtn.tag == 1) {
        self.deleteBtn.tag = 0;
        [self.deleteBtn setTitle:NSLocalizedString(@"编辑", @"编辑") forState:UIControlStateNormal];
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view);
            make.left.equalTo(self.view);
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
    [self.tableView reloadData];
}
- (void)loadNewData{
    self.Pagenumber = FIRSTPAGE;
    [self loadData:NO];
}
- (void)loadMoreData{
    [self loadData:YES];
}
- (void)loadData:(BOOL)isMore{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]URLBASIC_portalqueryFavoritesWithPageNum:self.Pagenumber sssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        MyCollecData *data = [MyCollecData mj_objectWithKeyValues:dataDict];
        if (isMore) {
            [weakself.data.Arry_List addObjectsFromArray:data.Arry_List];
            [weakself loadMoreDataEndFootsuccessSet:nil hasMore:data.hasMore];
        }else{
            weakself.data = data;
            [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:YES hasMore:weakself.data.hasMore];
        }
        if (data.Arry_List.count) {
            [weakself CreatRightBtn];
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
    if (self.deleteBtn.tag == 1) {
        kWeakSelf(self);
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([deleteBrowseHistoryCell class]) configuration:^(deleteBrowseHistoryCell *cell) {
            [weakself configuredeleteBrowseHistoryCell:cell atIndexPath:indexPath];
        }];
    } else if (self.deleteBtn.tag == 0) {
        kWeakSelf(self);
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([BrowseHistoryCell class]) configuration:^(BrowseHistoryCell *cell) {
            [weakself configureBrowseHistoryCell:cell atIndexPath:indexPath];
        }];
    }
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.deleteBtn.tag == 0) {
        MyCollecData_One *data = self.data.Arry_List[indexPath.row];
        EachWkVc *vc =[EachWkVc new];
        vc.url = data.url;
        vc.title = data.title;
        vc.IsHaveRightBtn = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.deleteBtn.tag == 1) {
        deleteBrowseHistoryCell *cell = [deleteBrowseHistoryCell returnCellWith:tableView];
        [self configuredeleteBrowseHistoryCell:cell atIndexPath:indexPath];
        return  cell;
    } else if (self.deleteBtn.tag == 0) {
        BrowseHistoryCell *cell = [BrowseHistoryCell returnCellWith:tableView];
        [self configureBrowseHistoryCell:cell atIndexPath:indexPath];
        return  cell;
    }
    return nil;
}

#pragma --mark< 配置deleteBrowseHistoryCell 的数据>
- (void)configuredeleteBrowseHistoryCell:(deleteBrowseHistoryCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.data = self.data.Arry_List[indexPath.row];
    kWeakSelf(self);
    cell.SelectIndex = ^(NSNumber *favorId) {
        if ([weakself.deleteArry containsObject:favorId]) {
            [weakself.deleteArry removeObject:favorId];
        }else{
            [weakself.deleteArry addObject:favorId];
        }
    };
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configureBrowseHistoryCell:(BrowseHistoryCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.data = self.data.Arry_List[indexPath.row];
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.Arry_List.count;
}

//#pragma --mark< 编辑  cell >
//-(NSArray *)tableView:(UITableView* )tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewRowAction *deleteRoWAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"取消收藏" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {//title可自已定义
//        MyCollecData_One *one = self.data.Arry_List[indexPath.row];
//        [self delsetshouc:@[one.favorId]];
//    }];
//    deleteRoWAction.backgroundColor = [UIColor redColor];
//    return @[deleteRoWAction];//最后返回这俩个RowAction 的数组
//}
//#pragma --mark< 是否可以编辑 cell >
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    return  YES;
//}
#pragma --mark< 取消收藏 cell >
- (void)delsetshouc:(NSArray *)arry{
    if (!arry.count) {
        return;
    }
    kWeakSelf(self);
    XAlertView *alert = [[XAlertView alloc]initWithTitle:NSLocalizedString(@"Prompt", @"Prompt")  message:NSLocalizedString(@"确认取消收藏吗？", @"确认取消收藏吗？") clickedBlock:^(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex) {
        if (!canceled) {
            [MBProgressHUD showLoadingMessage:@"取消收藏中..." toView:self.view];
            [[ToolRequest sharedInstance] URLBASIC_portalcancelFavoriteWithlist:arry sssuccess:^(id dataDict, NSString *msg, NSInteger code) {
                [MBProgressHUD hideHUDForView:weakself.view];
                [MBProgressHUD showPrompt:@"取消收藏成功" toView:weakself.view];
                
                NSMutableArray *tmp = [NSMutableArray array];
                NSMutableArray *Paths = [NSMutableArray array];
                for (NSNumber * favorId in arry) {
                    NSInteger row=0;
                    for (MyCollecData_One *one in self.data.Arry_List) {
                        if ([one.favorId isEqualToNumber:favorId]) {
                            [tmp addObject:one];
                            [Paths addObject:[NSIndexPath indexPathForRow:row inSection:0]];
                        }
                        row++;
                    }
                }
                if (tmp.count) {
                    [weakself.data.Arry_List removeObjectsInArray:tmp];
                    [weakself.tableView beginUpdates];
                    [weakself.tableView deleteRowsAtIndexPaths:Paths withRowAnimation:UITableViewRowAnimationLeft];
                    [weakself.tableView endUpdates];
                    
                    if (!weakself.data.Arry_List.count) {
                        weakself.deleteBtn.hidden = YES;
                    }
                    [weakself clearClick];
                }
            } failure:^(NSInteger errorCode, NSString *msg) {
                [MBProgressHUD hideHUDForView:weakself.view];
                [MBProgressHUD showPrompt:msg toView:weakself.view];
            }];
        }
    } cancelButtonTitle:NSLocalizedString(@"cancel", @"cancel") otherButtonTitles:NSLocalizedString(@"Determine", @"Determine"), nil];
    [alert show];
}

//按钮文本或者背景样式
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (self.empty_type == succes_empty_num) {
        return [NSLocalizedString(@"去逛逛", @"去逛逛") CreatMutableAttributedStringWithFont:PingFangSC_Regular(16) Color:ColorWithHex(0x4EA2FF, 1.0) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
    }
    return [super buttonTitleForEmptyDataSet:scrollView forState:state];
}
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (self.empty_type == succes_empty_num) {
        return  [UIImage imageNamed:EMPTY_STATUS_BUTTON_BOX];
    }
    return [super buttonBackgroundImageForEmptyDataSet:scrollView forState:state];
}
- (void)DidTap{
    if (self.empty_type == succes_empty_num) {
        NSNotification *notification =[NSNotification notificationWithName:GO_FOR_A_STROLL object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];

    }else{
        [super DidTap];
    }
}
@end
