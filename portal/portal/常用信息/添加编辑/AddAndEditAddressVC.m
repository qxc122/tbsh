//
//  AddAndEditAddressVC.m
//  portal
//
//  Created by TFT on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "AddAndEditAddressVC.h"
#import "travellerCell.h"
#import <ActionSheetCustomPicker.h>
#import "NSString+Add.h"
@interface AddAndEditAddressVC () <ActionSheetCustomPickerDelegate>
{
    
    NSArray *titleArray;
    NSArray *contentArray;
    NSArray *identiferArry;
    
}
@property (nonatomic,strong) NSArray *addressArr; // 解析出来的最外层数组
@property (nonatomic,strong) NSArray *provinceArr; // 省
@property (nonatomic,strong) NSArray *countryArr; // 市
@property (nonatomic,strong) NSArray *districtArr; // 区
@property (nonatomic,assign) NSInteger index1; // 省下标
@property (nonatomic,assign) NSInteger index2; // 市下标
@property (nonatomic,assign) NSInteger index3; // 区下标
@property (nonatomic,strong) ActionSheetCustomPicker *picker; // 选择器

@property (nonatomic,strong) UIButton *selBtn;
@property (nonatomic,weak) UITextField *input;
@end

@implementation AddAndEditAddressVC
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
        self.title = NSLocalizedString(@"New address", @"New address");
    } else {
        self.title = NSLocalizedString(@"Edit address", @"Edit address");
    }

    titleArray = @[NSLocalizedString(@"Addressee", @"Addressee"),NSLocalizedString(@"Phone number", @"Phone number"),NSLocalizedString(@"Location", @"Location"),NSLocalizedString(@"Detailed address", @"Detailed address"),NSLocalizedString(@"Zip code", @"Zip code")];
    contentArray = @[NSLocalizedString(@"Please enter the recipient's name", @"Please enter the recipient's name"),NSLocalizedString(@"Please enter your cell phone number", @"Please enter your cell phone number"),NSLocalizedString(@"Please select", @"Please select"),NSLocalizedString(@"Please fill in the detailed address, no less than 5 words", @"Please fill in the detailed address, no less than 5 words"),NSLocalizedString(@"Optional", @"Optional")];
    identiferArry = @[KEY_RECEIVERNAME,KEY_MOBILE,KEY_AREA,KEY_DETAILADDRESS,KEY_POSTCODE];
    
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
    if ([self.data.selfFlag isEqualToString:STRING_1]) {
        _selBtn.selected = YES;
    }
    [self calculateFirstData];
}

