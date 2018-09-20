//
//  BrowseHistoryCell.m
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "BrowseHistoryCell.h"
#import "UIImageView+Add.h"
@interface BrowseHistoryCell ()

@end

@implementation BrowseHistoryCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    BrowseHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[BrowseHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *back = [UIView new];
        [self.contentView addSubview:back];
        self.back = back;
        
        UIImageView *image = [UIImageView new];
        [self.contentView addSubview:image];
        self.image = image;
        
        UILabel *title = [UILabel new];
        [self.contentView addSubview:title];
        self.title = title;

        UILabel *link = [UILabel new];
        [self.contentView addSubview:link];
        self.link = link;
        
        UILabel *time = [UILabel new];
        [self.contentView addSubview:time];
        self.time = time;
        
        UIView *line = [UIView new];
        [self.contentView addSubview:line];
        self.line = line;
        
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15);
            make.bottom.equalTo(self.contentView).offset(-15);
            make.left.equalTo(self.contentView).offset(15);
//            make.right.equalTo(self.contentView).offset(-15);
            make.width.equalTo(@(SCREENWIDTH-30));
            make.height.equalTo(@(86*PROPORTION_HEIGHT+20));
        }];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(back);
            make.bottom.equalTo(back);
            make.left.equalTo(back);
            make.width.equalTo(@(134*PROPORTION_WIDTH));
        }];

        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).offset(10);
            make.right.equalTo(back).offset(-10);
            make.top.equalTo(back).offset(15);
        }];
        [link mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title);
            make.right.equalTo(title);
            make.top.equalTo(title.mas_bottom).offset(10);
        }];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title);
            make.right.equalTo(title);
            make.top.equalTo(link.mas_bottom).offset(12*PROPORTION_HEIGHT);
            make.bottom.equalTo(back).offset(-10);
        }];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.equalTo(@0.5);
            make.bottom.equalTo(self.contentView);
        }];

        time.textAlignment = NSTextAlignmentRight;
        title.font = PingFangSC_Regular(15);
        title.textColor = ColorWithHex(0x2D2D2D, 1.0);
        
        link.font = PingFangSC_Regular(12);
        link.textColor = ColorWithHex(0x2D2D2D, 0.3);
        link.numberOfLines = 2;
        time.font = PingFangSC_Regular(12);
        time.textColor = ColorWithHex(0x2D2D2D, 0.3);
        
        line.backgroundColor = GENERAL_GREY_COLOR;
        back.backgroundColor = VIEW_BACKGROUND_COLOR;
        [image SetContentModeScaleAspectFill];
        
        //tset
//        title.text = @"1sadf111";
//        link.text = @"1sadf222";
//        time.text = @"1sadf333";
//        
//        image.image = [UIImage imageNamed:BACKGROUND_BTN];
    }
    return self;
}

- (void)setData:(MyCollecData_One *)data{
    _data = data;
    self.title.text = data.title;
    self.link.text = data.url.absoluteString;
    self.time.text = data.date;
    [self.image sd_setImageWithURL:data.logo placeholderImage:[UIImage imageNamed:SD_ALTERNATIVE_PICTURES]];
}
@end
