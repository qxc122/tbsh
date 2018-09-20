//
//  sidebarVcHead.m
//  portal
//
//  Created by Store on 2017/9/1.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "sidebarVcHead.h"
#import "UIView+Add.h"
#import "Masonry.h"
#import "UIImageView+Add.h"
@interface sidebarVcHead ()
@property (nonatomic,weak) UIImageView *backImage;
@property (nonatomic,weak) UIView *backIcon;
@property (nonatomic,weak) UIImageView *Icon;
@property (nonatomic,weak) UIImageView *Grade;
@property (nonatomic,weak) UILabel *phone;

@property (nonatomic,weak) UIButton *btn;
@end


@implementation sidebarVcHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *backImage = [UIImageView new];
        [self addSubview:backImage];
        self.backImage = backImage;
        
        UIView *backIcon = [UIView new];
        [self addSubview:backIcon];
        self.backIcon = backIcon;
        
        UIImageView *Icon = [UIImageView new];
        [self addSubview:Icon];
        self.Icon = Icon;
        
        UIImageView *Grade = [UIImageView new];
        [self addSubview:Grade];
        self.Grade = Grade;
        
        UILabel *phone = [UILabel new];
        [self addSubview:phone];
        self.phone = phone;
        
        [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self).offset(-70*PROPORTION_HEIGHT);
        }];
        [backIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-20-70*0.5*PROPORTION_HEIGHT);
            make.width.equalTo(@(68*PROPORTION_WIDTH));
            make.height.equalTo(backIcon.mas_width);
        }];
        [Icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(backIcon).offset(4);
            make.right.equalTo(backIcon).offset(-4);
            make.top.equalTo(backIcon).offset(4);
            make.bottom.equalTo(backIcon).offset(-4);
        }];
        [Grade mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(backIcon).offset(7);
            make.bottom.equalTo(backIcon);
            make.width.equalTo(@(26*PROPORTION_WIDTH));
            make.height.equalTo(Grade.mas_width);
        }];
        [phone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(backIcon.mas_bottom).offset(12);
        }];

        
        [backImage SetContentModeScaleAspectFill];
        [Icon SetContentModeScaleAspectFill];
        [Grade SetContentModeScaleAspectFill];
        phone.font = PingFangSC_Regular(14);
        phone.textColor = ColorWithHex(0xFFFFFF, 1.0);
        backIcon.backgroundColor  =ColorWithHex(0xFFFFFF, 0.28);
        
        [backIcon SetFilletWith:68*PROPORTION_WIDTH];
        [Icon SetFilletWith:(68*PROPORTION_WIDTH-8)];
        [Grade SetFilletWith:26*PROPORTION_WIDTH];
        Grade.image = [UIImage imageNamed:INTEGRALI_ICON];

        backImage.image = [UIImage imageNamed:USER_AVATAR_BACKGROUND];
        //test
//        Icon.image = [UIImage imageNamed:@"1"];
//        phone.text = @"asdfasdfads";
        
    }
    return self;
}
- (void)setData:(UserInfo *)data{
    _data = data;
    self.phone.text = data.nickname&&data.nickname.length?data.nickname:data.mobile;
    [self.Icon sd_setImageWithURL:data.headUrl placeholderImage:[UIImage imageNamed:SD_HEAD_ALTERNATIVE_PICTURES]];
}


@end
