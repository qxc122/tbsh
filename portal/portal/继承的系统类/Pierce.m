//
//  Pierce.m
//  portal
//
//  Created by Store on 2017/9/5.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "Pierce.h"

@implementation Pierce

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(hitView == self){
        return nil;
    }
    return hitView;
}

@end
