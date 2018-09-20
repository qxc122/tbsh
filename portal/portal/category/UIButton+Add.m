//
//  UIButton+Add.m
//  portal
//
//  Created by Store on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "UIButton+Add.h"

@implementation UIButton (Add)
- (void)SetFilletWith:(CGFloat)Radius{
    [self.layer setCornerRadius:Radius*0.5];
    [self.layer setMasksToBounds:YES];
}

- (void)SetBordersWith:(CGFloat)Width Color:(UIColor *)color{
    [self.layer setBorderWidth:(Width)];
    [self.layer setBorderColor:[color CGColor]];
}
@end
