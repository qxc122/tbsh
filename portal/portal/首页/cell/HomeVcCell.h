//
//  HomeVcCell.h
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"
@interface HomeVcCell : UITableViewCell
@property (nonatomic,strong)HomeData *data;
+ (instancetype)returnCellWith:(UITableView *)tableView;

/**
 *  点击类型
 */
@property (nonatomic, copy) void (^SelectIndex)(HomeDataOne *data);

@end
