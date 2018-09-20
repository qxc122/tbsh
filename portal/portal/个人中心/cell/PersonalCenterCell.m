//
//  PersonalCenterCell.m
//  portal
//
//  Created by Store on 2017/9/5.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "PersonalCenterCell.h"
#import "UIImageView+CornerRadius.h"
#import "UIImageView+Add.h"




@interface PersonalCenterCell ()
@property (nonatomic,weak) UIView *top;
@property (nonatomic,weak) UIView *bottom;

@property (nonatomic,weak) UILabel *iconStr;
@property (nonatomic,weak) UIImageView *Icon;
@property (nonatomic,weak) UIImageView *IconMore;
@property (nonatomic,weak) UIButton *IconMoreBtn;
@property (nonatomic,weak) UIView *lineTop;
@property (nonatomic,weak) UILabel *nikeNameStr;
@property (nonatomic,weak) UILabel *nikeName;
@property (nonatomic,weak) UIImageView *nikeNameMore;
@property (nonatomic,weak) UIButton *nikeNameMoreBtn;


@property (nonatomic,weak) UILabel *phoneStr;
@property (nonatomic,weak) UILabel *phone;
@property (nonatomic,weak) UIView *lineBottom;
@property (nonatomic,weak) UILabel *MemberStr;
@property (nonatomic,weak) UILabel *Member;
@property (nonatomic,weak) UIImageView *MemberMore;
@property (nonatomic,weak) UIButton *MemberMoreBtn;
@property (nonatomic,weak) UIButton *exit;

@end

