//
//  TourismCell.m
//  portal
//
//  Created by Store on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "TourismCell.h"
#import "TourismCoCell.h"
#import "UIImageView+Add.h"

@interface TourismCell ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,weak) UIImageView *titleImage;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UIView *line;
@property (nonatomic,weak) UIView *lineBottom;
@end

@implementation TourismCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    TourismCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[TourismCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *titleImage = [UIImageView new];
        self.titleImage = titleImage;
        [self.contentView addSubview:titleImage];
        
        UILabel *title = [UILabel new];
        self.title = title;
        [self.contentView addSubview:title];
        
        UIView *line = [UIView new];
        self.line = line;
        [self.contentView addSubview:line];
        
        
        UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc]init];
        flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayOut];
        self.collectionView = collectionView;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.contentInset = UIEdgeInsetsMake(15, 10, 15, 10);
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerClass:[TourismCoCell class] forCellWithReuseIdentifier:NSStringFromClass([TourismCoCell class])];
        [self.contentView addSubview:collectionView];
        
        UIView *lineBottom = [UIView new];
        self.lineBottom = lineBottom;
        [self.contentView addSubview:lineBottom];
        
        [titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.title);
            make.height.equalTo(@(16));
            make.width.equalTo(@(16));
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleImage.mas_right).offset(5);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(line.mas_top);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(46);
            make.height.equalTo(@0.5);
        }];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.line.mas_bottom);
            make.height.equalTo(@(100.0*PROPORTION_HEIGHT+30+32));
        }];
        [lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.collectionView.mas_bottom);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@10);
        }];
        title.font = PingFangSC_Regular(16);
        title.textColor = ColorWithHex(0x2D2D2D, 1.0);
        
        [titleImage SetContentModeScaleAspectFill];
        titleImage.image = [UIImage imageNamed:TOUR_STAGING_ICON];
        title.text  =NSLocalizedString(@"Tourism staging", @"Tourism staging");
        line.backgroundColor = GENERAL_GREY_COLOR;
        lineBottom.backgroundColor = VIEW_BACKGROUND_COLOR;
    }
    return self;
}


#pragma mark--<点击了cell>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.SelectIndex) {
        self.SelectIndex(self.Arry_tourProductList[indexPath.row]);
    }
}


#pragma mark----UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.Arry_tourProductList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TourismCoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TourismCoCell class]) forIndexPath:indexPath];
    cell.data = self.Arry_tourProductList[indexPath.row];
    return cell;
}
#pragma mark----UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150.0*PROPORTION_WIDTH,100.0*PROPORTION_HEIGHT+32);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}
- (void)setArry_tourProductList:(NSArray *)Arry_tourProductList{
    _Arry_tourProductList = Arry_tourProductList;
    [self.collectionView reloadData];
}

@end
