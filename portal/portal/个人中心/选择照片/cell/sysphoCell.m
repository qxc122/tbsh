//
//  sysphoCell.m
//  TourismT
//
//  Created by Store on 16/12/28.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "sysphoCell.h"
#import "UIImageView+Add.h"
@interface sysphoCell ()
@property (nonatomic,weak) UIImageView *image;
@end

@implementation sysphoCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor redColor];
        UIImageView *image = [[UIImageView alloc]init];
        image.userInteractionEnabled = YES;
        self.image = image;
        [self.contentView addSubview:image];
        [image SetContentModeScaleAspectFill];

        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}
- (void)setImageResouce:(id)imageResouce{
    _imageResouce = imageResouce;
    if ([imageResouce isKindOfClass:[UIImage class]]) {
        self.image.image = imageResouce;
    } else if ([imageResouce isKindOfClass:[PHAsset class]]) {
        kWeakSelf(self);
        [[SuPhotoManager manager] accessToImageAccordingToTheAsset:imageResouce size:CGSizeMake(CGRectGetWidth(self.contentView.frame)*[[UIScreen mainScreen] scale],CGRectGetWidth(self.contentView.frame)*[[UIScreen mainScreen] scale] ) resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info) {
            if (image) {
                weakself.image.image = image;
            }
        }];
    }
}
@end