@implementation PersonalCenterCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    PersonalCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[PersonalCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        
        UIView *top = [UIView new];
        [self.contentView addSubview:top];
        self.top = top;
        
        UILabel *iconStr = [UILabel new];
        [self.contentView addSubview:iconStr];
        self.iconStr = iconStr;
        
        UIImageView *Icon = [UIImageView new];
        [self.contentView addSubview:Icon];
        self.Icon = Icon;
        
        UIImageView *IconMore = [UIImageView new];
        [self.contentView addSubview:IconMore];
        self.IconMore = IconMore;
        
        UIButton *IconMoreBtn = [UIButton new];
        [self.contentView addSubview:IconMoreBtn];
        self.IconMoreBtn = IconMoreBtn;
        
        UIView *lineTop = [UIView new];
        [self.contentView addSubview:lineTop];
        self.lineTop = lineTop;
        
        UILabel *nikeNameStr = [UILabel new];
        [self.contentView addSubview:nikeNameStr];
        self.nikeNameStr = nikeNameStr;
        
        UILabel *nikeName = [UILabel new];
        [self.contentView addSubview:nikeName];
        self.nikeName = nikeName;
        
        UIImageView *nikeNameMore = [UIImageView new];
        [self.contentView addSubview:nikeNameMore];
        self.nikeNameMore = nikeNameMore;
        
        UIButton *nikeNameMoreBtn = [UIButton new];
        [self.contentView addSubview:nikeNameMoreBtn];
        self.nikeNameMoreBtn = nikeNameMoreBtn;

        UIView *bottom = [UIView new];
        [self.contentView addSubview:bottom];
        self.bottom = bottom;
        
        UILabel *phoneStr = [UILabel new];
        [self.contentView addSubview:phoneStr];
        self.phoneStr = phoneStr;
        
        UILabel *phone = [UILabel new];
        [self.contentView addSubview:phone];
        self.phone = phone;
        
        UIView *lineBottom = [UIView new];
        [self.contentView addSubview:lineBottom];
        self.lineBottom = lineBottom;
        
        UILabel *MemberStr = [UILabel new];
        [self.contentView addSubview:MemberStr];
        self.MemberStr = MemberStr;
        
        UILabel *Member = [UILabel new];
        [self.contentView addSubview:Member];
        self.Member = Member;
        
        UIImageView *MemberMore = [UIImageView new];
        [self.contentView addSubview:MemberMore];
        self.MemberMore = MemberMore;
        
        UIButton *MemberMoreBtn = [UIButton new];
        [self.contentView addSubview:MemberMoreBtn];
        self.MemberMoreBtn = MemberMoreBtn;
        
        UIButton *exit = [UIButton new];
        [self.contentView addSubview:exit];
        self.exit = exit;
        
        [top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(10);
            make.height.equalTo(@112);
        }];

        [lineTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(top).offset(15);
            make.right.equalTo(top).offset(-15);
            make.centerY.equalTo(top);
            make.height.equalTo(@(0.5));
        }];
        [iconStr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineTop);
            make.right.equalTo(Icon.mas_left).offset(-15);
            make.top.equalTo(top);
            make.bottom.equalTo(lineTop.mas_top);
        }];
        [Icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(iconStr);
            make.right.equalTo(IconMore.mas_left).offset(-20);
            make.width.equalTo(@40);
            make.height.equalTo(Icon.mas_width);
        }];
        [IconMore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(iconStr);
            make.right.equalTo(lineTop);
            make.width.equalTo(@6.7);
            make.height.equalTo(@11.9);
        }];
        [IconMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineTop);
            make.right.equalTo(lineTop);
            make.top.equalTo(iconStr);
            make.bottom.equalTo(iconStr);
        }];

        [nikeNameStr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineTop);
            make.top.equalTo(lineTop.mas_bottom);
            make.bottom.equalTo(top);
        }];
        [nikeName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nikeNameStr);
            make.right.equalTo(IconMore.mas_left).offset(-12);
            make.width.equalTo(@200);
        }];
        [nikeNameMore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nikeNameStr);
            make.right.equalTo(lineTop);
            make.width.equalTo(@6.7);
            make.height.equalTo(@11.9);
        }];
        [nikeNameMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineTop);
            make.right.equalTo(lineTop);
            make.top.equalTo(nikeNameStr);
            make.bottom.equalTo(nikeNameStr);
        }];

        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(top.mas_bottom).offset(10);
            make.height.equalTo(@112);
        }];
        [lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineTop);
            make.right.equalTo(lineTop);
            make.centerY.equalTo(bottom);
            make.height.equalTo(@(0.5));
        }];
        [phoneStr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineTop);
            make.top.equalTo(bottom);
            make.bottom.equalTo(lineBottom.mas_top);
        }];
        [phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(Member);
            make.width.equalTo(@200);
            make.top.equalTo(bottom);
            make.bottom.equalTo(lineBottom.mas_top);
        }];
        
        [MemberStr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineTop);
            make.top.equalTo(lineBottom.mas_bottom);
            make.bottom.equalTo(bottom);
        }];
        [Member mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(MemberStr);
            make.right.equalTo(MemberMore.mas_left).offset(-12);
            make.width.equalTo(@200);
        }];
        [MemberMore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(MemberStr);
            make.right.equalTo(lineTop);
            make.width.equalTo(@6.7);
            make.height.equalTo(@11.9);
        }];
        [MemberMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineTop);
            make.right.equalTo(lineTop);
            make.top.equalTo(MemberStr);
            make.bottom.equalTo(MemberStr);
        }];
        
        [exit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineTop);
            make.right.equalTo(lineTop);
            make.top.equalTo(bottom.mas_bottom).offset(20);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@50);
        }];
        
        //set
        [exit setBackgroundImage:[UIImage imageNamed:LANDING_BUTTON_BACKGROUND] forState:UIControlStateNormal];
        exit.titleLabel.font = PingFangSC_Regular(16);
        [exit setTitleColor:ColorWithHex(0xFFFFFF, 1.0) forState:UIControlStateNormal];
        [exit setTitle:NSLocalizedString(@"exit", @"exit") forState:UIControlStateNormal];
        
        top.backgroundColor = [UIColor whiteColor];
        bottom.backgroundColor = [UIColor whiteColor];
        lineTop.backgroundColor= GENERAL_GREY_COLOR;
        lineBottom.backgroundColor= GENERAL_GREY_COLOR;
        
        iconStr.font = PingFangSC_Regular(15);
        iconStr.textColor = ColorWithHex(0x2D2D2D, 0.8);
        
        nikeNameStr.font = PingFangSC_Regular(15);
        nikeNameStr.textColor = ColorWithHex(0x2D2D2D, 0.8);
        
        phoneStr.font = PingFangSC_Regular(15);
        phoneStr.textColor = ColorWithHex(0x2D2D2D, 0.8);
        
        MemberStr.font = PingFangSC_Regular(15);
        MemberStr.textColor = ColorWithHex(0x2D2D2D, 0.8);
        
        nikeName.font = PingFangSC_Regular(15);
        nikeName.textColor = ColorWithHex(0x494949, 1.0);
        
        phone.font = PingFangSC_Regular(15);
        phone.textColor = ColorWithHex(0x494949, 1.0);
        
        Member.font = PingFangSC_Regular(15);
        Member.textColor = ColorWithHex(0x494949, 1.0);

        [IconMoreBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [nikeNameMoreBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [MemberMoreBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [exit addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        IconMoreBtn.accessibilityIdentifier = IconMoreBtnIdentifier;
        nikeNameMoreBtn.accessibilityIdentifier = nikeNameMoreBtnIdentifier;
        MemberMoreBtn.accessibilityIdentifier = MemberMoreBtnIdentifier;
        exit.accessibilityIdentifier = ExitBtnIdentifier;
        
        [IconMore SetContentModeScaleAspectFill];
        [nikeNameMore SetContentModeScaleAspectFill];
        [MemberMore SetContentModeScaleAspectFill];
        [Icon zy_cornerRadiusRoundingRect];

        iconStr.text = NSLocalizedString(@"Head portrait", @"Head portrait");
        nikeNameStr.text = NSLocalizedString(@"nickname", @"nickname");
        phoneStr.text = NSLocalizedString(@"Phone number", @"Phone number");
        MemberStr.text = NSLocalizedString(@"Membership level", @"Membership level");
        
        IconMore.image = [UIImage imageNamed:CLICK_RIGHT];
        nikeNameMore.image = [UIImage imageNamed:CLICK_RIGHT];
        MemberMore.image = [UIImage imageNamed:CLICK_RIGHT];
        
        self.nikeName.textAlignment = NSTextAlignmentRight;
        self.phone.textAlignment = NSTextAlignmentRight;
        self.Member.textAlignment = NSTextAlignmentRight;
    }
    return self;
}
- (void)BtnClick:(UIButton *)btn{
    if (self.GoToEditThePersonalInfo) {
        self.GoToEditThePersonalInfo(btn.accessibilityIdentifier);
    }
    NSLog(@"btn.ide=%@",btn.accessibilityIdentifier);
}

- (void)setData:(UserInfo *)data{
    _data = data;
    [self.Icon sd_setImageWithURL:data.headUrl placeholderImage:[UIImage imageNamed:SD_HEAD_ALTERNATIVE_PICTURES]];
    if (data.nickname && data.nickname.length) {
        self.nikeName.text = data.nickname;
        self.nikeName.textColor = ColorWithHex(0x494949, 1.0);
    } else {
        self.nikeName.text = ([PortalHelper sharedInstance].userInfo.nickname&&[PortalHelper sharedInstance].userInfo.nickname.length)?[PortalHelper sharedInstance].userInfo.nickname:[PortalHelper sharedInstance].userInfo.mobile;
        self.nikeName.textColor = ColorWithHex(0x494949, 1.0);
    }
    
    if (data.mobile && data.mobile.length) {
        self.phone.text = data.mobile;
        self.phone.textColor = ColorWithHex(0x494949, 1.0);
    } else {
        self.phone.text = NSLocalizedString(@"You did not set the phone number ~!", @"You did not set the phone number ~!");
        self.phone.textColor = ColorWithHex(0x494949, 0.3);
    }
    
    if (data.vipLevel && data.vipLevel.length) {
        self.Member.text = data.vipLevel;
        self.Member.textColor = ColorWithHex(0x494949, 1.0);
    } else {
        self.Member.text =NSLocalizedString(@"No rank ~!", @"No rank ~!");
        self.Member.textColor = ColorWithHex(0x494949, 0.3);
    }
}
@end
