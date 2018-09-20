//
//  MembershipLevelVc.m
//  portal
//
//  Created by Store on 2017/9/5.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "MembershipLevelVc.h"
#import "UIView+Add.h"
#import "UIImageView+Add.h"
#import "UIImageView+CornerRadius.h"
#import "PortalHelper.h"

@interface MembershipLevelVc ()
@property (nonatomic,weak) UIView *back;
@property (nonatomic,weak) UIImageView *backImage;
@property (nonatomic,weak) UIView *backIcon;
@property (nonatomic,weak) UIImageView *Icon;
@property (nonatomic,weak) UILabel *member;

@property (nonatomic,weak) UIImageView *IconBottmo;
@property (nonatomic,weak) UILabel *des;
@property (nonatomic,weak) UIView *lineTop;
@property (nonatomic,weak) UIImageView *memberImage;
@property (nonatomic,weak) UIView *lineBottom;
@end

@implementation MembershipLevelVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = VIEW_BACKGROUND_COLOR;
    self.title = NSLocalizedString(@"Membership level", @"Membership level");
    if (!self.data) {
        self.data = [PortalHelper sharedInstance].userInfo;
    }
    [self SetMembershipLevelVcUI];
}

- (void)SetMembershipLevelVcUI{
    UIView *back = [UIView new];
    self.back = back;
    [self.view addSubview:back];
    
    UIImageView *backImage = [UIImageView new];
    self.backImage = backImage;
    [self.view addSubview:backImage];
    
    UIView *backIcon = [UIView new];
    self.backIcon = backIcon;
    [self.view addSubview:backIcon];
    
    UIImageView *Icon = [UIImageView new];
    self.Icon = Icon;
    [self.view addSubview:Icon];
    
    UILabel *member = [UILabel new];
    self.member = member;
    [self.view addSubview:member];

    UIImageView *IconBottmo = [UIImageView new];
    self.IconBottmo = IconBottmo;
    [self.view addSubview:IconBottmo];
    
    UILabel *des = [UILabel new];
    self.des = des;
    [self.view addSubview:des];
    
    UIView *lineTop = [UIView new];
    self.lineTop = lineTop;
    [self.view addSubview:lineTop];
    
    UIImageView *memberImage = [UIImageView new];
    self.memberImage = memberImage;
    [self.view addSubview:memberImage];
    
    UIView *lineBottom = [UIView new];
    self.lineBottom = lineBottom;
    [self.view addSubview:lineBottom];
    
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(HEIGHT_NAVBAR);
        make.height.equalTo(@(171*PROPORTION_HEIGHT));
    }];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(back).offset(38*PROPORTION_HEIGHT);
        make.right.equalTo(back).offset(-38*PROPORTION_HEIGHT);
        make.top.equalTo(back).offset(38*PROPORTION_HEIGHT);
        make.bottom.equalTo(back);
    }];
    [backIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(back);
        make.centerY.equalTo(back).offset(-2.5);
        make.width.equalTo(@46);
        make.height.equalTo(@46);
    }];
    Icon.frame = CGRectMake((SCREENWIDTH-44)*0.5, (171*PROPORTION_HEIGHT-44)*0.5-2.5+HEIGHT_NAVBAR, 44, 44);
//    [Icon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(backIcon);
//        make.centerY.equalTo(backIcon);
//        make.width.equalTo(@44);
//        make.height.equalTo(@44);
//    }];
    [member mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backIcon);
        make.top.equalTo(Icon.mas_bottom).offset(16);
    }];
    [lineTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(back);
        make.right.equalTo(back);
        make.top.equalTo(back.mas_bottom).offset(47);
        make.height.equalTo(@0.5);
    }];
    
    [IconBottmo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(back).offset(15);
        make.centerY.equalTo(des);
        make.width.equalTo(@16);
        make.height.equalTo(@16);
    }];
    [des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(IconBottmo.mas_right).offset(5);
        make.top.equalTo(back.mas_bottom);
        make.bottom.equalTo(lineTop.mas_top);
        make.right.equalTo(back).offset(-15);
    }];
    
    [memberImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(back);
        make.right.equalTo(back);
        make.top.equalTo(lineTop.mas_bottom);
        make.height.equalTo(@(186*PROPORTION_HEIGHT));
    }];
    
    [lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(back);
        make.right.equalTo(back);
        make.top.equalTo(memberImage.mas_bottom);
        make.height.equalTo(@0.5);
    }];
    [backIcon SetFilletWith:46.0];
    [Icon zy_cornerRadiusRoundingRect];
    [backImage SetContentModeScaleAspectFill];
    back.backgroundColor = ColorWithHex(0x8FC5FC, 1.0);
    backIcon.backgroundColor = ColorWithHex(0xFFFFFF, 0.3);
    
    member.textAlignment = NSTextAlignmentCenter;
    member.textColor = ColorWithHex(0xFFFFFF, 1.0);
    member.font = PingFangSC_Regular(18);

    lineTop.backgroundColor = GENERAL_GREY_COLOR;
    lineBottom.backgroundColor = GENERAL_GREY_COLOR;
    [IconBottmo SetContentModeScaleAspectFill];
    [memberImage SetContentModeScaleAspectFill];
    des.textColor = ColorWithHex(0x2D2D2D, 1.0);
    des.font = PingFangSC_Regular(15);
    
    //set
    member.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"Gateway member", @"Gateway member"),self.data.vipLevel];
    [Icon sd_setImageWithURL:self.data.headUrl placeholderImage:[UIImage imageNamed:SD_HEAD_ALTERNATIVE_PICTURES]];
    backImage.image = [UIImage imageNamed:CARD];
    
    des.text = NSLocalizedString(@"Grade requirements", @"Grade requirements");
    IconBottmo.image = [UIImage imageNamed:DIAMOND_PICTURES];
    memberImage.image = [UIImage imageNamed:LEVEL_LADDER_PICTURES];
}

@end
