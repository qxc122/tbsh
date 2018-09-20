//
//  AddAndEditTravellerVC.m
//  portal
//
//  Created by TFT on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AddAndEditTravellerVC.h"
#import "travellerCell.h"
#import "datePiker.h"
#import "AlertAction.h"
#import "AlertView.h"
#import "ChooseNationality.h"
#import "NSString+Add.h"
@interface AddAndEditTravellerVC ()
{
    
    NSArray *titleArray;
    NSArray *contentArray;
    NSArray *identiferArry;
}

@property (nonatomic,strong) UIButton *selBtn;
@property (nonatomic,strong) NSString *passenger_type;
@property (nonatomic,strong) NSArray *countyArray;
@property (nonatomic,weak) UITextField *input;
@end

@implementation AddAndEditTravellerVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.IsAdd = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    identiferArry = @[KEY_NAME,KEY_SUNAME,KEY_ENNAME,KEY_CERNO,KEY_BIRTHDAY,KEY_SEX,KEY_NATIONALITY,KEY_EXPIREDATE,KEY_MOBILE];
    titleArray = @[NSLocalizedString(@"Chinese name", @"Chinese name"),NSLocalizedString(@"English surname", @"English surname"),NSLocalizedString(@"English name", @"English name"),NSLocalizedString(@"passport", @"passport"),NSLocalizedString(@"Date of birth", @"Date of birth"),NSLocalizedString(@"Gender", @"Gender"),NSLocalizedString(@"nationality", @"nationality"),NSLocalizedString(@"Term of validity", @"Term of validity"),NSLocalizedString(@"Phone number", @"Phone number")];
    contentArray = @[NSLocalizedString(@"Please enter full Chinese name", @"Please enter full Chinese name"),NSLocalizedString(@"Such as ZHANG", @"Such as ZHANG"),NSLocalizedString(@"Such as SAN", @"Such as SAN"),NSLocalizedString(@"Please enter your identification number", @"Please enter your identification number"),NSLocalizedString(@"Please select", @"Please select"),@"",NSLocalizedString(@"Please select", @"Please select"),NSLocalizedString(@"Please select", @"Please select"),NSLocalizedString(@"Please select", @"Please select"),NSLocalizedString(@"Please enter the mobile phone number (optional)", @"Please enter the mobile phone number (optional)")];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(HEIGHT_NAVBAR);
        make.bottom.equalTo(self.view);
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[travellerCell class] forCellReuseIdentifier:NSStringFromClass([travellerCell class])];
    // Do any additional setup after loading the view.
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;
    
    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [okBtn setTitle:NSLocalizedString(@"Preservation", @"Preservation") forState:UIControlStateNormal];
    [okBtn setTitleColor:ColorWithHex(0x4EA2FF , 1.0) forState:UIControlStateNormal];
    okBtn.titleLabel.font = PingFangSC_Regular(17);
    [okBtn addTarget:self action:@selector(okBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:okBtn];
    
    self.passenger_type = PASSENGER_TYPE_NI;
    self.data.certType = PASSENGER_TYPE_NI;
    for (certInfos_one *one in self.data.Arry_certInfos) {
        self.passenger_type = one.certType;
        self.data.certType = one.certType;
        self.data.certNo = one.certNo;
        self.data.nationalityCode = one.nationality;
        self.data.expireDate = one.expireDate;
        break;
    }
    if (self.IsAdd) {
        self.title = NSLocalizedString(@"New passenger", @"New passenger");
    } else {
        self.title = NSLocalizedString(@"Edit passenger", @"Edit passenger");
    }
    if ([self.data.selfFlag isEqualToString:STRING_1]) {
        _selBtn.selected = YES;
    }
}

