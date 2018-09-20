//
//  ChooseNationalityCell.m
//  jipiao
//
//  Created by Store on 2017/5/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ChooseNationalityCell.h"
#import "HeaderAll.h"

@interface ChooseNationalityCell ()
@property (nonatomic,weak) UILabel *label;
@end

@implementation ChooseNationalityCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    ChooseNationalityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[ChooseNationalityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *label = [UILabel new];
        [self.contentView addSubview:label];
        self.label = label;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(15);
            make.bottom.equalTo(self.contentView).offset(-15);
        }];
        
        UIView *line = [UIView new];
        line.backgroundColor = ColorWithHex(0x979797, 0.2);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(0);
            make.height.equalTo(@0.5);
            make.bottom.equalTo(self.contentView);
        }];
        label.font = PingFangSC_Regular(15);
        label.textColor = ColorWithHex(0x000000, 0.8);
    }
    return self;
}
- (void)setHeadStr:(NSString *)headStr{
    _headStr = headStr;
    self.label.text = headStr;
}
@end
