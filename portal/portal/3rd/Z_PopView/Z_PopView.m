//
//  Z_PopView.m
//  UGuang
//
//  Created by Lidear on 16/3/23.
//  Copyright © 2016年 LidearOceanus. All rights reserved.
//

#import "Z_PopView.h"

#define ZShowViewWidh 100
#define ZShowViewBtnHeight 44

#define ZShowViewFRAMHeight 5.f

@interface Z_PopView ()
@property (strong, nonatomic) NSArray *array;
@property (weak, nonatomic) UIButton *back;

@end


@implementation Z_PopView

- (instancetype)initWithArray:(NSArray *)array WithImageArray:(NSArray *)ImageArray
{
    
    self = [[Z_PopView alloc] initWithFrame:CGRectMake(0, 0, ZShowViewWidh, ZShowViewBtnHeight*array.count+ZShowViewFRAMHeight)];
    self.array  =array;
//    self = [[Z_PopView alloc] init];
    [self createSubViews:array WithImageArray:ImageArray];
    return self;
}

// 创建items
- (void)createSubViews:(NSArray *)array WithImageArray:(NSArray *)ImageArray
{
    UIImageView *top = [UIImageView new];
//    top.backgroundColor = [UIColor redColor];
    [self addSubview:top];
    [top mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self);
        make.width.equalTo(@(ZShowViewFRAMHeight*2));
        make.height.equalTo(@(ZShowViewFRAMHeight));
    }];
    top.image = [UIImage imageNamed:FRAM_POPVIEW];
    for (int i = 0; i < array.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(0, ZShowViewBtnHeight*i+ZShowViewFRAMHeight, ZShowViewWidh, ZShowViewBtnHeight)];
        [btn setImage:[UIImage imageNamed:ImageArray[i]] forState:UIControlStateNormal];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:ColorWithHex(0x2D2D2D, 1.0) forState:UIControlStateNormal];
        btn.titleLabel.font = PingFangSC_Regular(14);
        btn.imageEdgeInsets = UIEdgeInsetsMake(15, 30, 15, ZShowViewWidh-15-30);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [btn addTarget:self action:@selector(chooseItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btn.backgroundColor = [UIColor whiteColor];
        if (array.count != (i+1)) {
            UIView *line = [UIView new];
            line.backgroundColor = GENERAL_GREY_COLOR;
            [line setFrame:CGRectMake(0, ZShowViewBtnHeight*i+ZShowViewBtnHeight-0.5+ZShowViewFRAMHeight, ZShowViewWidh, 0.5)];
            [self addSubview:line];
        }
    }
}

// 显示
- (void)showInView:(UIView *)view baseView:(UIView *)baseView withPosition:(ZShowPosition)position
{
    [self add_self:view];
//    CGPoint point = baseView.frame.origin;
//    CGSize size = baseView.frame.size;
//    CGPoint center = baseView.center;
//    
//    
//    switch (position) {
//        case ZShowTop:
//        {
//            self.center = CGPointMake(center.x, HEIGHT_NAVBAR*0.5+center.x - self.frame.size.height / 2.0 - size.height / 2.0);
//            [self add_self:view];
//        }
//            break;
//            
//        case ZShowLeft:
//        {
//            self.frame = CGRectMake(point.x - size.width,HEIGHT_NAVBAR + point.y + size.height / 2.0, self.frame.size.width, self.frame.size.height);
//            [self add_self:view];
//        }
//            
//            break;
//            
//        case ZShowBottom:
//        {
//            self.center = CGPointMake(center.x,HEIGHT_NAVBAR*0.5 +  center.y + self.frame.size.height / 2.0 + size.height / 2.0);
//            [self add_self:view];
//        }
//            break;
//            
//        default:
//        {
//            self.frame = CGRectMake(point.x + size.width,HEIGHT_NAVBAR +  point.y + size.height / 2.0, self.frame.size.width, self.frame.size.height);;
//            [self add_self:view];
//        }
//            break;
//    }
}

- (void)add_self:(UIView *)view
{
    UIButton *back = [UIButton new];
    self.back = back;
    [view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view);
        make.left.equalTo(view);
        make.top.equalTo(view);
        make.bottom.equalTo(view);
    }];
    [back addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    [view addSubview:self];
    //    self = [[Z_PopView alloc] initWithFrame:CGRectMake(0, 0, ZShowViewWidh, ZShowViewBtnHeight*array.count)];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-15);
        make.top.equalTo(view).offset(HEIGHT_NAVBAR+5);
        make.width.equalTo(@(ZShowViewWidh));
        make.height.equalTo(@(ZShowViewBtnHeight*self.array.count+ZShowViewFRAMHeight));
    }];
    
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 1.0;
    }];
}
- (void)backBtn{
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.back removeFromSuperview];
        [self removeFromSuperview];
    }];
}
// 选择item时回调
- (void)chooseItem:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (_chooseBlock) {
        _chooseBlock(btn.titleLabel.text);
        [UIView animateWithDuration:.3 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.back removeFromSuperview];
        }];
    }
}
- (void)dealloc{
    NSLog(@"%s",__FUNCTION__);
}
@end
