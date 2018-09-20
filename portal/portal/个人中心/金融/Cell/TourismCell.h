//
//  TourismCell.h
//  portal
//
//  Created by Store on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"
@interface TourismCell : UITableViewCell
+ (instancetype)returnCellWith:(UITableView *)tableView;
@property (nonatomic,strong) NSArray *Arry_tourProductList;
/**
 *  点击类型
 */
@property (nonatomic, copy) void (^SelectIndex)(FinanceVcData_One *data);
@end
