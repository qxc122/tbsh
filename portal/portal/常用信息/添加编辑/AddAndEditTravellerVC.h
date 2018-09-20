//
//  AddAndEditTravellerVC.h
//  portal
//
//  Created by TFT on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicUiTableView.h"

@interface AddAndEditTravellerVC : basicUiTableView
@property (nonatomic,strong) passengerInfos_one *data;
@property (nonatomic,assign) BOOL IsAdd; //默认是 新增
@property (nonatomic, copy) void (^AddOrEditSucdess)();
@end