- (void)okBtnClick:(UIButton *)btn{
    if ([self.input canResignFirstResponder]) {
        [self.input resignFirstResponder];
    }
    NSLog(@"%s",__func__);
    if (!self.data.receiverName || !self.data.receiverName.length) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please enter the recipient's name", @"Please enter the recipient's name") toView:self.view];
        return;
    }
    if (![self.data.receiverMobile IsTelNumber]) { 
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please enter the correct cell phone number", @"Please enter the correct cell phone number") toView:self.view];
        return;
    }
    if (!self.data.province || !self.data.province.length || !self.data.city || !self.data.city.length || !self.data.area || !self.data.area.length) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please select area", @"Please select area") toView:self.view];
        return;
    }

    if (!self.data.detailAddress || self.data.detailAddress.length<5) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please fill in the detailed address, no less than 5 words", @"Please fill in the detailed address, no less than 5 words") toView:self.view];
        return;
    }
    if ([self.data.detailAddress deptNumInputShouldNumber] || ![self.data.detailAddress deptPassInputShouldAlpha]) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"请输入正确的地址", @"请输入正确的地址") toView:self.view];
        return;
    }
    
    if (self.data.postCode.length && ![self.data.postCode validateZipCode]) {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please enter the correct zip code", @"Please enter the correct zip code") toView:self.view];
        return;
    }
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"In storage...", @"In storage...") toView:self.view];
    kWeakSelf(self);
    if (self.IsAdd) {
        [[ToolRequest sharedInstance]portalcommonInfoaddAddressInfoWithreceiverName:self.data.receiverName receiverMobile:self.data.receiverMobile province:self.data.province city:self.data.city area:self.data.area detailAddress:self.data.detailAddress postCode:self.data.postCode selfFlag:self.data.selfFlag ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
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
        [[ToolRequest sharedInstance]portalcommonInfoeditAddressInfoWithaddressId:self.data.addressId receiverName:self.data.receiverName receiverMobile:self.data.receiverMobile province:self.data.province city:self.data.city area:self.data.area detailAddress:self.data.detailAddress postCode:self.data.postCode selfFlag:self.data.selfFlag ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
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
    if (section == 1) {
        
        footerView.backgroundColor = [UIColor whiteColor];
        footerView.frame = CGRectMake(0, 0, SCREENWIDTH, 55);
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
            make.centerY.equalTo(footerView);
            make.height.equalTo(@15);
        }];
    }
    return footerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        
        return 55;
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
        identiferRow = indexPath.row;
        cell.title.text = titleArray[indexPath.row];
        cell.contentTF.placeholder = contentArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.contentTF.text = self.data.receiverName;
        } else if (indexPath.row == 1) {
            cell.contentTF.text = self.data.receiverMobile;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            NSString *all;
            if (self.data.province && self.data.province.length) {
                all = self.data.province;
            }
            if (self.data.city && self.data.city.length) {
                all = [all stringByAppendingString:self.data.city];
            }
            if (self.data.area && self.data.area.length) {
                all = [all stringByAppendingString:self.data.area];
            }
            cell.contentTF.text = all;
        } else if (indexPath.row == 1) {
            cell.contentTF.text = self.data.detailAddress;
        } else if (indexPath.row == 2) {
            cell.contentTF.text = self.data.postCode;
        }
        identiferRow = indexPath.row + 2;
        cell.title.text = titleArray[indexPath.row+2];
        cell.contentTF.placeholder = contentArray[indexPath.row+2];
    }else{
        
        cell.title.text = titleArray.lastObject;
        cell.contentTF.placeholder = contentArray.lastObject;
    }
    cell.identifer = identiferArry[identiferRow];
    kWeakSelf(self);
    cell.Fill_in_the_text = ^(NSString *identifer, NSString *text) {
        if ([identifer isEqualToString:KEY_RECEIVERNAME]) {
            weakself.data.receiverName = text;
        }else if ([identifer isEqualToString:KEY_MOBILE]) {
            weakself.data.receiverMobile = text;
        }else if ([identifer isEqualToString:KEY_DETAILADDRESS]) {
            weakself.data.detailAddress = text;
        }else if ([identifer isEqualToString:KEY_POSTCODE]) {
            weakself.data.postCode = text;
        }
    };
    cell.Begin_Fill_in_the_text = ^(UITextField *contentTF) {
        weakself.input = contentTF;
    };
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self OpenaddressList];
    }
}
#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (void)loadFirstData
{
    // 注意JSON后缀的东西和Plist不同，Plist可以直接通过contentOfFile抓取，Json要先打成字符串，然后用工具转换
    NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"json"];
    NSLog(@"%@",path);
    NSString *jsonStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
    self.addressArr = [jsonStr mj_JSONObject];
    
    NSMutableArray *firstName = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.addressArr)
    {
        NSString *name = dict.allKeys.firstObject;
        [firstName addObject:name];
    }
    // 第一层是省份 分解出整个省份数组
    self.provinceArr = firstName;
}
- (void)OpenaddressList
{
    if ([self.input canResignFirstResponder]) {
        [self.input resignFirstResponder];
    }
    //    NSArray *initialSelection = @[@(self.index1), @(self.index2),@(self.index3)];
    // 点击的时候传三个index进去
    self.picker = [[ActionSheetCustomPicker alloc]initWithTitle:NSLocalizedString(@"Selected areas", @"Selected areas") delegate:self showCancelButton:YES origin:self.view initialSelections:@[@(self.index1),@(self.index2),@(self.index3)]];
    self.picker.tapDismissAction  = TapActionSuccess;
    // 可以自定义左边和右边的按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:ColorWithHex(0x000000, 0.8) forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 44, 44);
    button.titleLabel.font = PingFangSC_Regular(14);
    [button setTitle:NSLocalizedString(@"cancel", @"cancel") forState:UIControlStateNormal];

    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitleColor:ColorWithHex(0x000000, 0.8) forState:UIControlStateNormal];
    button1.frame = CGRectMake(0, 0, 44, 44);
    [button1 setTitle:NSLocalizedString(@"Determine", @"Determine") forState:UIControlStateNormal];
    button1.titleLabel.font = PingFangSC_Regular(14);
    [self.picker setCancelButton:[[UIBarButtonItem alloc] initWithCustomView:button]];
    [self.picker setDoneButton:[[UIBarButtonItem alloc] initWithCustomView:button1]];

    [self.picker showActionSheetPicker];
}

