//
//  AddAndEditContactsVC.m
//  portal
//
//  Created by TFT on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AddAndEditContactsVC.h"
#import "travellerCell.h"
#import "NSString+Add.h"
@interface AddAndEditContactsVC ()
{
    NSArray *titleArray;
    NSArray *contentArray;
    NSArray *identiferArry;
}
@property (nonatomic,strong) UIButton *selBtn;
@property (nonatomic,weak) UITextField *input;
@end

@implementation AddAndEditContactsVC
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
    if (self.IsAdd) {
        self.title = NSLocalizedString(@"Add contact", @"Add contact");
    } else {
        self.title = NSLocalizedString(@"Edit Contact", @"Edit Contact");
    }
    titleArray = @[NSLocalizedString(@"Full name", @"Full name"),NSLocalizedString(@"Phone number", @"Phone number"),NSLocalizedString(@"Mail box", @"Mail box")];
    contentArray = @[NSLocalizedString(@"Please enter full Chinese name", @"Please enter full Chinese name"),NSLocalizedString(@"Please enter your cell phone number", @"Please enter your cell phone number"),NSLocalizedString(@"Such as zhangsan@163.com", @"Such as zhangsan@163.com")];
    identiferArry = @[KEY_NAME,KEY_MOBILE,KEY_EMAIL];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(HEIGHT_NAVBAR);
        make.height.equalTo(@(58*3));
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.bounces = NO;
    [self.tableView registerClass:[travellerCell class] forCellReuseIdentifier:NSStringFromClass([travellerCell class])];
    // Do any additional setup after loading the view.
    self.empty_type = succes_empty_num;
    self.header.hidden = YES;

    
    _selBtn = [[UIButton alloc]initWithFrame:CGRectZero];
    [_selBtn setImage:[UIImage imageNamed:CHECK_BOX_BTN] forState:UIControlStateNormal];
    [_selBtn setImage:[UIImage imageNamed:DETERMINE_SELECTION_BUTTON] forState:UIControlStateSelected];
    [_selBtn setTitle:NSLocalizedString(@"Set me information", @"Set me information") forState:UIControlStateNormal];
     [_selBtn setTitleColor:ColorWithHex(0x4EA2FF, 1.0) forState:UIControlStateNormal];
    _selBtn.titleLabel.font = PingFangSC_Regular(15);
    
    if ([self.data.selfFlag isEqualToString:STRING_1]) {
        _selBtn.selected = YES;
    }
    [self.view addSubview:_selBtn];
    [_selBtn addTarget:self action:@selector(selAction) forControlEvents:UIControlEventTouchUpInside];
    [_selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.tableView.mas_bottom).offset(20);
        make.height.equalTo(@15);
    }];
    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [okBtn setTitle:NSLocalizedString(@"Preservation", @"Preservation") forState:UIControlStateNormal];
    [okBtn setTitleColor:ColorWithHex(0x4EA2FF , 1.0) forState:UIControlStateNormal];
    okBtn.titleLabel.font = PingFangSC_Regular(17);
    [okBtn addTarget:self action:@selector(okBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:okBtn];
}

- (void)okBtnClick:(UIButton *)btn{
    NSLog(@"%s",__func__);
    if ([self.input canResignFirstResponder]) {
        [self.input resignFirstResponder];
    }
    if (!self.data.name || !self.data.name.length) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please enter your name", @"Please enter your name") toView:self.view];
        return;
    }
    if (![self.data.mobile IsTelNumber]) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please enter the correct cell phone number", @"Please enter the correct cell phone number") toView:self.view];
        return;
    }
    if (![self.data.email isValidateEmail]) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please enter the correct email address", @"Please enter the correct email address") toView:self.view];
        return;
    }
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"In storage...", @"In storage...") toView:self.view];
    kWeakSelf(self);
    if (self.IsAdd) {
        [[ToolRequest sharedInstance]portalcommonInfoaddContactInfoWithname:self.data.name mobile:self.data.mobile email:self.data.email selfFlag:self.data.selfFlag ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
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
        [[ToolRequest sharedInstance]portalcommonInfoeditContactInfoWithcontactId:self.data.contactId name:self.data.name mobile:self.data.mobile email:self.data.email selfFlag:self.data.selfFlag ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
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

- (void)selAction{
    _selBtn.selected = !_selBtn.selected;
    if (_selBtn.selected) {
        self.data.selfFlag = STRING_1;
    } else {
        self.data.selfFlag = STRING_0;
    }
}
- (contactInfos_one *)data{
    if (!_data) {
        _data = [[contactInfos_one alloc]init];
    }
    return _data;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 70)];
//    footerView.backgroundColor = [UIColor grayColor];
//    return footerView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 9.f;
//}

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
    cell.title.text = titleArray[indexPath.row];
    cell.contentTF.placeholder = contentArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.contentTF.text = self.data.name;
    } else if (indexPath.row == 1) {
        cell.contentTF.text = self.data.mobile;
    } else if (indexPath.row == 2) {
        cell.contentTF.text = self.data.email;
    }
    cell.identifer = identiferArry[indexPath.row];
    kWeakSelf(self);
    cell.Fill_in_the_text = ^(NSString *identifer, NSString *text) {
        if ([identifer isEqualToString:KEY_NAME]) {
            weakself.data.name = text;
        }else if ([identifer isEqualToString:KEY_MOBILE]) {
            weakself.data.mobile = text;
        }else if ([identifer isEqualToString:KEY_EMAIL]) {
            weakself.data.email = text;
        }
    };
    cell.Begin_Fill_in_the_text = ^(UITextField *contentTF) {
        weakself.input = contentTF;
    };
    
}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

@end
