//
//  CashierCell.m
//  portal
//
//  Created by Store on 2017/9/7.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "CashierCell.h"
#import "UIImageView+Add.h"
#import "NSString+Add.h"
@interface CashierCell ()
@property (nonatomic,weak) UIImageView *back;
@property (nonatomic,weak) UILabel *title1;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UIView *line1;

@property (nonatomic,weak) UILabel *price1;
@property (nonatomic,weak) UILabel *price;

@property (nonatomic,weak) UIView *bottom;
@property (nonatomic,weak) UILabel *type1;
@property (nonatomic,weak) UILabel *type;
@property (nonatomic,weak) UIImageView *typeIcon;

@property (nonatomic,weak) UIButton *goPay;
@end


@implementation CashierCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    CashierCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[CashierCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *back = [UIImageView new];
        [self.contentView addSubview:back];
        self.back = back;
        
        UILabel *title1 = [UILabel new];
        [self.contentView addSubview:title1];
        self.title1 = title1;
        UILabel *title = [UILabel new];
        [self.contentView addSubview:title];
        self.title = title;
        UIView *line1 = [UIView new];
        [self.contentView addSubview:line1];
        self.line1 = line1;
        
        UILabel *price1 = [UILabel new];
        [self.contentView addSubview:price1];
        self.price1 = price1;
        UILabel *price = [UILabel new];
        [self.contentView addSubview:price];
        self.price = price;
        
        UIView *bottom = [UIView new];
        [self.contentView addSubview:bottom];
        self.bottom = bottom;
        
        UILabel *type1 = [UILabel new];
        [self.contentView addSubview:type1];
        self.type1 = type1;
        UILabel *type = [UILabel new];
        [self.contentView addSubview:type];
        self.type = type;
        UIImageView *typeIcon = [UIImageView new];
        [self.contentView addSubview:typeIcon];
        self.typeIcon = typeIcon;
        
        UIButton *goPay = [UIButton new];
        [self.contentView addSubview:goPay];
        self.goPay = goPay;

        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
        }];
        [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line1);
            make.top.equalTo(self.contentView).offset(32);
//            make.width.equalTo(@(64));
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title1.mas_right).offset(20);
            make.right.equalTo(line1);
            make.top.equalTo(title1);
        }];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(title.mas_bottom).offset(30);
        }];
        [price1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title1);
            make.top.equalTo(line1.mas_bottom).offset(15);
            make.width.equalTo(title1);
        }];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title);
            make.right.equalTo(line1);
            make.top.equalTo(price1);
            make.bottom.equalTo(back.mas_bottom).offset(-26);
        }];
        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(back.mas_bottom).offset(4);
            make.height.equalTo(@55);
        }];
        [type1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title1);
            make.top.equalTo(bottom);
            make.bottom.equalTo(bottom);
            make.width.equalTo(title1);
        }];
        [type mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title);
            make.top.equalTo(bottom);
            make.bottom.equalTo(bottom);
        }];
        [typeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(type.mas_right).offset(5);
            make.centerY.equalTo(bottom);
            make.width.equalTo(@14);
            make.height.equalTo(@14);
        }];
        
        [goPay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line1);
            make.right.equalTo(line1);
            make.top.equalTo(bottom.mas_bottom).offset(30);
            make.height.equalTo(@50);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
        title1.font = PingFangSC_Regular(15);
        title1.textColor = ColorWithHex(0x2D2D2D, 0.5);
        title.font = PingFangSC_Regular(15);
        title.textColor = ColorWithHex(0x2D2D2D, 0.8);
        
        price1.font = PingFangSC_Regular(15);
        price1.textColor = ColorWithHex(0x2D2D2D, 0.5);

        type1.font = PingFangSC_Regular(15);
        type1.textColor = ColorWithHex(0x2D2D2D, 0.5);
        type.font = PingFangSC_Regular(15);
        type.textColor = ColorWithHex(0x2D2D2D, 1.0);

        bottom.backgroundColor  =[UIColor whiteColor];
        line1.backgroundColor = GENERAL_GREY_COLOR;
        back.image = [UIImage imageNamed:ORDER_BUTTON];
        typeIcon.image = [UIImage imageNamed:DETERMINE_SELECTION_BUTTON];
        [back SetContentModeScaleAspectFill];
        [typeIcon SetContentModeScaleAspectFill];
        [goPay setBackgroundImage:[UIImage imageNamed:PAYMENT_BUTTON] forState:UIControlStateNormal];
        [goPay setTitleColor:ColorWithHex(0xFFFFFF, 1.0) forState:UIControlStateNormal];
        [goPay addTarget:self action:@selector(goPayBtn) forControlEvents:UIControlEventTouchUpInside];
        goPay.titleLabel.font = PingFangSC_Regular(16);
        title1.text  =NSLocalizedString(@"Order name", @"Order name");
        price1.text  =NSLocalizedString(@"Order amount", @"Order amount");
        type1.text  =NSLocalizedString(@"Payment method", @"Payment method");
        
        //set
        type.text  =NSLocalizedString(@"T Wallet", @"T Wallet");
    }
    return self;
}
- (void)setPaydata:(payData *)paydata{
    _paydata = paydata;
    self.title.text  =paydata.orderName;
    self.price.text  =[NSString stringWithFormat:@"%.2f",[paydata.orderPrice floatValue]];
    [self.goPay setTitle:[NSString stringWithFormat:@"%@(¥%@)",NSLocalizedString(@"Go pay", @"Go pay"),[NSString stringWithFormat:@"%.2f",[paydata.orderPrice floatValue]]] forState:UIControlStateNormal];
}
- (void)goPayBtn{
    if (self.gpPayT) {
        self.gpPayT();
    }
}
@end
