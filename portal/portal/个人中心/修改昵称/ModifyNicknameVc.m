//
//  ModifyNicknameVc.m
//  portal
//
//  Created by Store on 2017/9/5.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ModifyNicknameVc.h"
#import "PortalHelper.h"
#import "NSString+Add.h"
@interface ModifyNicknameVc ()<UITextFieldDelegate>
@property (nonatomic,weak)UITextField *nameInput;
@property (nonatomic,weak)UILabel *des;
@end

@implementation ModifyNicknameVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Modify nickname", @"Modify nickname");
    self.view.backgroundColor = VIEW_BACKGROUND_COLOR;
    
    UIView *back = [UIView new];
    [self.view addSubview:back];
    
    UITextField *nameInput = [UITextField new];
    self.nameInput  =nameInput;
    [self.view addSubview:nameInput];
    
    UILabel *des = [UILabel new];
    self.des  =des;
    [self.view addSubview:des];
    
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@54);
        make.top.equalTo(self.view).offset(HEIGHT_NAVBAR+10);
    }];
    
    [nameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@54);
        make.top.equalTo(self.view).offset(HEIGHT_NAVBAR+10);
    }];
    [des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(nameInput.mas_bottom).offset(20);
    }];
    
    back.backgroundColor = [UIColor whiteColor];
    nameInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameInput.delegate = self;
    [nameInput setValue:PLACEHOLDERLABELTEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
    nameInput.placeholder = NSLocalizedString(@"Please enter your nickname", @"Please enter your nickname");
    des.textColor = ColorWithHex(0x2D2D2D, 0.3);
    des.font = PingFangSC_Regular(12);
    nameInput.textColor = ColorWithHex(0x494949, 1.0);
    nameInput.font = PingFangSC_Regular(15);
    des.text = NSLocalizedString(@"A combination of numbers, letters, or characters (6-12 characters)", @"A combination of numbers, letters, or characters (6-12 characters)");
    des.numberOfLines = 0;
    
    nameInput.text = (self.data.nickname&&self.data.nickname.length)?self.data.nickname:self.data.mobile;
    
    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [okBtn setTitle:NSLocalizedString(@"Preservation", @"Preservation") forState:UIControlStateNormal];
    [okBtn setTitleColor:ColorWithHex(0x4EA2FF , 1.0) forState:UIControlStateNormal];
    okBtn.titleLabel.font = PingFangSC_Regular(17);
    [okBtn addTarget:self action:@selector(okBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:okBtn];
}

- (void)okBtnClick:(UIButton *)btn{
    if ([self.nameInput canResignFirstResponder]) {
        [self.nameInput resignFirstResponder];
    }
    NSLog(@"%s",__func__);
    if (self.nameInput.text.length >= 6 && self.nameInput.text.length <= 12) {
        kWeakSelf(self);
        [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Submission...", @"Submission...") toView:self.view];
        [[ToolRequest sharedInstance]URLBASIC_usermodifyNicknameWithnickname:self.nameInput.text sssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:NSLocalizedString(@"Submit successfully", @"Submit successfully") toView:weakself.view];
            [weakself performSelector:@selector(popSelf) withObject:nil afterDelay:MANY_SECONDS];
            
            UserInfo *date = [PortalHelper sharedInstance].userInfo;
            date.nickname = weakself.nameInput.text;
            
            [PortalHelper sharedInstance].userInfo = date;
            
            NSNotification *notification =[NSNotification notificationWithName:CHANGE_NAME_NOTIFICATION object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:msg toView:weakself.view];
        }];
    }else{
        [MBProgressHUD showPrompt:NSLocalizedString(@"Length is 6-12 characters", @"Length is 6-12 characters") toView:self.view];
    }
}
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    textField.text = [self filterCharactor:textField.text withRegex:@"[^\u4e00-\u9fa5]"];
//}
//-(NSString *)filterCharactor:(NSString* )string withRegex:(NSString* )regexStr{
//    NSString *searchText = string;
//    NSError *error = NULL;
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
//    NSString *result = [regex stringByReplacingMatchesInString:searchText options:NSMatchingReportCompletion range:NSMakeRange(0, searchText.length) withTemplate:@""];
//    return result;
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"shuru=%@ ragng=%lu ragng=%lu",string,(unsigned long)range.location,(unsigned long)range.length);
    if ([string isEqualToString:@""] && textField.text.length + string.length <= 12) {
        return YES;
    }
    if ([self isInputRuleAndNumber:string] && textField.text.length + string.length <= 12) {
        return YES;
    }
    return NO;
}

/**
 * 字母、数字、中文
 */
- (BOOL)isInputRuleAndNumber:(NSString *)str
{
    NSString *other = @"➋➌➍➎➏➐➑➒";
    unsigned long len=str.length;
    for(int i=0;i<len;i++)
    {
        unichar a=[str characterAtIndex:i];
        if(!((isalpha(a))
             ||(isalnum(a))
             ||((a=='@') || (a == '@'))
             ||((a >= 0x4e00 && a <= 0x9fa5))
             ||([other rangeOfString:str].location != NSNotFound)
             ))
            return NO;
    }
    return YES;
}

@end
