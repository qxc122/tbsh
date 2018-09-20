//
//  fundCell.m
//  portal
//
//  Created by Store on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "fundCell.h"
#import "UIImageView+Add.h"


@interface fundCell ()
@property (nonatomic,weak) UIImageView *titleicon;
@property (nonatomic,weak) UILabel *title;

@property (nonatomic,weak) UILabel *more;
@property (nonatomic,weak) UIImageView *moreicon;
@property (nonatomic,weak) UIButton *moreBtn;

@property (nonatomic,weak) UIImageView *imnage;
@property (nonatomic,weak) UIView *lineBottom;
@end

@implementation fundCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    fundCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[fundCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
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
        
        UILabel *more = [UILabel new];
        [self.contentView addSubview:more];
        self.more = more;
        
        UIImageView *moreicon = [UIImageView new];
        [self.contentView addSubview:moreicon];
        self.moreicon = moreicon;
        
        UIButton *moreBtn = [UIButton new];
        [self.contentView addSubview:moreBtn];
        self.moreBtn = moreBtn;
        
        UIImageView *imnage = [UIImageView new];
        [self.contentView addSubview:imnage];
        self.imnage = imnage;
        
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
            make.bottom.equalTo(imnage.mas_top);
        }];
        
        [moreicon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16.3);
            make.centerY.equalTo(self.title);
            make.width.equalTo(@(6.7));
            make.height.equalTo(@(11.1));
        }];
        [more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.title.mas_right).offset(5);
            make.right.equalTo(self.moreicon.mas_left).offset(-5);
            make.centerY.equalTo(self.title);
        }];
        
        [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(more);
            make.right.equalTo(moreicon);
            make.top.equalTo(title);
            make.bottom.equalTo(title);
        }];
        
        [imnage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(46);
            make.height.equalTo(@(110*PROPORTION_HEIGHT));
        }];
        
        [lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.imnage.mas_bottom);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@(10));
        }];
        lineBottom.backgroundColor =VIEW_BACKGROUND_COLOR;
        title.font = PingFangSC_Regular(16);
        title.textColor = ColorWithHex(0x2D2D2D, 1.0);
        
        more.font = PingFangSC_Regular(14);
        more.textColor = ColorWithHex(0x5F6985, 1.0);

        moreicon.image = [UIImage imageNamed:CLICK_RIGHT];
        titleicon.image = [UIImage imageNamed:SELECT_FUND_ICON];
        [titleicon SetContentModeScaleAspectFill];
        [imnage SetContentModeScaleAspectFill];
        [moreBtn addTarget:self action:@selector(moreBtngotoDoing) forControlEvents:UIControlEventTouchUpInside];
        title.text = NSLocalizedString(@"choice fund", @"choice fund");
        more.text = NSLocalizedString(@"View more", @"View more");
    }
    return self;
}
- (void)setFundProductPicture:(NSURL *)fundProductPicture{
    _fundProductPicture = fundProductPicture;
    [self.imnage sd_setImageWithURL:fundProductPicture placeholderImage:[UIImage imageNamed:SD_ALTERNATIVE_PICTURES]];
}

- (void)moreBtngotoDoing{
    if (self.gotoDoing) {
        self.gotoDoing();
    }
}
@end
