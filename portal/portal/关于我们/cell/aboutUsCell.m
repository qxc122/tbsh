//
//  aboutUsCell.m
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "aboutUsCell.h"



@interface aboutUsCell ()
@property (nonatomic,weak) UIImageView *more;
@property (nonatomic,weak) UIView *line;
@property (nonatomic,weak) UILabel *title;
@end

@implementation aboutUsCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    aboutUsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[aboutUsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *more = [UIImageView new];
        [self.contentView addSubview:more];
        self.more = more;
        
        UIView *line = [UIView new];
        [self.contentView addSubview:line];
        self.line = line;
        
        UILabel *title = [UILabel new];
        [self.contentView addSubview:title];
        self.title = title;
        
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(20);
            make.bottom.equalTo(self.contentView).offset(-20);
            make.left.equalTo(line);
            make.right.equalTo(self.more.mas_left).offset(-15);
        }];
        
        [more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.title);
            make.right.equalTo(line);
            make.width.equalTo(@(6.7));
            make.height.equalTo(@11.9);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.equalTo(@(0.5));
            make.bottom.equalTo(self.contentView);
        }];
        title.font = PingFangSC_Regular(15);
        title.textColor = ColorWithHex(0x2D2D2D, 0.8);
        line.backgroundColor = GENERAL_GREY_COLOR;
        more.image = [UIImage imageNamed:CLICK_RIGHT];
    }
    return self;
}
- (void)setData:(leftData *)data{
    _data = data;
    self.title.text = data.title;
}

@end