- (void)okBtnClick:(UIButton *)btn{
    NSLog(@"%s",__func__);
    if ([self.input canResignFirstResponder]) {
        [self.input resignFirstResponder];
    }
    if (!self.data.name || !self.data.name.length) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please enter full Chinese name", @"Please enter full Chinese name") toView:self.view];
        return;
    }
    if (!self.data.surname || !self.data.surname.length) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请输入英文姓", @"请输入英文姓") toView:self.view];
        return;
    }
    if (!self.data.enName || !self.data.enName.length) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请输入英文名", @"请输入英文名") toView:self.view];
        return;
    }
    if (!self.data.certNo || !self.data.certNo.length || ([self.passenger_type isEqualToString:PASSENGER_TYPE_NI] && ![self.data.certNo IsIdCardNumber])) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please enter OK your identification number", @"Please enter OK your identification number") toView:self.view];
        return;
    }
    if (!self.data.birthday || !self.data.birthday.length) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please choose the date of birth", @"Please choose the date of birth") toView:self.view];
        return;
    }
    if (!self.data.sex || !self.data.sex.length) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please choose gender", @"Please choose gender") toView:self.view];
        return;
    }
    if (!self.data.nationalityCode || !self.data.nationalityCode.length) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please choose nationality", @"Please choose nationality") toView:self.view];
        return;
    }
    if (!self.data.expireDate || !self.data.expireDate.length) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please select the valid period of the document", @"Please select the valid period of the document") toView:self.view];
        return;
    }
    if (self.data.mobile.length && ![self.data.mobile IsTelNumber]) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please enter the correct cell phone number", @"Please enter the correct cell phone number") toView:self.view];
        return;
    }
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"In storage...", @"In storage...") toView:self.view];
    kWeakSelf(self);
    if (self.IsAdd) {
        [[ToolRequest sharedInstance]commonInfoaddPassengerInfoWithname:self.data.name surname:self.data.surname enName:self.data.enName mobile:self.data.mobile sex:self.data.sex birthday:self.data.birthday selfFlag:self.data.selfFlag nationality:self.data.nationalityCode certType:self.data.certType certNo:self.data.certNo expireDate:self.data.expireDate ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
            [MBProgressHUD showPrompt:NSLocalizedString(@"Save successfully", @"Save successfully") toView:weakself.view];
            [weakself performSelector:@selector(popSelf) withObject:nil afterDelay:MANY_SECONDS];
            if (weakself.AddOrEditSucdess) {
                weakself.AddOrEditSucdess();
            }
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
            [MBProgressHUD showPrompt:msg toView:weakself.view];
        }];
    } else {
        [[ToolRequest sharedInstance]commonInfoeditPassengerInfoWithpassengerId:self.data.passengerId name:self.data.name surname:self.data.surname enName:self.data.enName mobile:self.data.mobile sex:self.data.sex birthday:self.data.birthday selfFlag:self.data.selfFlag nationality:self.data.nationalityCode certType:self.data.certType certNo:self.data.certNo expireDate:self.data.expireDate ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
            [MBProgressHUD showPrompt:NSLocalizedString(@"Save successfully", @"Save successfully") toView:weakself.view];
            [weakself performSelector:@selector(popSelf) withObject:nil afterDelay:MANY_SECONDS];
            if (weakself.AddOrEditSucdess) {
                weakself.AddOrEditSucdess();
            }
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view animated:YES];
            [MBProgressHUD showPrompt:msg toView:weakself.view];
        }];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 9)];
    footerView.backgroundColor = VIEW_BACKGROUND_COLOR;
    if (section == 2) {
        footerView.backgroundColor = [UIColor whiteColor];
        footerView.frame = CGRectMake(0, 0, SCREENWIDTH, 64);
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectZero];
        line.backgroundColor = VIEW_BACKGROUND_COLOR;
        [footerView  addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(footerView);
            make.top.equalTo(footerView);
            make.height.equalTo(@9);
            make.width.equalTo(@(SCREENWIDTH));
        }];

        
        _selBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_selBtn setImage:[UIImage imageNamed:CHECK_BOX_BTN] forState:UIControlStateNormal];
        [_selBtn setImage:[UIImage imageNamed:DETERMINE_SELECTION_BUTTON] forState:UIControlStateSelected];
        [_selBtn setTitle:NSLocalizedString(@"Set me information", @"Set me information") forState:UIControlStateNormal];
        [_selBtn setTitleColor:ColorWithHex(0x4EA2FF, 1.0) forState:UIControlStateNormal];
        _selBtn.titleLabel.font = PingFangSC_Regular(15);
        if ([self.data.selfFlag isEqualToString:STRING_1]) {
            _selBtn.selected = YES;
        }
        [footerView  addSubview:_selBtn];
        [_selBtn addTarget:self action:@selector(selAction) forControlEvents:UIControlEventTouchUpInside];
        [_selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(footerView).offset(-15);
            make.top.equalTo(line.mas_bottom);
            make.bottom.equalTo(footerView);
            make.height.equalTo(@15);
        }];
    }
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        
        return 64;
    }
    return 9.f;
}

