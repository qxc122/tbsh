//
//  CommonInformationOneVc.m
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "CommonInformationOneVc.h"
#import "infoCell.h"
#import "AddAndEditTravellerVC.h"
#import "AddAndEditContactsVC.h"
#import "AddAndEditAddressVC.h"
#import "NSString+Add.h"
#import "UIButton+Add.h"
#import "XAlertView.h"

@interface CommonInformationOneVc ()
@property (nonatomic,strong) passengerInfos *datapassengerInfos;
@property (nonatomic,strong) contactInfos *datacontactInfos;
@property (nonatomic,strong) addressInfos *dataaddressInfos;
@property (nonatomic,strong) NSArray *countyArray;
@end

@implementation CommonInformationOneVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.view.backgroundColor = VIEW_BACKGROUND_COLOR;
    [self.tableView registerClass:[infoCell class] forCellReuseIdentifier:NSStringFromClass([infoCell class])];
    if (self.type == InformationType_Contacts) {
        self.NodataTitle = NSLocalizedString(@"Common contact information", @"Common contact information");
        self.NodataDescribe = NSLocalizedString(@"Add contact information, booking more convenient and quick!", @"Add contact information, booking more convenient and quick!");
    }else if (self.type == InformationType_address) {
        self.NodataTitle = NSLocalizedString(@"Common address information", @"Common address information");
        self.NodataDescribe = NSLocalizedString(@"Add common address information, booking more convenient and quick!", @"Add common address information, booking more convenient and quick!");
    }else if (self.type == InformationType_Passenger) {
        self.NodataTitle = NSLocalizedString(@"Common passenger information", @"Common passenger information");
        self.NodataDescribe = NSLocalizedString(@"Add commonly used passenger information, booking more convenient and quick!", @"Add commonly used passenger information, booking more convenient and quick!");
    }
    [self.header beginRefreshing];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BOOL isHaveHead = NO;
    if (self.type == InformationType_Passenger) {
        if (self.datapassengerInfos.Arry_passengerInfos.count) {
            isHaveHead = YES;
        }
    }else if (self.type == InformationType_Contacts) {
        if (self.datacontactInfos.Arry_contactInfos.count) {
           isHaveHead = YES;
        }
    }else if (self.type == InformationType_address) {
        if (self.dataaddressInfos.Arry_addressInfos.count) {
           isHaveHead = YES;
        }
    }
    if (isHaveHead) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 70)];
        headerView.backgroundColor = [UIColor whiteColor];
        UIButton *addBtn= [[UIButton alloc]initWithFrame:CGRectZero];
        
        NSString *title;
        if (self.type == InformationType_Passenger) {
            title= NSLocalizedString(@"New frequent passengers", @"New frequent passengers");
        }else if (self.type == InformationType_Contacts) {
            title= NSLocalizedString(@"New common contacts", @"New common contacts");
        }else if (self.type == InformationType_address) {
            title= NSLocalizedString(@"New common address", @"New common address");
        }
        
        [addBtn setTitle:title forState:UIControlStateNormal];
        [addBtn setTitleColor:ColorWithHex(0x4EA2FF, 1.0) forState:UIControlStateNormal];
        addBtn.titleLabel.font = PingFangSC_Regular(16);
        [addBtn SetFilletWith:PICTURE_FILLET_SIZE];
        [addBtn SetBordersWith:0.5 Color:ColorWithHex(0x4EA2FF, 1.0)];
        
        [headerView addSubview:addBtn];
        
        CGFloat addBtnwidth = [title WidthWithFont:PingFangSC_Regular(16) withMaxHeight:MAXFLOAT]+32;
        if (addBtnwidth > SCREENWIDTH || addBtnwidth < 40) {
            addBtnwidth = 100;
        }
        [addBtn addTarget:self action:@selector(DidTap) forControlEvents:UIControlEventTouchUpInside];
        [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(headerView);
            make.centerY.equalTo(headerView);
            make.height.equalTo(@32);
            make.width.equalTo(@(addBtnwidth));
        }];
        return headerView;
    }
    return nil;
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
    if (self.type == InformationType_Passenger) {
        [[ToolRequest sharedInstance]portalcommonInfoqueryPassengerInfosWithPageNum:self.Pagenumber ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            passengerInfos *data = [passengerInfos mj_objectWithKeyValues:dataDict];
            if (isMore) {
                [weakself.datapassengerInfos.Arry_passengerInfos addObjectsFromArray:data.Arry_passengerInfos];
                [weakself loadMoreDataEndFootsuccessSet:nil hasMore:data.hasMore];
            }else{
                weakself.datapassengerInfos = [passengerInfos mj_objectWithKeyValues:dataDict];
                [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:YES hasMore:weakself.datapassengerInfos.hasMore];
            }
#ifdef DEBUG
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
        } failure:^(NSInteger errorCode, NSString *msg) {
            [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
        }];
    }else if (self.type == InformationType_Contacts) {
        [[ToolRequest sharedInstance]portalcommonInfoqueryContactInfosWithPageNum:self.Pagenumber ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            contactInfos *data = [contactInfos mj_objectWithKeyValues:dataDict];
            if (isMore) {
                [weakself.datacontactInfos.Arry_contactInfos addObjectsFromArray:data.Arry_contactInfos];
                [weakself loadMoreDataEndFootsuccessSet:nil hasMore:data.hasMore];
            }else{
                weakself.datacontactInfos = [contactInfos mj_objectWithKeyValues:dataDict];
                [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:YES hasMore:data.hasMore];
            }
#ifdef DEBUG
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
        } failure:^(NSInteger errorCode, NSString *msg) {
            [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
        }];
    }else if (self.type == InformationType_address) {
        [[ToolRequest sharedInstance]portalcommonInfoqueryAddressInfosWithPageNum:self.Pagenumber ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            addressInfos *data = [addressInfos mj_objectWithKeyValues:dataDict];
            if (isMore) {
                [weakself.dataaddressInfos.Arry_addressInfos addObjectsFromArray:data.Arry_addressInfos];
                [weakself loadMoreDataEndFootsuccessSet:nil hasMore:data.hasMore];
            }else{
                weakself.dataaddressInfos = [addressInfos mj_objectWithKeyValues:dataDict];
                [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:YES hasMore:weakself.dataaddressInfos.hasMore];
            }
#ifdef DEBUG
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
        } failure:^(NSInteger errorCode, NSString *msg) {
            [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
        }];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.type == InformationType_Passenger) {
        if (self.datapassengerInfos.Arry_passengerInfos.count) {
            return 70.f;
        }
    }else if (self.type == InformationType_Contacts) {
        if (self.datacontactInfos.Arry_contactInfos.count) {
            return 70.f;
        }
    }else if (self.type == InformationType_address) {
        if (self.dataaddressInfos.Arry_addressInfos.count) {
            return 70.f;
        }
    }
    return 0.0f;
}

