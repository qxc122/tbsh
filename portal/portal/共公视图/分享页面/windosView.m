//
//  windosView.m
//  TourismT
//
//  Created by Store on 16/12/15.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "windosView.h"
#import "UIView+Add.h"
@implementation windosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *blcak = [[UIView alloc]init];
        self.blcak = blcak;
        blcak.backgroundColor = ColorWithHex(0x000000, 0.5);
        [self addSubview:blcak];
        
        UIView *back = [[UIView alloc]init];
        self.back = back;
        [back SetFilletWith:PICTURE_FILLET_SIZE*2];
        back.backgroundColor = ColorWithHex(0xFFFFFF, 1.0);
        [self addSubview:back];
        
        UIButton *close = [[UIButton alloc]init];
        self.close = close;
        [close setImage:ImageNamed(@"已取消") forState:UIControlStateNormal];
        [close addTarget:self action:@selector(closeClisck) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:close];
        
        [close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(back);
            make.bottom.equalTo(back.mas_top).offset(10);
            make.width.equalTo(@(25));
            make.height.equalTo(@(49));
        }];
        
        [blcak mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self).offset(-15);
            make.height.equalTo(@353);
//            make.height.mas_equalTo(back.mas_width).multipliedBy(353/345);
        }];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeClisck)];
        self.tap = tap;
        [blcak addGestureRecognizer:tap];
    }
    return self;
}
- (void)closeClisck{
    [self removeFromSuperview];
}
- (void)windosViewshow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(window);
        make.right.equalTo(window);
        make.top.equalTo(window);
        make.bottom.equalTo(window);
    }];

}

- (void)dealloc{
    NSLog(@"%s",__func__);
}
@end
