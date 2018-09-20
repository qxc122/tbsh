//
//  SystemSetCell.m
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "SystemSetCell.h"
#import "HeaderAll.h"
#import "PortalHelper.h"
#import "XAlertView.h"
@interface SystemSetCell ()
@property (nonatomic,weak) UIView *top;
@property (nonatomic,weak) UIView *bottom;

@property (nonatomic,weak) UILabel *titleOne1;
@property (nonatomic,weak) UILabel *titleOne;
@property (nonatomic,weak) UIView *line;
@property (nonatomic,weak) UILabel *titleTwo1;
@property (nonatomic,weak) UILabel *titleTwo;


@property (nonatomic,weak) UILabel *ClearCache;
@property (nonatomic,weak) UILabel *CacheSize;
@property (nonatomic,weak) UIButton *ClearCacheBtn;

@property (nonatomic,weak) UISwitch *switch_one;
@property (nonatomic,weak) UISwitch *switch_two;

@end

@implementation SystemSetCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    SystemSetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[SystemSetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        UIView *top = [UIView new];
        [self.contentView addSubview:top];
        self.top = top;

        UILabel *titleOne1 = [UILabel new];
        [self.contentView addSubview:titleOne1];
        self.titleOne1 = titleOne1;
        
        UILabel *titleOne = [UILabel new];
        [self.contentView addSubview:titleOne];
        self.titleOne = titleOne;
        
        UIView *line = [UIView new];
        [self.contentView addSubview:line];
        self.line = line;
        
        UILabel *titleTwo1 = [UILabel new];
        [self.contentView addSubview:titleTwo1];
        self.titleTwo1 = titleTwo1;
        
        UILabel *titleTwo = [UILabel new];
        [self.contentView addSubview:titleTwo];
        self.titleTwo = titleTwo;
        
        
        UIView *bottom = [UIView new];
        [self.contentView addSubview:bottom];
        self.bottom = bottom;
        
        UILabel *ClearCache = [UILabel new];
        [self.contentView addSubview:ClearCache];
        self.ClearCache = ClearCache;
        
        UILabel *CacheSize = [UILabel new];
        [self.contentView addSubview:CacheSize];
        self.CacheSize = CacheSize;
        
        UIButton *ClearCacheBtn = [UIButton new];
        [self.contentView addSubview:ClearCacheBtn];
        self.ClearCacheBtn = ClearCacheBtn;
        
        UISwitch *switch_one = [[UISwitch alloc]initWithFrame:CGRectMake(SCREENWIDTH-51-15, 30, 51, 31)];
        self.switch_one  =switch_one;
        [self.contentView addSubview:switch_one];
        [switch_one addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UISwitch *switch_two = [[UISwitch alloc]initWithFrame:CGRectMake(SCREENWIDTH-51-15, 110, 51, 31)];
        self.switch_two  =switch_two;
        [self.contentView addSubview:switch_two];
        [switch_two addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(10);
        }];
        [titleOne1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line);
            make.right.equalTo(switch_one.mas_left).offset(-15);
            make.top.equalTo(top).offset(20);
        }];
        [titleOne mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line);
            make.right.equalTo(titleOne1);
            make.top.equalTo(titleOne1.mas_bottom).offset(10);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(titleOne.mas_bottom).offset(20);
            make.height.equalTo(@(0.5));
        }];
        [titleTwo1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line);
            make.right.equalTo(titleOne1);
            make.top.equalTo(line.mas_bottom).offset(20);
        }];
        [titleTwo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line);
            make.right.equalTo(titleOne1);
            make.top.equalTo(titleTwo1.mas_bottom).offset(10);
            make.bottom.equalTo(top).offset(-20);
        }];
        
        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(top.mas_bottom).offset(10);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@(55));
        }];
        
        [ClearCache mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line);
            make.centerY.equalTo(bottom);
        }];
        [CacheSize mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(line);
            make.centerY.equalTo(ClearCache);
        }];
        [ClearCacheBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ClearCache);
            make.right.equalTo(CacheSize);
            make.top.equalTo(bottom);
            make.bottom.equalTo(bottom);
        }];
        //set
        titleOne1.numberOfLines = 0;
        titleOne.numberOfLines = 0;
        titleTwo1.numberOfLines = 0;
        titleTwo.numberOfLines = 0;
        
        top.backgroundColor = [UIColor whiteColor];
        bottom.backgroundColor = [UIColor whiteColor];
        line.backgroundColor = GENERAL_GREY_COLOR;
        titleOne1.font = PingFangSC_Regular(15);
        titleOne1.textColor = ColorWithHex(0x2D2D2D, 0.8);
        titleOne.font = PingFangSC_Regular(12);
        titleOne.textColor = ColorWithHex(0x2D2D2D, 0.3);
        
        titleTwo1.font = PingFangSC_Regular(15);
        titleTwo1.textColor = ColorWithHex(0x2D2D2D, 0.8);
        titleTwo.font = PingFangSC_Regular(12);
        titleTwo.textColor = ColorWithHex(0x2D2D2D, 0.3);
        
        ClearCache.font = PingFangSC_Regular(15);
        ClearCache.textColor = ColorWithHex(0x2D2D2D, 0.8);
        CacheSize.font = PingFangSC_Regular(12);
        CacheSize.textColor = ColorWithHex(0x2D2D2D, 0.3);

        [ClearCacheBtn addTarget:self action:@selector(ClearCacheBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        titleOne1.text = NSLocalizedString(@"Message acceptance settings", @"Message acceptance settings");
        titleOne.text = NSLocalizedString(@"After opening, receive various messages push reminders", @"After opening, receive various messages push reminders");
        titleTwo1.text = NSLocalizedString(@"Zero traffic upgrade", @"Zero traffic upgrade");
        titleTwo.text = NSLocalizedString(@"After opening, the Wi-Fi environment automatically download the latest version of the installation package", @"After opening, the Wi-Fi environment automatically download the latest version of the installation package");
        ClearCache.text = NSLocalizedString(@"Clear cache", @"Clear cache");
        
        titleOne1.numberOfLines = 0;
        titleOne.numberOfLines = 0;
        titleTwo1.numberOfLines = 0;
        titleTwo.numberOfLines = 0;
        ClearCache.numberOfLines = 0;
        
        NSInteger tmp = [[SDImageCache sharedImageCache] getSize];
        CacheSize.text = [NSString stringWithFormat:@"%ldM",tmp/(1024*1024)];
        
        setUp *data = [[PortalHelper sharedInstance]getsetUp];
        [self.switch_one setOn:data.ReceiveNotification];
        [self.switch_two setOn:data.AutoUpdate];
    }
    return self;
}

