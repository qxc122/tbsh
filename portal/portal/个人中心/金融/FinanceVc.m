//
//  FinanceVc.m
//  portal
//
//  Created by Store on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "FinanceVc.h"
#import "NavigationBarDetais.h"
#import "SDCycleScrollView.h"
#import "InsuranceHead.h"
#import "TourismCell.h"
#import "InsuranceCell.h"
#import "ConductFinancialTransactionsCell.h"
#import "fundCell.h"
#import "EachWkVc.h"
#import "PortalHelper.h"
#import "XAlertView.h"
@interface FinanceVc ()<UIScrollViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic,strong) FinanceVcData *data;  
@property (nonatomic,weak) SDCycleScrollView *Head;
@property (nonatomic,weak) NavigationBarDetais *NaviBar;
@property (nonatomic,weak) SDCycleScrollView *placeHead;
@end

@implementation FinanceVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[TourismCell class] forCellReuseIdentifier:NSStringFromClass([TourismCell class])];
    [self.tableView registerClass:[ConductFinancialTransactionsCell class] forCellReuseIdentifier:NSStringFromClass([ConductFinancialTransactionsCell class])];
    [self.tableView registerClass:[fundCell class] forCellReuseIdentifier:NSStringFromClass([fundCell class])];
    [self.tableView registerClass:[InsuranceCell class] forCellReuseIdentifier:NSStringFromClass([InsuranceCell class])];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor  =VIEW_BACKGROUND_COLOR;
    [self.header beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(GET_NEW_TOKEN_NOTIFICATIONFunc:)
                                                 name:GET_NEW_TOKEN_NOTIFICATION
                                               object:nil];
    
    
    //    [self openCashierVcWithData:nil block:^{
    //
    //    }];
//    self.empty_type = NoNetworkConnection_empty_num;
}

- (void)GET_NEW_TOKEN_NOTIFICATIONFunc:(NSNotification *)user{
    self.header.hidden = NO;
    [self.header beginRefreshing];
}

- (void)setUi{
    NavigationBarDetais *NaviBar = [NavigationBarDetais new];
    self.NaviBar = NaviBar;
    NaviBar.title.text = NSLocalizedString(@"Finance", @"Finance");
    [self.view addSubview:NaviBar];
    [NaviBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@(HEIGHT_NAVBAR));
    }];
    kWeakSelf(self);
    NaviBar.brnClickType = ^(NavigationBarDetais_Click_ENMU type) {
        if (type == keepOrshare_NavigationBarDetais_Click_ENMU) {
            //TODO
        }else if (type == back_NavigationBarDetais_Click_ENMU){
            [weakself popSelf];
        }
    };
}

- (void)loadNewData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]portalqueryFinaProductsssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        weakself.data = [FinanceVcData mj_objectWithKeyValues:dataDict];
        [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
        [weakself setUi];
        if (weakself.data.Arry_tpurseProductList.count) {
            weakself.tableView.tableHeaderView = weakself.placeHead;
            NSMutableArray *imageURLStringsGroup = [NSMutableArray array];
            for (FinanceVcData_One *one in weakself.data.Arry_tpurseProductList) {
                [imageURLStringsGroup addObject:one.productPicture];
            }
//            NSMutableArray *tmp = [NSMutableArray array];
//            [tmp addObjectsFromArray:imageURLStringsGroup];
//            [tmp addObjectsFromArray:imageURLStringsGroup];
//            [tmp addObjectsFromArray:imageURLStringsGroup];
//            weakself.Head.imageURLStringsGroup = tmp;
//            weakself.placeHead.imageURLStringsGroup = tmp;
            
            weakself.Head.imageURLStringsGroup = imageURLStringsGroup;
            weakself.placeHead.imageURLStringsGroup = imageURLStringsGroup;
        }
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"sdf");
        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.data.Arry_insuranceProductList.count  && section==3) {
        return 46.0;
    }
    return 0.001;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.data.Arry_insuranceProductList.count && section==3) {
        return [InsuranceHead new];
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        FinanceVcData_One *data = self.data.Arry_insuranceProductList[indexPath.row];
        if (data.needLogin && ![PortalHelper sharedInstance].userInfo) {
            if (self.FLAG_IN_DATA_UPDATE) {
                [MBProgressHUD showPrompt:NSLocalizedString(@"Data is being refreshed...", @"Data is being refreshed...") toView:self.view];
            }else{
//                kWeakSelf(self);
                [self openLoginView:^{
//                    weakself.FLAG_IN_DATA_UPDATE = YES;
//                    [weakself loadNewData];
                }];
            }
        } else {
            [self OpenEachWkVc:data.productLink WithIndexPath:indexPath WithmerchName:data.productName];
        }
    }
}

