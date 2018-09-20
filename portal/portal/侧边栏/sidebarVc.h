//
//  sidebarVc.h
//  portal
//
//  Created by Store on 2017/9/1.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicUiTableView.h"

@interface sidebarVc : basicUiTableView
/**
 *  点击类型
 */
@property (nonatomic, copy) void (^ColoseSelf)();
@end