#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 58;
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    travellerCell *cell = [travellerCell returnCellWith:tableView];
    [self configureSystemSetCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configureSystemSetCell:(travellerCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger identiferRow = 0;
    if (indexPath.section == 0) {
        
        cell.title.text = titleArray[indexPath.row];
        cell.contentTF.placeholder = contentArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.contentTF.text = self.data.name;
        } else if (indexPath.row == 1) {
            cell.contentTF.text = self.data.surname;
        } else if (indexPath.row == 2) {
            cell.contentTF.text = self.data.enName;
        }
        identiferRow = indexPath.row;
    }else if (indexPath.section == 1){
        identiferRow = indexPath.row+3;
        if (indexPath.row == 0) {
            cell.title.text = NSLocalizedString(@"ID", @"ID");
            if ([self.passenger_type isEqualToString:PASSENGER_TYPE_NI]) {
                cell.title.text = NSLocalizedString(@"ID", @"ID");
            } else if ([self.passenger_type isEqualToString:PASSENGER_TYPE_P]) {
                cell.title.text = NSLocalizedString(@"passport", @"passport");
            } else if ([self.passenger_type isEqualToString:PASSENGER_TYPE_ID]) {
                cell.title.text = NSLocalizedString(@"Other", @"Other");
            }
            cell.contentTF.text = nil;
            for (certInfos_one *one in self.data.Arry_certInfos) {
                if ([one.certType isEqualToString:self.passenger_type]) {
                    cell.contentTF.text = one.certNo;
                    break;
                }
            }
            kWeakSelf(self);
            cell.Select_type = ^{
                [weakself SelecetType];
            };
        } else if (indexPath.row == 1) {
            cell.contentTF.text = self.data.birthday;
        } else if (indexPath.row == 2) {
            kWeakSelf(self);
            cell.Select_Sex = ^(NSString *sex) {
                weakself.data.sex = sex;
            };
            cell.sexMF = self.data.sex;
            if ([self.passenger_type isEqualToString:PASSENGER_TYPE_NI]) {
                cell.idNO = self.data.certNo;
            }else{
                cell.idNO = nil;
            }
        } else if (indexPath.row == 3) {
            if (self.data.nationalityName && self.data.nationalityName.length) {
                cell.contentTF.text = self.data.nationalityName;
            }else{
                for (certInfos_one *one in self.data.Arry_certInfos) {
                    if ([one.certType isEqualToString:self.passenger_type]) {
                        [self setCountyNameWith:one.nationality];
                        cell.contentTF.text = self.data.nationalityName;
                        break;
                    }
                }
            }
        } else if (indexPath.row == 4) {
            if (self.data.expireDate && self.data.expireDate.length) {
                cell.contentTF.text = self.data.expireDate;
            }else{
                for (certInfos_one *one in self.data.Arry_certInfos) {
                    if ([one.certType isEqualToString:self.passenger_type]) {
                        cell.contentTF.text = one.expireDate;
                        break;
                    }
                }
            }
        }
        
        if (indexPath.row != 0) {
            cell.title.text = titleArray[indexPath.row+3];
        }
        cell.contentTF.placeholder = contentArray[indexPath.row+3];
    }else{
        identiferRow = indexPath.row+3+5;
        if (indexPath.row == 0) {
            cell.contentTF.text = self.data.mobile;
        }
        cell.title.text = titleArray.lastObject;
        cell.contentTF.placeholder = contentArray.lastObject;
    }
    cell.identifer = identiferArry[identiferRow];
    kWeakSelf(self);
    cell.Fill_in_the_text = ^(NSString *identifer, NSString *text) {
        if ([identifer isEqualToString:KEY_NAME]) {
            weakself.data.name = text;
        }else if ([identifer isEqualToString:KEY_SUNAME]) {
            weakself.data.surname = text;
        }else if ([identifer isEqualToString:KEY_ENNAME]) {
            weakself.data.enName = text;
        }else if ([identifer isEqualToString:KEY_CERNO]) {
            weakself.data.certNo = text;
            if ([weakself.passenger_type isEqualToString:PASSENGER_TYPE_NI] && [text IsIdCardNumber] && text.length == 18) {
                weakself.data.sex = [text getIdentityCardSex];
                weakself.data.birthday = [text birthdayStrFromIdentityCard];
                [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1],[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }else if ([identifer isEqualToString:KEY_MOBILE]) {
            weakself.data.mobile = text;
        }
    };
    cell.Begin_Fill_in_the_text = ^(UITextField *contentTF) {
        weakself.input = contentTF;
    };
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            [self OpendatePikerIsbirthday:YES];
        } else if (indexPath.row == 3) {
            [self OpenChooseNationality];
        } else if (indexPath.row == 4) {
             [self OpendatePikerIsbirthday:NO];
        }
    }
}
#pragma -mark<选择国籍>
- (void)OpenChooseNationality{
    if ([self canResignFirstResponder]) {
        [self resignFirstResponder];
    }
    ChooseNationality *vc = [ChooseNationality new];
    kWeakSelf(self);
    vc.ChoseOK = ^(NSDictionary *dic) {
        weakself.data.nationalityCode = dic[KEY_COUNTRYCODE];
        weakself.data.nationalityName = dic[KEY_COUNTRYNAME];
        [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma -mark<打开日期选择>
- (void)OpendatePikerIsbirthday:(BOOL)Isbirthday{
    if ([self.input isFirstResponder]) {
        [self.input resignFirstResponder];
    }
    datePiker *piker = [datePiker new];
    if (Isbirthday) {
        piker.minDateStr = @"1900-01-01";
        piker.maxDate = [NSDate date];
    } else {
        piker.minDate = [NSDate date];
        piker.maxDateStr = @"2100-01-01";
    }
    kWeakSelf(self);
    piker.SelecetDateStr = ^(NSString *Date) {
        if (Isbirthday) {
            weakself.data.birthday = Date;
            [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        } else {
            weakself.data.expireDate = Date;
            [weakself.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        }
    };
    [piker windosViewshow];
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return 5;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (void)selAction{
    _selBtn.selected = !_selBtn.selected;
    if (_selBtn.selected) {
        self.data.selfFlag = STRING_1;
    } else {
        self.data.selfFlag = STRING_0;
    }
}
- (passengerInfos_one *)data{
    if (!_data) {
        _data = [[passengerInfos_one alloc]init];
    }
    return _data;
}
- (void)SelecetType{
    if ([self.input isFirstResponder]) {
        [self.input resignFirstResponder];
    }
    AlertView *alertView = [AlertView popoverView];
    alertView.backgroundColor=[UIColor clearColor];
    alertView.showShade = YES; // 显示阴影背景
    [alertView showWithActions:[self selectActions]];
}
- (NSMutableArray<AlertAction *> *)selectActions {
    // 全部支付 action
    kWeakSelf(self);
    AlertAction *allPayAction = [AlertAction actionWithImage:[UIImage imageNamed:@"selcetShape"] title:NSLocalizedString(@"ID", @"ID") handler:^(AlertAction *action) {
        weakself.passenger_type = PASSENGER_TYPE_NI;
        weakself.data.certType = PASSENGER_TYPE_NI;
        [weakself setTppeAndCerNO];
        [weakself reloadType];
    }];
    // 快捷支付 action
    AlertAction *fastAction = [AlertAction actionWithImage:[UIImage imageNamed:@"selcetShape"] title:NSLocalizedString(@"passport", @"passport") handler:^(AlertAction *action) {
        weakself.passenger_type = PASSENGER_TYPE_P;
        weakself.data.certType = PASSENGER_TYPE_P;
        [weakself setTppeAndCerNO];
        [weakself reloadType];
    }];
    // 快捷支付 action
    AlertAction *OtherAction = [AlertAction actionWithImage:[UIImage imageNamed:@"selcetShape"] title:NSLocalizedString(@"Other", @"Other") handler:^(AlertAction *action) {
        weakself.passenger_type = PASSENGER_TYPE_ID;
        weakself.data.certType = PASSENGER_TYPE_ID;
        [weakself setTppeAndCerNO];
        [weakself reloadType];
    }];
    // 取消
    AlertAction *cancelAction = [AlertAction actionWithTitle:NSLocalizedString(@"cancel", @"cancel") handler:^(AlertAction *action) {
        
    }];

    NSArray *section1 =@[allPayAction, fastAction,OtherAction];
    NSArray *section2 =@[cancelAction];
    AlertAction *alert=[[AlertAction alloc]init];
    alert.selectRow = 4;
    NSMutableArray *actionArr=[NSMutableArray arrayWithObjects:section1, section2,alert, nil];
    return actionArr;
}

- (void)setTppeAndCerNO{
    for (certInfos_one *one in self.data.Arry_certInfos) {
        if ([one.certType isEqualToString:self.passenger_type]) {
            self.data.certType = one.certType;
            self.data.certNo = one.certNo;
            self.data.nationalityCode = one.nationality;
            self.data.expireDate = one.expireDate;
            [self setCountyNameWith:self.data.nationalityCode];
            break;
        }
    }
}
- (void)setCountyNameWith:(NSString *)nationalityCode{
    for (NSDictionary *dicAll in self.countyArray) {
        NSArray *key = [dicAll allKeys];
        if (key.count) {
            NSArray *tmp = dicAll[[key firstObject]];
            for (NSDictionary *dic in tmp) {
                NSLog(@"dic[KEY_COUNTRYCODE]=%@",dic[KEY_COUNTRYCODE]);
                if ([nationalityCode isEqualToString:dic[KEY_COUNTRYCODE]]) {
                    self.data.nationalityName = dic[KEY_COUNTRYNAME];
                    break;
                }
            }
        }
    }
}
- (void)reloadType{
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
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
