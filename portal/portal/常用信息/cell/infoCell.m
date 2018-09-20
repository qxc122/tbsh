//
//  infoCell.m
//  portal
//
//  Created by TFT on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "infoCell.h"
#import "YYLabel.h"
#import "NSAttributedString+YYText.h"

@interface infoCell ()
@property (nonatomic,weak) UIButton *editBtn;
@property (nonatomic,weak) UIButton *deleteBtn;
@property (nonatomic,weak) UIImageView *lineimage;
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) YYLabel *detail;
@end

@implementation infoCell

+ (instancetype)returnCellWith:(UITableView *)tableView
{
    infoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[infoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *lineimage = [UIImageView new];
        [self.contentView addSubview:lineimage];
        self.lineimage = lineimage;
        
        UIButton *deleteBtn = [UIButton new];
        [self.contentView addSubview:deleteBtn];
        self.deleteBtn = deleteBtn;
        
        UIButton *editBtn = [UIButton new];
        [self.contentView addSubview:editBtn];
        self.editBtn = editBtn;
        
        
        UILabel *name = [UILabel new];
        [self.contentView addSubview:name];
        self.name = name;
        
        YYLabel *detail = [YYLabel new];
//        [detail sizeToFit];
        [self.contentView addSubview:detail];
        self.detail = detail;
        
     //   lineimage.frame = CGRectMake(15, 15, SCREENWIDTH-30, 120*PROPORTION_HEIGHT);
        [lineimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(0);
            make.height.equalTo(@(9));
            make.left.equalTo(self.contentView).offset(0);
            make.right.equalTo(self.contentView).offset(0);
        }];
        
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(name);
            make.width.equalTo(editBtn);
            make.height.equalTo(editBtn);
            make.right.equalTo(self.contentView).offset(-4);
        }];

        [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(deleteBtn);
            make.right.equalTo(deleteBtn.mas_left).offset(-6.5);
            make.height.equalTo(@(40));
            make.width.equalTo(@(40));
        }];

        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.height.equalTo(@15);
            make.width.equalTo(@240);
            make.top.equalTo(self.contentView).offset(20);
        }];
        
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(name);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(name.mas_bottom).offset(10);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];
        detail.numberOfLines = 0;
//        detail.backgroundColor =[UIColor redColor];
        name.font = PingFangSC_Regular(15);
        name.textColor = ColorWithHex(0x2D2D2D, 1.0);
        
        lineimage.backgroundColor = VIEW_BACKGROUND_COLOR;
        detail.numberOfLines = 0;

        deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 12, 10, 12);
        editBtn.imageEdgeInsets = UIEdgeInsetsMake(11.5, 11.5, 11.5, 11.5);
        [deleteBtn setImage:[UIImage imageNamed:DELETE_BTN] forState:UIControlStateNormal];
        [editBtn setImage:[UIImage imageNamed:EDIT_BTN] forState:UIControlStateNormal];
        
        [deleteBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [editBtn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        editBtn.tag = editBtn_infoCell_type;
        deleteBtn.tag = deleteBtn_infoCell_type;
    }
    return self;
}

