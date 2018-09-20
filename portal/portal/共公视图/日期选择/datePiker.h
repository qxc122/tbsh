//
//  datePiker.h
//  TourismT
//
//  Created by Store on 2017/1/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+DateTools.h"

@interface datePiker : UIView
- (void)windosViewshow;
- (void)closeClisck;
@property (nonatomic, strong) NSDate* minDate;
@property (nonatomic, strong) NSDate* maxDate;

@property (nonatomic, strong) NSString* minDateStr;  //格式  19700101   1970年1月1日
@property (nonatomic, strong) NSString* maxDateStr;   //格式  19700101    1970年1月1日

@property (nonatomic, copy) void (^SelecetDateStr)(NSString *Date);  //格式  YYYY-MM-dd
@property (nonatomic, copy) void (^SelecetDate)(NSDate *Date);
@end
