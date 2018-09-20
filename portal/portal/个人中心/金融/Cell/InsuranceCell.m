//
//  InsuranceCell.m
//  portal
//
//  Created by Store on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "InsuranceCell.h"
#import "UIImageView+Add.h"
#import "NSString+Add.h"
#import "YYLabel.h"
#import "NSAttributedString+YYText.h"

@interface InsuranceCell ()
@property (nonatomic,weak) UIImageView *image;
@property (nonatomic,weak) UIView *lineTop;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) YYLabel *Label;
@property (nonatomic,weak) UILabel *price;
@end

@implementation InsuranceCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    InsuranceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[InsuranceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *image = [UIImageView new];
        [self.contentView addSubview:image];
        self.image = image;
        
        UIImageView *lineTop = [UIImageView new];
        [self.contentView addSubview:lineTop];
        self.lineTop = lineTop;
        
        UILabel *title = [UILabel new];
        [self.contentView addSubview:title];
        self.title = title;
        
        YYLabel *Label = [YYLabel new];
        [self.contentView addSubview:Label];
        self.Label = Label;
        
        UILabel *price = [UILabel new];
        [self.contentView addSubview:price];
        self.price = price;

        [lineTop mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.height.equalTo(@(0.5));
        }];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.lineTop.mas_bottom).offset(15);
            make.bottom.equalTo(self.contentView).offset(-15);
            make.width.equalTo(@(100*PROPORTION_WIDTH));
            make.height.equalTo(@(75*PROPORTION_HEIGHT));
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-16.8);
            make.top.equalTo(image);
        }];
        [Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(title);
            make.right.equalTo(price.mas_left).offset(-15);
            make.top.equalTo(title.mas_bottom).offset(20*PROPORTION_HEIGHT);
            make.bottom.equalTo(image);
        }];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(title);
            make.centerY.equalTo(image);
        }];
        Label.numberOfLines = 0;
        [Label setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        
        title.font = PingFangSC_Regular(14);
        title.textColor = ColorWithHex(0x494949, 1.0);
        lineTop.backgroundColor = GENERAL_GREY_COLOR;
        
        Label.font = PingFangSC_Regular(10);
        Label.textColor = ColorWithHex(0x494949, 1.0);
    }
    return self;
}
- (void)setData:(FinanceVcData_One *)data{
    _data = data;
    [self.image sd_setImageWithURL:data.productPicture placeholderImage:[UIImage imageNamed:SD_ALTERNATIVE_PICTURES]];
    self.title.text = data.productName;
    NSMutableAttributedString *All = [NSMutableAttributedString new];
    if (data.productPrice && data.productPrice.length) {
        NSString *mtp = NSLocalizedString(@"RMB", @"RMB");
        if ([data.productPrice hasSuffix:mtp]) {
            data.productPrice = [data.productPrice stringByReplacingOccurrencesOfString:mtp withString:@""];
        }
        All = [data.productPrice CreatMutableAttributedStringWithFont:PingFangSC_Regular(16) Color:ColorWithHex(0xFB704B, 1.0) LineSpacing:0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [All appendAttributedString:[mtp CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0xFB704B, 1.0) LineSpacing:0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0]];
    }
    self.price.attributedText = All;

    NSMutableArray *Muarry = [NSMutableArray array];
    NSString *copyLabel = [data.productDesc copy];
    while ([copyLabel rangeOfString:@"|"].location != NSNotFound) {
        NSRange rage = [copyLabel rangeOfString:@"|"];
        NSString *tmp = [copyLabel substringToIndex:rage.location];
        tmp = [NSString stringWithFormat:@" %@  ",tmp];
        [Muarry addObject:tmp];
        copyLabel = [copyLabel substringFromIndex:rage.location+rage.length];
        if ([copyLabel rangeOfString:@"|"].location == NSNotFound) {
            copyLabel = [NSString stringWithFormat:@" %@ ",copyLabel];
            [Muarry addObject:copyLabel];
        }
    }
    
    NSMutableAttributedString *AllLabel = [NSMutableAttributedString new];
    NSMutableAttributedString *onePre = [[NSMutableAttributedString alloc] initWithString:@" "];
    [AllLabel appendAttributedString:onePre];
    for (NSString *tmp in Muarry) {
        NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:tmp];
        one.yy_font = PingFangSC_Regular(10);
        one.yy_color = ColorWithHex(0x494949, 1.0);
        one.yy_minimumLineHeight = 18.0;
        
        CGFloat height= [@"df" HeightWithFont:PingFangSC_Regular(10) withMaxWidth:MAXFLOAT];
        
        YYTextBorder *border = [YYTextBorder new];
        border.cornerRadius = PICTURE_FILLET_SIZE;
        border.insets = UIEdgeInsetsMake(-(18.0-height)*0.5, 0, -(18.0-height)*0.5, 2);
        border.strokeWidth = 0.5;
        border.strokeColor = ColorWithHex(0x494949, 1.0);
        border.lineStyle = YYTextLineStyleSingle;
        one.yy_textBackgroundBorder = border;
        
        YYTextBorder *highlightBorder = border.copy;
        highlightBorder.strokeWidth = 0;
        highlightBorder.strokeColor = one.yy_color;
        highlightBorder.fillColor = one.yy_color;
        
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:[UIColor whiteColor]];
        [highlight setBackgroundBorder:highlightBorder];
        [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];
        
        [AllLabel appendAttributedString:one];
        
        if (![tmp isEqual:[Muarry lastObject]]) {
            NSMutableAttributedString *onePre = [[NSMutableAttributedString alloc] initWithString:@"  "];
            [AllLabel appendAttributedString:onePre];
        }
    }
    self.Label.attributedText = AllLabel;
}
@end