- (void)BtnClick:(UIButton *)btn{
    NSLog(@"%s",__func__);
    if (self.deleteBtnOreditBtn) {
        self.deleteBtnOreditBtn(self.data,btn.tag);
    }
}
- (void)setData:(id )data{
    _data = data;
    if ([data isKindOfClass:[passengerInfos_one class]]) {
        passengerInfos_one *tmp = data;
        self.name.text = tmp.name;
        
        NSMutableAttributedString *All = [NSMutableAttributedString new];
        NSInteger allNum = 0;
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:PingFangSC_Regular(15),NSFontAttributeName,ColorWithHex(0x2D2D2D, 0.8),NSForegroundColorAttributeName, nil];
        NSMutableAttributedString *text = [NSMutableAttributedString new];
        NSString *str = [NSString stringWithFormat:@"%@ %@",tmp.surname?[tmp.surname uppercaseString]:@"",tmp.enName?[tmp.enName uppercaseString]:@""];
        str = [str stringByAppendingString:@"\n"];
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:str attributes:dic]];
        text.yy_paragraphSpacing = 5;
        [All appendAttributedString:text];
        
        for (certInfos_one *one in tmp.Arry_certInfos) {
            if (one.certType && one.certType.length && one.certNo && one.certNo.length ) {
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:PingFangSC_Regular(12),NSFontAttributeName,ColorWithHex(0x2D2D2D, 0.8),NSForegroundColorAttributeName, nil];
                NSMutableAttributedString *text = [NSMutableAttributedString new];
                NSString *certType = @"";
                if ([one.certType isEqualToString:PASSENGER_TYPE_NI]) {
                    certType = [NSString stringWithFormat:@"%@   ",NSLocalizedString(@"ID", @"ID")];
                } else if ([one.certType isEqualToString:PASSENGER_TYPE_P]) {
                    certType = [NSString stringWithFormat:@"%@   ",NSLocalizedString(@"passport", @"passport")];
                } else if ([one.certType isEqualToString:PASSENGER_TYPE_ID]) {
                    certType = [NSString stringWithFormat:@"%@   ",NSLocalizedString(@"Other", @"Other")];
                }
                NSString *str = [NSString stringWithFormat:@"%@%@",certType,one.certNo];
                if (allNum != (tmp.Arry_certInfos.count - 1)) {
                    str = [str stringByAppendingString:@"\n"];
                }
                [text appendAttributedString:[[NSAttributedString alloc] initWithString:str attributes:dic]];
                if (allNum != (tmp.Arry_certInfos.count - 1)) {
                    text.yy_paragraphSpacing = 5;
                }
                [All appendAttributedString:text];
            }
            allNum++;
        }
        self.detail.attributedText = All;
    } else if ([data isKindOfClass:[contactInfos_one class]]) {
        contactInfos_one *tmp = data;
        self.name.text = tmp.name;
        
        NSMutableAttributedString *All = [NSMutableAttributedString new];
        if (tmp.mobile && tmp.mobile.length) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:PingFangSC_Regular(15),NSFontAttributeName,ColorWithHex(0x2D2D2D, 1.0),NSForegroundColorAttributeName, nil];
            NSMutableAttributedString *text = [NSMutableAttributedString new];
            NSString *str = [tmp.mobile copy];
            if (tmp.email && tmp.email.length) {
                str = [str stringByAppendingString:@"\n"];
            }
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:str attributes:dic]];
            if (tmp.email && tmp.email.length) {
                text.yy_paragraphSpacing = 5;
            }
            [All appendAttributedString:text];
        }
        if (tmp.email && tmp.email.length) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:PingFangSC_Regular(12),NSFontAttributeName,ColorWithHex(0x2D2D2D, 0.8),NSForegroundColorAttributeName, nil];
            NSMutableAttributedString *text = [NSMutableAttributedString new];
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:tmp.email attributes:dic]];
            [All appendAttributedString:text];
        }
        self.detail.attributedText = All;
    } else if ([data isKindOfClass:[addressInfos_one class]]) {
        addressInfos_one *tmp = data;
        self.name.text = tmp.receiverName;
        
        NSMutableAttributedString *All = [NSMutableAttributedString new];
        if (tmp.receiverMobile && tmp.receiverMobile.length) {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:PingFangSC_Regular(15),NSFontAttributeName,ColorWithHex(0x2D2D2D, 1.0),NSForegroundColorAttributeName,NSParagraphStyleAttributeName,paragraphStyle, nil];

            NSMutableAttributedString *text = [NSMutableAttributedString new];
            NSString *str = [tmp.receiverMobile copy];
            if ((tmp.province && tmp.province.length) || (tmp.city && tmp.city.length) ||  (tmp.area && tmp.area.length) || (tmp.detailAddress && tmp.detailAddress.length) || (tmp.postCode && tmp.postCode.length))  {
                str = [str stringByAppendingString:@"\n"];
            }
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:str attributes:dic]];
            if ((tmp.province && tmp.province.length) || (tmp.city && tmp.city.length) ||  (tmp.area && tmp.area.length) || (tmp.detailAddress && tmp.detailAddress.length) || (tmp.postCode && tmp.postCode.length)) {
                text.yy_paragraphSpacing = 5;
            }
            [All appendAttributedString:text];
        }
        
        if ((tmp.province && tmp.province.length) || (tmp.city && tmp.city.length) ||  (tmp.area && tmp.area.length) || (tmp.detailAddress && tmp.detailAddress.length)) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:PingFangSC_Regular(12),NSFontAttributeName,ColorWithHex(0x2D2D2D, 0.8),NSForegroundColorAttributeName, nil];
            NSMutableAttributedString *text = [NSMutableAttributedString new];
            NSString *str;
            if (tmp.province && tmp.province.length) {
                str = tmp.province;
            }
            if (tmp.city && tmp.city.length) {
                str = [str stringByAppendingString:tmp.city];
            }
            if (tmp.area && tmp.area.length) {
                str = [str stringByAppendingString:tmp.area];
            }
            if (tmp.detailAddress && tmp.detailAddress.length) {
                str = [str stringByAppendingString:tmp.detailAddress];
            }
            if (tmp.postCode && tmp.postCode.length) {
                str = [str stringByAppendingString:@"\n"];
            }
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:str attributes:dic]];
            if (tmp.postCode && tmp.postCode.length) {
                text.yy_paragraphSpacing = 5;
            }
            [All appendAttributedString:text];
        }
        if (tmp.postCode && tmp.postCode.length) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:PingFangSC_Regular(12),NSFontAttributeName,ColorWithHex(0x2D2D2D, 0.8),NSForegroundColorAttributeName, nil];
            NSMutableAttributedString *text = [NSMutableAttributedString new];
            [text appendAttributedString:[[NSAttributedString alloc] initWithString:tmp.postCode attributes:dic]];
            [All appendAttributedString:text];
        }
        self.detail.attributedText = All;
    }
}

- (NSString *)setCountyNameWith:(NSString *)nationalityCode{
    for (NSDictionary *dicAll in self.countyArray) {
        NSArray *key = [dicAll allKeys];
        if (key.count) {
            NSArray *tmp = dicAll[[key firstObject]];
            for (NSDictionary *dic in tmp) {
                NSLog(@"dic[KEY_COUNTRYCODE]=%@",dic[KEY_COUNTRYCODE]);
                if ([nationalityCode isEqualToString:dic[KEY_COUNTRYCODE]]) {
                    return dic[KEY_COUNTRYNAME];
                    break;
                }
            }
        }
    }
    return @"";
}
@end
