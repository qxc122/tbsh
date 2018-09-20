//
//  BrowseHistoryCell.h
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"

@interface BrowseHistoryCell : UITableViewCell
@property (nonatomic,strong) MyCollecData_One *data;
+ (instancetype)returnCellWith:(UITableView *)tableView;
@property (nonatomic,weak) UIImageView *image;
@property (nonatomic,weak) UIView *back;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UILabel *link;
@property (nonatomic,weak) UILabel *time;
@property (nonatomic,weak) UIView *line;
@end