#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([TourismCell class]) configuration:^(TourismCell *cell) {
            [weakself configureTourismCell:cell atIndexPath:indexPath];
        }];
    } else if (indexPath.section == 1) {
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([ConductFinancialTransactionsCell class]) configuration:^(ConductFinancialTransactionsCell *cell) {
            [weakself configureConductFinancialTransactionsCell:cell atIndexPath:indexPath];
        }];
    } else if (indexPath.section == 2) {
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([fundCell class]) configuration:^(fundCell *cell) {
            [weakself configurefundCell:cell atIndexPath:indexPath];
        }];
    } else if (indexPath.section == 3) {
        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([InsuranceCell class]) configuration:^(InsuranceCell *cell) {
            [weakself configureInsuranceCell:cell atIndexPath:indexPath];
        }];
    }
    return 0.001;
}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TourismCell *cell = [TourismCell returnCellWith:tableView];
        [self configureTourismCell:cell atIndexPath:indexPath];
        return  cell;
    } else if (indexPath.section == 1) {
        ConductFinancialTransactionsCell *cell = [ConductFinancialTransactionsCell returnCellWith:tableView];
        [self configureConductFinancialTransactionsCell:cell atIndexPath:indexPath];
        return  cell;
    } else if (indexPath.section == 2) {
        fundCell *cell = [fundCell returnCellWith:tableView];
        [self configurefundCell:cell atIndexPath:indexPath];
        return  cell;
    } else if (indexPath.section == 3) {
        InsuranceCell *cell = [InsuranceCell returnCellWith:tableView];
        [self configureInsuranceCell:cell atIndexPath:indexPath];
        return  cell;
    }
    return nil;
}
#pragma --mark< 配置TourismCell 的数据>
- (void)configureTourismCell:(TourismCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.Arry_tourProductList = self.data.Arry_tourProductList;
    kWeakSelf(self);
    cell.SelectIndex = ^(FinanceVcData_One *data) {
        if (data.needLogin && ![PortalHelper sharedInstance].userInfo) {
            if (weakself.FLAG_IN_DATA_UPDATE && weakself.data) {
                [MBProgressHUD showPrompt:NSLocalizedString(@"You just landed. Data is being refreshed...", @"You just landed. Data is being refreshed...") toView:weakself.view];
            }else{
                [weakself openLoginView:^{
//                    weakself.FLAG_IN_DATA_UPDATE = YES;
//                    [weakself loadNewData];
                }];
            }
        } else {
            [weakself OpenEachWkVc:data.productLink WithIndexPath:indexPath WithmerchName:data.productName];
        }
    };
}

#pragma --mark< OpenEachWkVc >
- (void)OpenEachWkVc:(id)url WithIndexPath:(NSIndexPath *)indexPath WithmerchName:(NSString *)merchName{
    EachWkVc *vc = [EachWkVc new];
    vc.url = url;
    if (indexPath.section == 1) {
        vc.IsHaveRightBtn = NO;
    }else{
        vc.IsHaveRightBtn = YES;
        vc.merchId = self.merchId;
        vc.merchName = merchName;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma --mark< 配置TourismCell 的数据>
- (void)configureInsuranceCell:(InsuranceCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.data = self.data.Arry_insuranceProductList[indexPath.row];
}
#pragma --mark< 配置TourismCell 的数据>
- (void)configureConductFinancialTransactionsCell:(ConductFinancialTransactionsCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.vcProductPicture = self.data.vcProductPicture;
    kWeakSelf(self);
    cell.gotoDoing = ^{
        [weakself OpenEachWkVc:weakself.data.vcProductLink WithIndexPath:indexPath WithmerchName:nil];
    };
}
#pragma --mark< 配置TourismCell 的数据>
- (void)configurefundCell:(fundCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fundProductPicture = self.data.fundProductPicture;
    kWeakSelf(self);
    cell.gotoDoing = ^{
        [weakself OpenEachWkVc:weakself.data.fundProductLink WithIndexPath:indexPath WithmerchName:@"基金"];
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return self.data.Arry_insuranceProductList.count;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.data) {
        return 4;
    }
    return 0;
}

- (SDCycleScrollView *)Head{
    if (!_Head) {
        SDCycleScrollView *head = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 196*PROPORTION_HEIGHT)];
        [self.view addSubview:head];
//        [self.view  bringSubviewToFront:self.tableView];
        [self.view  bringSubviewToFront:self.NaviBar];
        head.bannerImageViewContentMode = UIViewContentModeScaleAspectFill; 
        head.hidden = YES;
        head.delegate = self;
        _Head = head;
    }
    return _Head;
}
- (SDCycleScrollView *)placeHead{
    if (!_placeHead) {
        SDCycleScrollView *head = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 196*PROPORTION_HEIGHT)];
        _placeHead = head;
        self.tableView.tableHeaderView = _placeHead;
        head.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        head.delegate = self;
    }
    return _placeHead;
}
- (void)placeHeadClick{
    NSLog(@"%s",__FUNCTION__);
    NSString *TUlr = @"togetherTPay://";
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:TUlr]]){
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
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    if (self.data) {
//        [self.Head removeFromSuperview];
//        NSMutableArray *imageURLStringsGroup = [NSMutableArray array];
//        for (FinanceVcData_One *one in self.data.Arry_tpurseProductList) {
//            [imageURLStringsGroup addObject:one.productPicture];
//        }
//        self.Head.imageURLStringsGroup = imageURLStringsGroup;
//    }
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.data) {
        CGFloat yy = scrollView.contentOffset.y;
        NSLog(@"yy=%f",yy);
        if (yy >= 0) {
            self.Head.hidden = YES;
            self.Head.frame = CGRectMake(0, -yy, SCREENWIDTH, 196*PROPORTION_HEIGHT);
        } else if (yy < 0) {
            self.Head.hidden = NO;
            self.Head.frame = CGRectMake(0, 0, SCREENWIDTH, 196*PROPORTION_HEIGHT-yy);
        }
        if (yy == 0) {
            self.Head.autoScroll = YES;
            self.placeHead.autoScroll = YES;
        }else{
            self.Head.autoScroll = NO;
            self.placeHead.autoScroll = NO;
        }
        if (yy >= (196*PROPORTION_HEIGHT-HEIGHT_NAVBAR)) {
            self.NaviBar.alpaImage = 1.0;
        } else {
            self.NaviBar.alpaImage = 0.0;
        }
    }
}
- (void)dealloc{
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    FinanceVcData_One *data = self.data.Arry_tpurseProductList[index];
    if (data.productLink) {
        [self OpenEachWkVc:data.productLink WithIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] WithmerchName:data.productName];
    } else {
        [self placeHeadClick];
    }
}
@end
