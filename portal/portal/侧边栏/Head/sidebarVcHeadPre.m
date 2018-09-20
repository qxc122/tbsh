//
//  sidebarVcHeadPre.m
//  portal
//
//  Created by Store on 2017/9/5.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "sidebarVcHeadPre.h"


@interface sidebarVcHeadPre ()
@property (nonatomic,weak) UIButton *btn;
@end


@implementation sidebarVcHeadPre

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIButton *btn = [UIButton new];
        [self addSubview:btn];
        self.btn = btn;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-20-70*0.5*PROPORTION_HEIGHT);
            make.width.equalTo(@(68*PROPORTION_WIDTH));
            make.height.equalTo(btn.mas_width);
        }];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)btnClick:(UIButton *)btn{
    if (self.GoToThePersonalCenter) {
        self.GoToThePersonalCenter();
    }
}
@end
