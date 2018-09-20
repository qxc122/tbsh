//
//  NavigationBarDetais.m
//  TourismT
//
//  Created by Store on 2017/7/28.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "NavigationBarDetais.h"
#import "HeaderAll.h"


#define back_btn_top_to_superView  22
#define back_btn_left_to_superView  0
#define back_btn_RIGHT_to_superView  13


@interface NavigationBarDetais ()
@property (nonatomic, weak) UIView *backGroundImage; //背景图片
@property (nonatomic, weak) UIButton *back; //返回
@property (nonatomic, weak) UIButton *share;    //分享
@property (nonatomic, weak) UIView *line;    //分享



@end


@implementation NavigationBarDetais

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *backGroundImage = [UIView new];
        self.backGroundImage = backGroundImage;
        [self addSubview:backGroundImage];
        
        UILabel *title = [UILabel new];
        self.title = title;
        [self addSubview:title];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = PingFangSC_Regular(17);
        title.textColor = ColorWithHex(0x2D2D2D, 1.0);
        title.highlightedTextColor = ColorWithHex(0xFFFFFF, 1.0);
        
        UIButton *back = [UIButton new];
        self.back = back;
        [self addSubview:back];
        
        UIButton *share = [UIButton new];
        self.share = share;
        [self addSubview:share];
        
        UIView *line = [UIButton new];
        self.line  =line;
        [self addSubview:line];
        [backGroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(back_btn_left_to_superView);
            make.top.equalTo(self).offset(back_btn_top_to_superView);
            make.width.equalTo(@(40));
            make.height.equalTo(@(40));
        }];
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(back.mas_right).offset(10);
            make.right.equalTo(share.mas_left).offset(-10);
            make.centerY.equalTo(back);
        }];
        
        [share mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(back);
            make.width.equalTo(@(40));
            make.height.equalTo(@(40));
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@(0.5));
        }];
        
        line.backgroundColor = GENERAL_GREY_COLOR;
        self.back.tag = back_NavigationBarDetais_Click_ENMU;
        self.share.tag = keepOrshare_NavigationBarDetais_Click_ENMU;
        self.backGroundImage.alpha = 0.0;
        backGroundImage.backgroundColor = [UIColor whiteColor];

        [back addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [share addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        share.hidden = YES;
        self.title.highlighted = YES;
    }
    return self;
}
- (void)BtnClick:(UIButton *)btn{
    if (self.brnClickType) {
        self.brnClickType(btn.tag);
    }
}
- (void)setAlpaImage:(CGFloat)alpaImage{
    _alpaImage = alpaImage;
    self.backGroundImage.alpha = alpaImage;
    self.line.alpha = alpaImage;
    if (alpaImage==1) {
        self.title.highlighted = NO;
        [self.back setImage:[UIImage imageNamed:NAVIGATION_BAR_RETURN_BUTTONP] forState:UIControlStateNormal];
        [self.share setImage:[UIImage imageNamed:SHARE_BLACK_PICTURES] forState:UIControlStateNormal];
    } else {
        [self.back setImage:[UIImage imageNamed:NAVIGATION_BAR_RETURN_WHITE_BUTTONP] forState:UIControlStateNormal];
        [self.share setImage:[UIImage imageNamed:NAVIGATION_BAR_SHARE_WHITE_BUTTONP] forState:UIControlStateNormal];
        self.title.highlighted = YES;
    }
}
@end
