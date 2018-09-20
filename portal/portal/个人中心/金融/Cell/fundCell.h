//
//  fundCell.h
//  portal
//
//  Created by Store on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"

@interface fundCell : UITableViewCell
@property (nonatomic,strong) NSURL *fundProductPicture;
+ (instancetype)returnCellWith:(UITableView *)tableView;
@property (nonatomic, copy) void (^gotoDoing)();
@end
