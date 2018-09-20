//
//  datePiker.m
//  TourismT
//
//  Created by Store on 2017/1/14.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "datePiker.h"
#import "HeaderAll.h"

@interface datePiker ()
@property (nonatomic,weak) UIView *back; //
@property (nonatomic, weak) UIDatePicker *myDatePicker;
@end

@implementation datePiker
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *blcak = [[UIView alloc]init];
        blcak.backgroundColor = ColorWithHex(0x000000, 0.5);
        [self addSubview:blcak];
        
        UIDatePicker *myDatePicker = [[UIDatePicker alloc] init];
        self.myDatePicker  =myDatePicker;
        [self addSubview:myDatePicker];
        myDatePicker.backgroundColor = ColorWithHex(0xFFFFFF, 1.0);
        
        [myDatePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        myDatePicker.datePickerMode = UIDatePickerModeDate;
        
        UIButton *change = [[UIButton alloc]init];
        [self addSubview:change];
        change.tag = 0;
        [change addTarget:self action:@selector(btnClilc:) forControlEvents:UIControlEventTouchUpInside];
        [change setTitle:NSLocalizedString(@"cancel", @"cancel") forState:UIControlStateNormal];
        [change setTitleColor:ColorWithHex(0x000000, 0.54) forState:UIControlStateNormal];
        change.titleLabel.font = PingFangSC_Regular(14);
        
        
        UIButton *okok = [[UIButton alloc]init];
        [self addSubview:okok];
        okok.tag = 1;
        [okok addTarget:self action:@selector(btnClilc:) forControlEvents:UIControlEventTouchUpInside];
        [okok setTitle:NSLocalizedString(@"Determine", @"Determine") forState:UIControlStateNormal];
        [okok setTitleColor:ColorWithHex(0x000000, 0.54) forState:UIControlStateNormal];
        okok.titleLabel.font = PingFangSC_Regular(14);
        
        
        [blcak mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        [myDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(@(200));
            make.bottom.equalTo(self);
        }];
        [change mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(myDatePicker);
            make.width.equalTo(@(44));
            make.height.equalTo(@(30));
            make.top.equalTo(myDatePicker);
        }];
        [okok mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(myDatePicker);
            make.width.equalTo(@(44));
            make.height.equalTo(@(30));
            make.top.equalTo(myDatePicker);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeClisck)];
        [blcak addGestureRecognizer:tap];
    }
    return self;
}
- (void)closeClisck{
//    NSDate *theDate = self.myDatePicker.date;//该属性返回选中的时间
//    NSString *ddddd = [theDate formattedDateWithFormat:@"YYYY-MM-DD"];

    NSDate *theDate = self.myDatePicker.date;//该属性返回选中的时间
    NSString *theDateStr = [theDate formattedDateWithFormat:@"YYYY-MM-dd"];
    if (self.SelecetDate) {
        self.SelecetDate(theDate);
    }
    if (self.SelecetDateStr) {
        self.SelecetDateStr(theDateStr);
    }
    [self removeFromSuperview];
}
- (void)windosViewshow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(window);
        make.right.equalTo(window);
        make.top.equalTo(window);
        make.bottom.equalTo(window);
    }];
    
}
- (void)btnClilc:(UIButton *)btn{
    if (btn.tag == 0) {//取消
        [self removeFromSuperview];
    } else {
        [self closeClisck];
    }
}

- (void)setMaxDate:(NSDate *)maxDate{
    _maxDate  = maxDate;
    self.myDatePicker.maximumDate = maxDate;
}
- (void)setMinDate:(NSDate *)minDate{
    _minDate = minDate;
    self.myDatePicker.minimumDate = minDate;
}
- (void)setMaxDateStr:(NSString *)maxDateStr{
    _maxDateStr  = maxDateStr;
    if (maxDateStr.length ==8) {
        self.myDatePicker.maximumDate = [NSDate dateWithYear:[[maxDateStr substringToIndex:4] integerValue] month:[[maxDateStr substringWithRange:NSMakeRange(4, 2)] integerValue] day:[[maxDateStr substringFromIndex:6] integerValue]];
    }else{
       self.myDatePicker.maximumDate = [NSDate dateWithYear:2100 month:0 day:0];
    }
}
- (void)setMinDateStr:(NSString *)minDateStr{
    _minDateStr = minDateStr;
    if (minDateStr.length ==8) {
        self.myDatePicker.minimumDate = [NSDate dateWithYear:[[minDateStr substringToIndex:4] integerValue] month:[[minDateStr substringWithRange:NSMakeRange(4, 2)] integerValue] day:[[minDateStr substringFromIndex:6] integerValue]];
    }else{
        self.myDatePicker.minimumDate = [NSDate dateWithYear:1970 month:0 day:0];
    }
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}
@end
