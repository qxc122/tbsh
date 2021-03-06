//
//  Z_PopView.h
//  UGuang
//
//  Created by Lidear on 16/3/23.
//  Copyright © 2016年 LidearOceanus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"
typedef NS_ENUM(NSInteger, ZShowPosition) {
    ZShowTop       = 0,
    ZShowLeft      = 1,
    ZShowBottom       = 2,
    ZShowRight   = 3,
};

typedef void(^ChooseBlock)(NSString *choose);

@interface Z_PopView : UIView
@property (nonatomic, copy) ChooseBlock chooseBlock;  //展示

// 自定义选择项并初始化
- (instancetype)initWithArray:(NSArray *)array  WithImageArray:(NSArray *)ImageArray;

// 展示 view是指展示的view  baseView是指哪个控件
- (void)showInView:(UIView *)view baseView:(UIView *)baseView withPosition:(ZShowPosition)position;

@end
