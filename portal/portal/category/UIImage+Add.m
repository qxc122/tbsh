//
//  UIImage+Add.m
//  portal
//
//  Created by Store on 2017/9/18.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "UIImage+Add.h"

@implementation UIImage (Add)
- (UIImage *)returnImageWithInsets:(UIEdgeInsets )insets{
    return  [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}
@end
