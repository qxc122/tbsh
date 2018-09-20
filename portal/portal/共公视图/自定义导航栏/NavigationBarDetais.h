//
//  NavigationBarDetais.h
//  TourismT
//
//  Created by Store on 2017/7/28.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NavigationBarDetais_Click_ENMU)
{
    keepOrshare_NavigationBarDetais_Click_ENMU,//收藏Or分享
    back_NavigationBarDetais_Click_ENMU,//返回
};
@interface NavigationBarDetais : UIView
@property (nonatomic, assign) CGFloat alpaImage; //背景图片 透明度
@property (nonatomic, weak) UILabel *title;
@property (copy,nonatomic) void (^brnClickType)(NavigationBarDetais_Click_ENMU type);
@end
