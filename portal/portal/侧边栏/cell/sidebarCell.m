//
//  sidebarCell.m
//  portal
//
//  Created by Store on 2017/9/1.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "sidebarCell.h"
#import "HeaderAll.h"


@interface sidebarCell ()
@property (nonatomic,weak) UIImageView *icon;
@property (nonatomic,weak) UIImageView *redPoint;
@property (nonatomic,weak) UILabel *title;
@end

@implementation sidebarCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    sidebarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[sidebarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *icon = [UIImageView new];
        [self.contentView addSubview:icon];
        self.icon = icon;
        
        UIImageView *redPoint = [UIImageView new];
        [self.contentView addSubview:redPoint];
        self.redPoint = redPoint;
        
        UILabel *title = [UILabel new];
        [self.contentView addSubview:title];
        self.title = title;
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20*PROPORTION_WIDTH);
            make.top.equalTo(self.contentView).offset(35*PROPORTION_HEIGHT*0.5);;
            make.bottom.equalTo(self.contentView).offset(-35*PROPORTION_HEIGHT*0.5);
            make.width.equalTo(@(25*PROPORTION_WIDTH));
            make.height.equalTo(icon.mas_width);
        }];
        [redPoint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(icon).offset(6);
            make.top.equalTo(icon);
            make.width.equalTo(@(8));
            make.height.equalTo(redPoint.mas_width);
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(icon);
            make.left.equalTo(icon.mas_right).offset(12);
            make.right.equalTo(self.contentView).offset(-12);
        }];

        title.font = PingFangSC_Regular(16);
        title.textColor = ColorWithHex(0x494949, 1.0);
        self.redPoint.image = [UIImage imageNamed:MESSAGE_REMINDER];
        self.redPoint.hidden = YES;
        //test
    }
    return self;
}
- (void)setData:(leftData *)data{
    _data = data;
    self.title.text = data.title;
    self.icon.image = [UIImage imageNamed:data.image];
}
- (void)setHasUnreadNews:(NSString *)hasUnreadNews{
    _hasUnreadNews = hasUnreadNews;
    if ([hasUnreadNews isEqualToString:STRING_0]) {
       self.redPoint.hidden = YES;
    } else  if ([hasUnreadNews isEqualToString:STRING_1]) {
        self.redPoint.hidden = NO;
    }
}
@end
