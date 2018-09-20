//
//  travellerCell.h
//  portal
//
//  Created by TFT on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeaderAll.h"

@interface travellerCell : UITableViewCell

@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UITextField *contentTF;

@property (nonatomic,strong) NSString *identifer;
@property (nonatomic,strong) NSString *sexMF;
@property (nonatomic,strong) NSString *idNO;  //身份证号码
+ (instancetype)returnCellWith:(UITableView *)tableView;


@property (nonatomic, copy) void (^Fill_in_the_text)(NSString *identifer,NSString *text);
@property (nonatomic, copy) void (^Begin_Fill_in_the_text)(UITextField *contentTF);
@property (nonatomic, copy) void (^Select_address)();
@property (nonatomic, copy) void (^Select_type)();
@property (nonatomic, copy) void (^Select_Sex)(NSString *sex);
@end
