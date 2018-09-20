//
//  shareTo.m
//  TourismT
//
//  Created by Store on 16/12/31.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "shareTo.h"
#import "WXapi.h"


@implementation shareTo

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self.blcak mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self);
//            make.right.equalTo(self);
//            make.top.equalTo(self).offset(HEIGHT_NAVBAR);
//            make.bottom.equalTo(self);
//        }];
        [self.back mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self).offset(-30);
            make.height.equalTo(@(178));
        }];
        
        UILabel *title =[[UILabel alloc]init];
        [self addSubview:title];
        
        UIView *hognxiang =[[UIView alloc]init];
        [self addSubview:hognxiang];
        
        UIButton *btnOne =[[UIButton alloc]init];
        [self addSubview:btnOne];
        
        UIButton *btnTwo =[[UIButton alloc]init];
        [self addSubview:btnTwo];
        
        UILabel *btnOneL =[[UILabel alloc]init];
        [self addSubview:btnOneL];
        
        UILabel *btnTwoL =[[UILabel alloc]init];
        [self addSubview:btnTwoL];
        
        UIButton *btnThree;
        UIButton *btnFour;
        UILabel *btnThreeL;
        UILabel *btnFourL;
//        if ([[PortalHelper sharedInstance].globalParameter.isPassForIOSQQ isEqualToString:STRING_1]) {
            btnThree =[[UIButton alloc]init];
            [self addSubview:btnThree];
            
            btnFour =[[UIButton alloc]init];
            [self addSubview:btnFour];
            
            btnThreeL =[[UILabel alloc]init];
            [self addSubview:btnThreeL];
            
            btnFourL =[[UILabel alloc]init];
            [self addSubview:btnFourL];
//        }
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(15);
            make.right.equalTo(self.back).offset(-15);
            make.top.equalTo(self.back).offset(24);
        }];
        
        [hognxiang mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.back).offset(30);
            make.right.equalTo(self.back).offset(-30);
            make.top.equalTo(title.mas_bottom).offset(20);
            make.height.equalTo(@(1));
        }];
        if (btnThree && btnFour) {
            [btnOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(hognxiang);
                make.top.equalTo(hognxiang).offset(15);
                //            make.height.mas_equalTo(btnOne.mas_width);
                make.height.equalTo(@(45*PROPORTION_WIDTH));
                make.width.equalTo(@(45*PROPORTION_WIDTH));
            }];
            
            [btnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(btnOne.mas_right).offset(35.5*PROPORTION_WIDTH);
                make.centerY.equalTo(btnOne).offset(0);
                make.width.equalTo(btnOne);
                make.height.equalTo(btnOne);
            }];
            if (btnThree) {
                [btnThree mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(btnTwo.mas_right).offset(35.5*PROPORTION_WIDTH);
                    make.centerY.equalTo(btnOne).offset(0);
                    make.width.equalTo(btnOne);
                    make.height.equalTo(btnOne);
                }];
            }
            if (btnFour) {
                [btnFour mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(btnThree.mas_right).offset(35.5*PROPORTION_WIDTH);
                    make.centerY.equalTo(btnOne).offset(0);
                    make.width.equalTo(btnOne);
                    make.height.equalTo(btnOne);
                }];
            }
        } else {
            [btnOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_centerX).offset(-35.5*PROPORTION_WIDTH*0.5);
                make.top.equalTo(hognxiang).offset(15);
                //            make.height.mas_equalTo(btnOne.mas_width);
                make.height.equalTo(@(45*PROPORTION_WIDTH));
                make.width.equalTo(@(45*PROPORTION_WIDTH));
            }];
            
            [btnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(btnOne.mas_right).offset(35.5*PROPORTION_WIDTH);
                make.centerY.equalTo(btnOne).offset(0);
                make.width.equalTo(btnOne);
                make.height.equalTo(btnOne);
            }];
        }
        [btnOneL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btnOne.mas_bottom).offset(13);
            make.centerX.equalTo(btnOne);
        }];
        
        [btnTwoL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btnTwo.mas_bottom).offset(13);
            make.centerX.equalTo(btnTwo);
        }];
        if (btnThreeL) {
            [btnThreeL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btnOne.mas_bottom).offset(13);
                make.centerX.equalTo(btnThree);
            }];
        }
        if (btnFourL) {
            [btnFourL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btnTwo.mas_bottom).offset(13);
                make.centerX.equalTo(btnFour);
            }];
        }
        //set
        title.text = NSLocalizedString(@"Share to", @"Share to");
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = ColorWithHex(0x000000, 0.54);
        title.font = PingFangSC_Regular(17);
        hognxiang.backgroundColor = ColorWithHex(0x000000, 0.1);

        [btnOne setImage:ImageNamed(WECHAT_POPVIEW) forState:UIControlStateNormal];
        [btnTwo setImage:ImageNamed(WECHAT_CIRCLE_OF_FRIENDS_POPVIEW) forState:UIControlStateNormal];
        [btnThree setImage:ImageNamed(QQ_BUDDY_POPVIEW) forState:UIControlStateNormal];
        [btnFour setImage:ImageNamed(QQ_ZONE_POPVIEW) forState:UIControlStateNormal];
        btnOneL.text = NSLocalizedString(@"WeChat", @"WeChat");
        btnTwoL.text = NSLocalizedString(@"Circle of friends", @"Circle of friends");
        btnThreeL.text = NSLocalizedString(@"QQ buddy", @"QQ buddy");
        btnFourL.text = NSLocalizedString(@"QQ Zone", @"QQ Zone");
        
        btnOneL.font = PingFangSC_Regular(12);
        btnTwoL.font = PingFangSC_Regular(12);
        btnThreeL.font = PingFangSC_Regular(12);
        btnFourL.font = PingFangSC_Regular(12);
        btnOneL.textColor = ColorWithHex(0x000000, 0.54);
        btnTwoL.textColor = ColorWithHex(0x000000, 0.54);
        btnThreeL.textColor = ColorWithHex(0x000000, 0.54);
        btnFourL.textColor = ColorWithHex(0x000000, 0.54);
        
        btnTwo.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btnOne.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btnThree.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btnFour.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [btnOne addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnTwo addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnThree addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnFour addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btnOne.tag = UMSocialPlatformType_WechatSession;
        btnTwo.tag = UMSocialPlatformType_WechatTimeLine;
        btnThree.tag = UMSocialPlatformType_QQ;
        btnFour.tag = UMSocialPlatformType_Qzone;
        
    }
    return self;
}
- (void)btnClick:(UIButton *)btn{
    if (self.shareClick) {
        [self removeFromSuperview];
        self.shareClick((int)btn.tag);
    }
}

- (void)windosViewshow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(window);
        make.right.equalTo(window);
        make.top.equalTo(window).offset(HEIGHT_NAVBAR);
        make.bottom.equalTo(window);
    }];
    
}
@end
