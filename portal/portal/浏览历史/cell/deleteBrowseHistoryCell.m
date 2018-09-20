//
//  deleteBrowseHistoryCell.m
//  portal
//
//  Created by Store on 2017/9/20.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "deleteBrowseHistoryCell.h"


@interface deleteBrowseHistoryCell ()
@property (nonatomic,weak) UIButton *deleteBtn;
@end

@implementation deleteBrowseHistoryCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *deleteBtn = [UIButton new];
        [self.contentView addSubview:deleteBtn];
        self.deleteBtn = deleteBtn;

        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView);
            make.height.equalTo(@49);
            make.width.equalTo(@(49));
        }];
        
        [self.back mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(15);
            make.bottom.equalTo(self.contentView).offset(-15);
            make.left.equalTo(deleteBtn.mas_right);
            make.width.equalTo(@(SCREENWIDTH-30));
            make.height.equalTo(@(86*PROPORTION_HEIGHT+20));
        }];
        [deleteBtn setImage:[UIImage imageNamed:CHECK_BOX_BTN] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:DETERMINE_SELECTION_BUTTON] forState:UIControlStateHighlighted];
        [deleteBtn setImage:[UIImage imageNamed:DETERMINE_SELECTION_BUTTON] forState:UIControlStateSelected];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(17.5, 15, 17.5, 20);
    }
    return self;
}

- (void)deleteBtnClick{
    self.deleteBtn.selected = !self.deleteBtn.selected;
    if (self.SelectIndex) {
        self.SelectIndex(self.data.favorId);
    }
}
@end
