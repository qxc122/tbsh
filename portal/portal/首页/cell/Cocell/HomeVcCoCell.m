//
//  HomeVcCoCell.m
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "HomeVcCoCell.h"


@interface HomeVcCoCell ()

@property (nonatomic,weak) UIImageView *image;
@end


@implementation HomeVcCoCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *image = [UIImageView new];
        self.image = image;
        [self.contentView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
        [image SetContentModeScaleAspectFill];
    }
    return self;
}

- (void)setData:(HomeDataOne *)data{
    _data = data;
    [self.image sd_setImageWithURL:data.merchIcon placeholderImage:[UIImage imageNamed:SD_ALTERNATIVE_PICTURES]];
}
@end
