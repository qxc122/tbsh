//
//  aboutUsCell.h
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"

@interface aboutUsCell : UITableViewCell
@property (nonatomic,strong) leftData *data;
+ (instancetype)returnCellWith:(UITableView *)tableView;
@end
