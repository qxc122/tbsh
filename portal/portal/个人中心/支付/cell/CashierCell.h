//
//  CashierCell.h
//  portal
//
//  Created by Store on 2017/9/7.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"


@interface CashierCell : UITableViewCell
@property (nonatomic,strong)payData *paydata;
+ (instancetype)returnCellWith:(UITableView *)tableView;
@property (nonatomic, copy) void (^gpPayT)();
@end
