//
//  ConductFinancialTransactionsCell.m
//  portal
//
//  Created by Store on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ConductFinancialTransactionsCell.h"
#import "UIImageView+Add.h"
#import "UIButton+Add.h"

@interface ConductFinancialTransactionsCell ()
@property (nonatomic,weak) UIImageView *titleicon;
@property (nonatomic,weak) UILabel *title;

@property (nonatomic,weak) UIImageView *image;
@property (nonatomic,weak) UIButton *ViewBtn;
@property (nonatomic,weak) UIView *lineBottom;
@end

@implementation ConductFinancialTransactionsCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    ConductFinancialTransactionsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[ConductFinancialTransactionsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *titleicon = [UIImageView new];
        [self.contentView addSubview:titleicon];
        self.titleicon = titleicon;
        
        UILabel *title = [UILabel new];
        [self.contentView addSubview:title];
        self.title = title;
        
        UIView *line = [UIView new];
        [self.contentView addSubview:line];
        
        UIImageView *image = [UIImageView new];
        [self.contentView addSubview:image];
        self.image = image;
        
        UIButton *ViewBtn = [UIButton new];
        [self.contentView addSubview:ViewBtn];
        self.ViewBtn = ViewBtn;
        
        UIView *lineBottom = [UIView new];
        [self.contentView addSubview:lineBottom];
        self.lineBottom = lineBottom;
        
        [titleicon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.title);
            make.height.equalTo(@(16));
            make.width.equalTo(@(16));
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleicon.mas_right).offset(5);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(image.mas_top);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(46);
            make.height.equalTo(@(0.5));
        }];
        
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(line.mas_bottom);
            make.height.equalTo(@(149*PROPORTION_HEIGHT));
        }];
        [ViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.image.mas_bottom);
            make.height.equalTo(@(28*PROPORTION_HEIGHT));
            make.width.equalTo(@(130*PROPORTION_WIDTH));
        }];
        [lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.ViewBtn.mas_bottom).offset(15);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@(10));
        }];
        line.backgroundColor = GENERAL_GREY_COLOR;
        lineBottom.backgroundColor = VIEW_BACKGROUND_COLOR;
        title.font = PingFangSC_Regular(16);
        title.textColor = ColorWithHex(0x2D2D2D, 1.0);
        title.text = NSLocalizedString(@"Selective Finance", @"Selective Finance");;
        
        titleicon.image = [UIImage imageNamed:SELECTED_FINANCIAL_ICON];
        [titleicon SetContentModeScaleAspectFill];
        [image SetContentModeScaleAspectFill];
        [ViewBtn setTitle:NSLocalizedString(@"Go and make money right now", @"Go and make money right now") forState:UIControlStateNormal];
        [ViewBtn setTitleColor:ColorWithHex(0xFF724B, 1.0) forState:UIControlStateNormal];
        ViewBtn.titleLabel.font = PingFangSC_Regular(15);
        [ViewBtn SetFilletWith:PICTURE_FILLET_SIZE];
        [ViewBtn SetBordersWith:0.5 Color:ColorWithHex(0xFF724B, 1.0)];
        [ViewBtn addTarget:self action:@selector(ViewBtnBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)setVcProductPicture:(NSURL *)vcProductPicture{
    _vcProductPicture = vcProductPicture;
    [self.image sd_setImageWithURL:vcProductPicture placeholderImage:[UIImage imageNamed:SD_ALTERNATIVE_PICTURES]];
}
- (void)ViewBtnBtn{
    if (self.gotoDoing) {
        self.gotoDoing();
    }
}
@end
