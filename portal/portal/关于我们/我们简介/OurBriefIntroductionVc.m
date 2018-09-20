//
//  OurBriefIntroductionVc.m
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "OurBriefIntroductionVc.h"
#import "NSString+Add.h"

@interface OurBriefIntroductionVc ()

@end

@implementation OurBriefIntroductionVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *top = [UIView new];
    top.backgroundColor = VIEW_BACKGROUND_COLOR;
    [self.view addSubview:top];
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(HEIGHT_NAVBAR);
        make.height.equalTo(@10);
    }];
    
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(top.mas_bottom).offset(15);
    }];
    label.numberOfLines = 0;
    NSString *des = NSLocalizedString(@"Tempus portal APP is owned by the Tempus Tempus group development limited company of science and technology intelligence products, the Tempus group's resources together to provide a unified entrance to the user, one-stop purchase Tempus group of tourism products, ticket products, hotel products, financial products and cross-border goods.", @"Tempus portal APP is owned by the Tempus Tempus group development limited company of science and technology intelligence products, the Tempus group's resources together to provide a unified entrance to the user, one-stop purchase Tempus group of tourism products, ticket products, hotel products, financial products and cross-border goods.");
    label.attributedText = [des CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x494949, 0.8) LineSpacing:9 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
}
@end
