//
//  CashierVc.h
//  portal
//
//  Created by Store on 2017/9/7.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicUiTableView.h"
typedef void (^PaySuccess)(NSDictionary *dic);

@interface CashierVc : basicUiTableView
@property (nonatomic,strong)payPre *data;
@property (nonatomic,copy) PaySuccess Successblock;
@end
