//
//  InsuranceHead.m
//  portal
//
//  Created by Store on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "InsuranceHead.h"
#import "UIImageView+Add.h"

@interface InsuranceHead ()
@property (nonatomic,weak) UIImageView *titleicon;
@property (nonatomic,weak) UILabel *title;

@end


@implementation InsuranceHead

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *titleicon = [UIImageView new];
        [self addSubview:titleicon];
        self.titleicon = titleicon;
        
        UILabel *title = [UILabel new];
        [self addSubview:title];
        self.title = title;
        
        [titleicon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self.title);
            make.height.equalTo(@(16));
            make.width.equalTo(@(16));
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleicon.mas_right).offset(5);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        title.text = NSLocalizedString(@"Select insurance", @"Select insurance");
        title.font = PingFangSC_Regular(16);
        title.textColor = ColorWithHex(0x2D2D2D, 1.0);
        titleicon.image = [UIImage imageNamed:SELECTED_INSURANCE_ICON];
        [titleicon SetContentModeScaleAspectFill];
    }
    return self;
}

@end