#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([infoCell class]) configuration:^(infoCell *cell) {
        [weakself configureSystemSetCell:cell atIndexPath:indexPath];
    }];
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    infoCell *cell = [infoCell returnCellWith:tableView];
    [self configureSystemSetCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configureSystemSetCell:(infoCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (self.type == InformationType_Passenger) {
        cell.countyArray = self.countyArray;
        cell.data = self.datapassengerInfos.Arry_passengerInfos[indexPath.row];
    }else if (self.type == InformationType_Contacts) {
        cell.data = self.datacontactInfos.Arry_contactInfos[indexPath.row];
    }else if (self.type == InformationType_address) {
        cell.data = self.dataaddressInfos.Arry_addressInfos[indexPath.row];
    }
    kWeakSelf(self);
    cell.deleteBtnOreditBtn = ^(id data, infoCell_type type) {
        [weakself deleteOreditWithOne:data type:type];
    };
}
- (void)deleteOreditWithOne:(id)data type:(infoCell_type)type{
    if (type == editBtn_infoCell_type) {
        [self addAction:NO With:data];
    }else if (type == deleteBtn_infoCell_type){
        kWeakSelf(self);
        NSString *des;
        if (self.type == InformationType_Contacts) {
            des = NSLocalizedString(@"确认删除联系人信息？", @"确认删除联系人信息？");
        }else if (self.type == InformationType_address) {
            des = NSLocalizedString(@"确认删除地址信息？", @"确认删除地址信息？");
        }else if (self.type == InformationType_Passenger) {
            des = NSLocalizedString(@"确认删除旅客信息？", @"确认删除旅客信息？");
        }
        
        XAlertView *alert = [[XAlertView alloc]initWithTitle:NSLocalizedString(@"提示", @"提示") message:des clickedBlock:^(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex) {
            if (!canceled) {
                [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Delete...", @"Delete...") toView:weakself.view];
                if ([data isKindOfClass:[passengerInfos_one class]]) {
                    passengerInfos_one *tmp = (passengerInfos_one *)data;
                    [[ToolRequest sharedInstance]commonInfodeletePassengerInfoWithpassengerId:tmp.passengerId ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
                        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                        [MBProgressHUD showPrompt:NSLocalizedString(@"Delete successfully", @"Delete successfully") toView:weakself.view];
                        NSInteger myrow = 0;
                        for (passengerInfos_one *one in weakself.datapassengerInfos.Arry_passengerInfos) {
                            if ([one isEqual:tmp]) {
                                [weakself.datapassengerInfos.Arry_passengerInfos removeObject:one];
                                if (weakself.datapassengerInfos.Arry_passengerInfos.count == 0) {
                                    [weakself.tableView reloadData];
                                    break;
                                }else{
                                    [weakself.tableView beginUpdates];
                                    NSIndexPath *tmpPath = [NSIndexPath indexPathForRow:myrow inSection:0];
                                    [weakself.tableView deleteRowsAtIndexPaths:@[tmpPath] withRowAnimation:UITableViewRowAnimationLeft];
                                    [weakself.tableView endUpdates];
                                    break;
                                }
                            }
                            myrow++;
                        }
                    } failure:^(NSInteger errorCode, NSString *msg) {
                        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                        [MBProgressHUD showPrompt:msg toView:weakself.view];
                    }];
                } else if ([data isKindOfClass:[contactInfos_one class]]) {
                    contactInfos_one *tmp = (contactInfos_one *)data;
                    [[ToolRequest sharedInstance]portalcommonInfodeleteContactInfoWithcontactId:tmp.contactId ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
                        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                        [MBProgressHUD showPrompt:NSLocalizedString(@"Delete successfully", @"Delete successfully") toView:weakself.view];
                        NSInteger myrow = 0;
                        for (contactInfos_one *one in weakself.datacontactInfos.Arry_contactInfos) {
                            if ([one isEqual:tmp]) {
                                [weakself.datacontactInfos.Arry_contactInfos removeObject:one];
                                if (weakself.datacontactInfos.Arry_contactInfos.count == 0) {
                                    [weakself.tableView reloadData];
                                    break;
                                }else{
                                    [weakself.tableView beginUpdates];
                                    NSIndexPath *tmpPath = [NSIndexPath indexPathForRow:myrow inSection:0];
                                    [weakself.tableView deleteRowsAtIndexPaths:@[tmpPath] withRowAnimation:UITableViewRowAnimationLeft];
                                    [weakself.tableView endUpdates];
                                    break;
                                }
                            }
                            myrow++;
                        }
                    } failure:^(NSInteger errorCode, NSString *msg) {
                        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                        [MBProgressHUD showPrompt:msg toView:weakself.view];
                    }];
                } else if ([data isKindOfClass:[addressInfos_one class]]) {
                    addressInfos_one *tmp = (addressInfos_one *)data;
                    [[ToolRequest sharedInstance]portalcommonInfodeleteAddressInfoWithaddressId:tmp.addressId ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
                        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                        [MBProgressHUD showPrompt:NSLocalizedString(@"Delete successfully", @"Delete successfully") toView:weakself.view];
                        NSInteger myrow = 0;
                        for (addressInfos_one *one in weakself.dataaddressInfos.Arry_addressInfos) {
                            if ([one isEqual:tmp]) {
                                [weakself.dataaddressInfos.Arry_addressInfos removeObject:one];
                                if (weakself.dataaddressInfos.Arry_addressInfos.count == 0) {
                                    [weakself.tableView reloadData];
                                    break;
                                }else{
                                    [weakself.tableView beginUpdates];
                                    NSIndexPath *tmpPath = [NSIndexPath indexPathForRow:myrow inSection:0];
                                    [weakself.tableView deleteRowsAtIndexPaths:@[tmpPath] withRowAnimation:UITableViewRowAnimationLeft];
                                    [weakself.tableView endUpdates];
                                    break;
                                }
                            }
                            myrow++;
                        }
                    } failure:^(NSInteger errorCode, NSString *msg) {
                        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
                        [MBProgressHUD showPrompt:msg toView:weakself.view];
                    }];
                }
                
            }
        } cancelButtonTitle:NSLocalizedString(@"取消", @"取消") otherButtonTitles:NSLocalizedString(@"确定", @"确定"), nil];
        [alert show];
    }
}
#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.type == InformationType_Passenger) {
        return self.datapassengerInfos.Arry_passengerInfos.count;
    }else if (self.type == InformationType_Contacts) {
        return self.datacontactInfos.Arry_contactInfos.count;
    }else if (self.type == InformationType_address) {
        return self.dataaddressInfos.Arry_addressInfos.count;
    }
    return 0;
}

