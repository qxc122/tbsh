//
//  TourismCoCell.m
//  portal
//
//  Created by Store on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "TourismCoCell.h"
#import "UIImageView+CornerRadius.h"
#import "UIView+Add.h"
#import "NSString+Add.h"
@interface TourismCoCell ()
@property (nonatomic,weak) UIView *back;
@property (nonatomic,weak) UIImageView *image;
@property (nonatomic,weak) UIView *backLabel;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UILabel *des;

@property (nonatomic,weak) UILabel *price;
@end


@implementation TourismCoCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *back = [UIView new];
        [self.contentView addSubview:back];
        self.back = back;
        
        UIImageView *image = [UIImageView new];
        [self.contentView addSubview:image];
        self.image = image;
        
        UIView *backLabel = [UIView new];
        [self.contentView addSubview:backLabel];
        self.backLabel = backLabel;
    
        UILabel *title = [UILabel new];
        [self.contentView addSubview:title];
        self.title = title;
        
        UILabel *des = [UILabel new];
        [self.contentView addSubview:des];
        self.des = des;
        
        UILabel *price = [UILabel new];
        [self.contentView addSubview:price];
        self.price = price;
        
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.height.equalTo(@(100*PROPORTION_HEIGHT));
        }];
        [backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.image);
            make.height.equalTo(@(50));
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(5);
            make.right.equalTo(self.contentView).offset(-5);
            make.top.equalTo(backLabel).offset(6);
        }];
        [des mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title);
            make.right.equalTo(self.title);
            make.top.equalTo(title.mas_bottom);
            make.bottom.equalTo(backLabel).offset(-6);
        }];
        
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title);
            make.right.equalTo(self.title);
            make.top.equalTo(self.image.mas_bottom);
            make.bottom.equalTo(self.contentView);
        }];
        [back SetFilletWith:PICTURE_FILLET_SIZE];
        [back SetUIViewBordersWith:0.5 Color:GENERAL_GREY_COLOR];
        backLabel.backgroundColor = ColorWithHex(0x000000, 0.4);
        title.font = PingFangSC_Regular(15);
        title.textColor = ColorWithHex(0xFFFFFF, 1.0);
        des.font = PingFangSC_Regular(12);
        des.textColor = ColorWithHex(0xFFFFFF, 1.0);
        
        [image zy_cornerRadiusAdvance:PICTURE_FILLET_SIZE rectCornerType:UIRectCornerTopLeft | UIRectCornerTopRight];

    }
    return self;
}
- (void)setData:(FinanceVcData_One *)data{
    _data = data;
    [self.image sd_setImageWithURL:data.productPicture placeholderImage:[UIImage imageNamed:SD_ALTERNATIVE_PICTURES]];
    self.title.text = data.productName;
    self.des.text = data.productDesc;
    
    NSMutableAttributedString *All = [NSMutableAttributedString new];
    if (data.productPrice && data.productPrice.length) {
        if (![data.productPrice hasPrefix:@"¥"] && ![data.productPrice hasPrefix:@"¥"]) {
            data.productPrice = [@"¥" stringByAppendingString:data.productPrice];
        }

        All = [data.productPrice CreatMutableAttributedStringWithFont:PingFangSC_Medium(14) Color:ColorWithHex(0xFB704B, 1.0) LineSpacing:0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
    }
    if (data.remark && data.remark.length) {
        if (![data.remark hasPrefix:@" x"] && ![data.remark hasPrefix:@" X"]) {
            data.remark = [@" x" stringByAppendingString:data.remark];
        }
        [All appendAttributedString:[data.remark CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x2D2D2D, 1.0) LineSpacing:0 Alignment:NSTextAlignmentLeft BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0]];
    }
    self.price.attributedText = All;
}
@end
