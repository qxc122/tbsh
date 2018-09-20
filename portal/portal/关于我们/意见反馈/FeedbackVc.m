//
//  FeedbackVc.m
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "FeedbackVc.h"
#import "SZTextView.h"
#import "NSString+Add.h"
@interface FeedbackVc ()<UITextViewDelegate>
@property (nonatomic,weak) SZTextView *input;
@property (nonatomic,weak) UILabel *num;
@property (nonatomic,assign) CGFloat heightPre;
@end

@implementation FeedbackVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.heightPre = 130*PROPORTION_HEIGHT;
    self.view.backgroundColor = VIEW_BACKGROUND_COLOR;
    UIView *back = [UIView new];
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    SZTextView *input = [SZTextView new];
    [self.view addSubview:input];
    input.backgroundColor = [UIColor whiteColor];
    [input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view).offset(10+HEIGHT_NAVBAR);
        make.height.equalTo(@(self.heightPre));
    }];
    self.input = input;
    input.delegate = self;
    input.placeholder = NSLocalizedString(@"Please briefly describe your questions and comments (within 300 words)", @"Please briefly describe your questions and comments (within 300 words)");
    
    UILabel *num = [UILabel new];
    [self.view addSubview:num];
    [num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(input).offset(-15);
        make.bottom.equalTo(input).offset(-15);
    }];
    self.num = num;
    num.font = PingFangSC_Regular(14);
    num.textColor = ColorWithHex(0x2D2D2D, 0.5);
    //set
    input.bounces = NO;
    input.showsHorizontalScrollIndicator = NO;
    input.showsVerticalScrollIndicator = NO;
    input.font = PingFangSC_Regular(14);
    input.textColor = ColorWithHex(0x000000 , 0.8);
    
    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [okBtn setTitle:NSLocalizedString(@"Submit", @"Submit") forState:UIControlStateNormal];
    [okBtn setTitleColor:ColorWithHex(0x4EA2FF , 1.0) forState:UIControlStateNormal];
    okBtn.titleLabel.font = PingFangSC_Regular(17);
    [okBtn addTarget:self action:@selector(okBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:okBtn];
    self.num.text = @"0 / 300";
}
- (void)okBtnClick:(UIButton *)btn{
    NSLog(@"%s",__func__);
    if (self.input.text.length) {
        kWeakSelf(self);
        [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Submission...", @"Submission...") toView:self.view];
        [[ToolRequest sharedInstance]appsubmitFeedbackWithcontent:self.input.text ssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:NSLocalizedString(@"Submit case successfully", @"Submit case successfully") toView:weakself.view];
            [weakself performSelector:@selector(popSelf) withObject:nil afterDelay:MANY_SECONDS];
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD hideHUDForView:weakself.view];
            [MBProgressHUD showPrompt:msg toView:weakself.view];
        }];
    }else{
        [MBProgressHUD showPrompt:NSLocalizedString(@"Please enter the evaluation first", @"Please enter the evaluation first") toView:self.view];
    }
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 300) {
        textView.text = [textView.text substringToIndex:300];
        [MBProgressHUD showPrompt:NSLocalizedString(@"No more than 300 words", @"No more than 300 words")];
    }
    self.num.text = [NSString stringWithFormat:@"%lu / 300",(unsigned long)textView.text.length];
    CGFloat height = [textView.text HeightWithFont:PingFangSC_Regular(14) withMaxWidth:SCREENWIDTH-30];
    if ((height + 14+15+5) > self.heightPre) {
        self.heightPre +=30;
    }else if ((height + 14+15+5) < 130*PROPORTION_HEIGHT){
        self.heightPre =130*PROPORTION_HEIGHT;
    }
    [self.input mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view).offset(10+HEIGHT_NAVBAR);
        make.height.equalTo(@(self.heightPre));
    }];
}

@end