- (void)switchClick:(UISwitch *)btn{
    NSLog(@"%s",__func__);
    setUp *data = [[PortalHelper sharedInstance]getsetUp];
    if ([btn isEqual:self.switch_one]) {
        data.ReceiveNotification =  !data.ReceiveNotification;
    } else if ([btn isEqual:self.switch_two]) {
        data.AutoUpdate =  !data.AutoUpdate;
    }
    [[PortalHelper sharedInstance]setsetUp:data];
}


- (void)ClearCacheBtnClick:(UIButton *)btn{
    kWeakSelf(self);
    NSLog(@"%s",__func__);
    XAlertView *alert = [[XAlertView alloc]initWithTitle:NSLocalizedString(@"提示", @"提示") message:NSLocalizedString(@"你希望清除缓存吗？", @"你希望清除缓存吗？") clickedBlock:^(XAlertView *alertView, BOOL canceled, NSInteger clickedIndex) {
        if (!canceled) {
            [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Clear mid...", @"Clear mid...")];
            [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
                [[SDImageCache sharedImageCache]cleanDiskWithCompletionBlock:^{
                    [MBProgressHUD hideHUD];
                    [MBProgressHUD showPrompt:NSLocalizedString(@"Clear success", @"Clear success")];
                    NSInteger tmp = [[SDImageCache sharedImageCache] getSize];
                    weakself.CacheSize.text = [NSString stringWithFormat:@"%ldM",tmp/(1024*1024)];
                }];
            }];
        }
    } cancelButtonTitle:NSLocalizedString(@"取消", @"取消") otherButtonTitles:NSLocalizedString(@"确定", @"确定"), nil];
    [alert show];

}
@end