- (void)addAction:(BOOL)IsAdd With:(id)data{
    UIViewController *vc;
    kWeakSelf(self);
    if (self.type == InformationType_Passenger) {
        AddAndEditTravellerVC *VC = [[AddAndEditTravellerVC alloc]init];
        vc = VC;
        VC.AddOrEditSucdess = ^{
            weakself.header.hidden= NO;
            [weakself.header beginRefreshing];
        };
    }else if (self.type == InformationType_Contacts) {
        AddAndEditContactsVC *VC = [[AddAndEditContactsVC alloc]init];
        vc = VC;
        VC.AddOrEditSucdess = ^{
            weakself.header.hidden= NO;
            [weakself.header beginRefreshing];
        };
    }else if (self.type == InformationType_address) {
        AddAndEditAddressVC *VC = [[AddAndEditAddressVC alloc]init];
        vc = VC;
        VC.AddOrEditSucdess = ^{
            weakself.header.hidden= NO;
            [weakself.header beginRefreshing];
        };
    }
    if (vc) {
        if (data) {
            id dataCopy = [data copy];
            [vc setValue:dataCopy forKey:@"data"];
        }
        [vc setValue:@(IsAdd) forKey:@"IsAdd"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (self.empty_type == succes_empty_num) {
        NSString *title;
        if (self.type == InformationType_Passenger) {
            title= NSLocalizedString(@"New frequent passengers", @"New frequent passengers");
        }else if (self.type == InformationType_Contacts) {
            title= NSLocalizedString(@"New common contacts", @"New common contacts");
        }else if (self.type == InformationType_address) {
            title= NSLocalizedString(@"New common address", @"New common address");
        }
        return [title CreatMutableAttributedStringWithFont:PingFangSC_Regular(16) Color:ColorWithHex(0x4EA2FF, 1.0) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
    }else{
        return [super buttonTitleForEmptyDataSet:scrollView forState:state];
    }
    return nil;
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (self.empty_type == succes_empty_num) {
        return [UIImage imageNamed:EMPTY_STATUS_BUTTON_BOX];
    }else{
        return [super buttonBackgroundImageForEmptyDataSet:scrollView forState:state];
    }
    return nil;
}

//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {

}

- (void)DidTap{
    if (self.empty_type == succes_empty_num) {
        [self addAction:YES With:nil];
    }else{
        [super DidTap];
    }
}
- (NSArray *)countyArray{
    if (!_countyArray) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"guojia" ofType:@"json"]];
            NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
            _countyArray = dataArray;
//        });
    }
    return _countyArray;
}
@end
