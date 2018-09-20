//
//  infoCell.h
//  portal
//
//  Created by TFT on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"

typedef NS_ENUM(NSInteger, infoCell_type)
{
    deleteBtn_infoCell_type,
    editBtn_infoCell_type,
};


@interface infoCell : UITableViewCell
@property (nonatomic,strong) NSArray *countyArray;
@property (nonatomic,strong) id data;
+ (instancetype)returnCellWith:(UITableView *)tableView;

@property (nonatomic, copy) void (^deleteBtnOreditBtn)(id data,infoCell_type type);
@end
