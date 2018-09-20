//
//  PersonalCenterCell.h
//  portal
//
//  Created by Store on 2017/9/5.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"

#define  IconMoreBtnIdentifier  @"IconMoreBtnIdentifier"
#define  nikeNameMoreBtnIdentifier  @"nikeNameMoreBtnIdentifier"
#define  MemberMoreBtnIdentifier  @"MemberMoreBtnIdentifier"
#define  ExitBtnIdentifier  @"ExitBtnIdentifier"

@interface PersonalCenterCell : UITableViewCell
@property (nonatomic,strong) UserInfo *data;
+ (instancetype)returnCellWith:(UITableView *)tableView;
/**
 *  点击类型
 */
@property (nonatomic, copy) void (^GoToEditThePersonalInfo)(NSString *Identifier);
@end
