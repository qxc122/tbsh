//
//  MyNewsCell.m
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "MyNewsCell.h"
#import "UIImageView+CornerRadius.h"
#import "UIImageView+Add.h"
@interface MyNewsCell ()
@property (nonatomic,weak) UIImageView *image;
@property (nonatomic,weak) UIView *bottom;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UIView *line;
@property (nonatomic,weak) UILabel *type;
@property (nonatomic,weak) UILabel *time;
@end

@implementation MyNewsCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    MyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[MyNewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *image = [UIImageView new];
        [self.contentView addSubview:image];
        self.image = image;
        
        UIView *bottom = [UIView new];
        [self.contentView addSubview:bottom];
        self.bottom = bottom;
        
        UILabel *title = [UILabel new];
        [self.contentView addSubview:title];
        self.title = title;
        
        UIView *line = [UIView new];
        [self.contentView addSubview:line];
        self.line = line;
        
        UILabel *type = [UILabel new];
        [self.contentView addSubview:type];
        self.type = type;
        
        UILabel *time = [UILabel new];
        [self.contentView addSubview:time];
        self.time = time;

        image.frame = CGRectMake(15, 15, SCREENWIDTH-30, 120*PROPORTION_HEIGHT);
//        [image mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentView).offset(15);
//            make.height.equalTo(@(120*PROPORTION_HEIGHT));
//            make.left.equalTo(self.contentView).offset(15);
//            make.right.equalTo(self.contentView).offset(-15);
//        }];
        
        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(120*PROPORTION_HEIGHT+15);
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(image);
            make.right.equalTo(image);
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottom).offset(15);
            make.right.equalTo(bottom).offset(-15);
            make.top.equalTo(bottom).offset(15);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottom);
            make.height.equalTo(@0.5);
            make.right.equalTo(bottom);
            make.top.equalTo(title.mas_bottom).offset(15);
        }];
        [type mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title);
            make.top.equalTo(line.mas_bottom).offset(15);
            make.bottom.equalTo(bottom).offset(-15);
        }];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(title);
            make.centerY.equalTo(type);
        }];
        
        title.font = PingFangSC_Regular(15);
        title.textColor = ColorWithHex(0x2D2D2D, 1.0);
        
        type.font = PingFangSC_Regular(12);
        type.textColor = ColorWithHex(0x2D2D2D, 0.8);
        
        time.font = PingFangSC_Regular(12);
        time.textColor = ColorWithHex(0x2D2D2D, 0.8);

        line.backgroundColor = GENERAL_GREY_COLOR;
        bottom.backgroundColor = [UIColor whiteColor];
        [image zy_cornerRadiusAdvance:PICTURE_FILLET_SIZE rectCornerType:UIRectCornerTopLeft | UIRectCornerTopRight];
        [image SetContentModeScaleAspectFill];
    }
    return self;
}
- (void)setData:(MyNewsData_One *)data{
    _data = data;
    self.title.text = data.newsTitle;
    self.type.text = data.newsType;
    self.time.text = data.newsDate;
    [self.image sd_setImageWithURL:data.newsImg placeholderImage:[UIImage imageNamed:SD_ALTERNATIVE_PICTURES]];
}

@end
