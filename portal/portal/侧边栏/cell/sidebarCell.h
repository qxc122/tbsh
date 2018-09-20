//
//  sidebarCell.h
//  portal
//
//  Created by Store on 2017/9/1.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToolModeldata.h"

@interface sidebarCell : UITableViewCell
@property (nonatomic,strong) leftData *data;
@property (nonatomic,strong) NSString *hasUnreadNews;
+ (instancetype)returnCellWith:(UITableView *)tableView;
@end