// 根据传进来的下标数组计算对应的三个数组
- (void)calculateFirstData
{
    // 拿出省的数组
    [self loadFirstData];
    
    NSMutableArray *cityNameArr = [[NSMutableArray alloc] init];
    // 根据省的index1，默认是0，拿出对应省下面的市
    for (NSDictionary *cityName in [self.addressArr[self.index1] allValues].firstObject) {
        
        NSString *name1 = cityName.allKeys.firstObject;
        [cityNameArr addObject:name1];
    }
    // 组装对应省下面的市
    self.countryArr = cityNameArr;
    //                             index1对应省的字典         市的数组 index2市的字典   对应市的数组
    // 这里的allValue是取出来的大数组，取第0个就是需要的内容
    self.districtArr = [[self.addressArr[self.index1] allValues][0][self.index2] allValues][0];
}

#pragma mark - UIPickerViewDataSource Implementation
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // Returns
    switch (component)
    {
        case 0: return self.provinceArr.count;
        case 1: return self.countryArr.count;
        case 2:return self.districtArr.count;
        default:break;
    }
    return 0;
}
#pragma mark UIPickerViewDelegate Implementation

// returns width of column and height of row for each component.
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
//{
//    switch (component)
//    {
//        case 0: return SCREEN_WIDTH /4;
//        case 1: return SCREEN_WIDTH *3/8;
//        case 2: return SCREEN_WIDTH *3/8;
//        default:break;
//    }
//
//    return 0;
//}

//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
//{
//    return 200;
//}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0: return self.provinceArr[row];break;
        case 1: return self.countryArr[row];break;
        case 2:return self.districtArr[row];break;
        default:break;
    }
    return nil;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* label = (UILabel*)view;
    if (!label)
    {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14]];
    }
    
    NSString * title = @"";
    switch (component)
    {
        case 0: title =   self.provinceArr[row];break;
        case 1: title =   self.countryArr[row];break;
        case 2: title =   self.districtArr[row];break;
        default:break;
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.text=title;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {
            self.index1 = row;
            self.index2 = 0;
            self.index3 = 0;
            //            [self calculateData];
            // 滚动的时候都要进行一次数组的刷新
            [self calculateFirstData];
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
            
        case 1:
        {
            self.index2 = row;
            self.index3 = 0;
            //            [self calculateData];
            [self calculateFirstData];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            [pickerView reloadComponent:2];
        }
            break;
        case 2:
            self.index3 = row;
            break;
        default:break;
    }
}
//
//- (void)calculateData
//{
//    [self loadFirstData];
//    NSDictionary *provincesDict = self.addressArr[self.index1];
//    NSMutableArray *countryArr1 = [[NSMutableArray alloc] init];
//    for (NSDictionary *contryDict in provincesDict.allValues.firstObject) {
//        NSString *name = contryDict.allKeys.firstObject;
//        [countryArr1 addObject:name];
//    }
//    self.countryArr = countryArr1;
//
//    self.districtArr = [provincesDict.allValues.firstObject[self.index2] allValues].firstObject;
//
//}

- (void)configurePickerView:(UIPickerView *)pickerView
{
    pickerView.showsSelectionIndicator = NO;
}
// 点击done的时候回调
- (void)actionSheetPickerDidSucceed:(ActionSheetCustomPicker *)actionSheetPicker origin:(id)origin
{
//    NSMutableString *detailAddress = [[NSMutableString alloc] init];
    if (self.index1 < self.provinceArr.count) {
//        NSString *firstAddress = self.provinceArr[self.index1];
        self.data.province = self.provinceArr[self.index1];
//        [detailAddress appendString:firstAddress];
    }
    if (self.index2 < self.countryArr.count) {
        self.data.city = self.countryArr[self.index2];
//        NSString *secondAddress = self.countryArr[self.index2];
//        [detailAddress appendString:secondAddress];
    }
    if (self.index3 < self.districtArr.count) {
        self.data.area = self.districtArr[self.index3];
//        NSString *thirfAddress = self.districtArr[self.index3];
//        [detailAddress appendString:thirfAddress];
    }
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
}


- (NSArray *)provinceArr
{
    if (_provinceArr == nil) {
        _provinceArr = [[NSArray alloc] init];
    }
    return _provinceArr;
}
-(NSArray *)countryArr
{
    if(_countryArr == nil)
    {
        _countryArr = [[NSArray alloc] init];
    }
    return _countryArr;
}

- (NSArray *)districtArr
{
    if (_districtArr == nil) {
        _districtArr = [[NSArray alloc] init];
    }
    return _districtArr;
}

-(NSArray *)addressArr
{
    if (_addressArr == nil) {
        _addressArr = [[NSArray alloc] init];
    }
    return _addressArr;
}

- (void)selAction{
    _selBtn.selected = !_selBtn.selected;
    if (_selBtn.selected) {
        self.data.selfFlag = STRING_1;
    } else {
        self.data.selfFlag = STRING_0;
    }
}
- (addressInfos_one *)data{
    if (!_data) {
        _data = [[addressInfos_one alloc]init];
    }
    return _data;
}
@end
