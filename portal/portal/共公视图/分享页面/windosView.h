//
//  windosView.h
//  TourismT
//
//  Created by Store on 16/12/15.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"

@interface windosView : UIView
- (void)windosViewshow;
- (void)closeClisck;

@property (nonatomic,weak) UIView *back; //

@property (nonatomic,weak) UIButton *close; //
@property (nonatomic,weak) UIView *blcak; //
@property (nonatomic,strong) UITapGestureRecognizer *tap; //
@end
