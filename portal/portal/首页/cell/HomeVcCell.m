//
//  HomeVcCell.m
//  portal
//
//  Created by Store on 2017/8/31.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "HomeVcCell.h"
#import "HomeVcCoCell.h"
#import "PortalHelper.h"

@interface HomeVcCell ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,weak) UIImageView *backImg;
@end

@implementation HomeVcCell
+ (instancetype)returnCellWith:(UITableView *)tableView
{
    HomeVcCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[HomeVcCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIImageView *backImg = [UIImageView new];
        self.backImg = backImg;
        [self.contentView addSubview:backImg];
        
        
        UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc]init];
        flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayOut];
        self.collectionView = collectionView;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerClass:[HomeVcCoCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeVcCoCell class])];
        [self.contentView addSubview:collectionView];
        
        [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(@(SCREENHEIGHT));
        }];
        
        
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-49*PROPORTION_HEIGHT);
            make.height.equalTo(@(2.0*100.0*PROPORTION_HEIGHT+11.0));
        }];
        
        //set
        [backImg SetContentModeScaleAspectFill];
        [self.backImg sd_setImageWithURL:[PortalHelper sharedInstance].globalParameter.backgroundImg placeholderImage:[UIImage imageNamed:HOME_BACKGROUND_MAP]];
    }
    return self;
}


//- (void)setRow:(NSInteger)Row{
//    _Row = Row;
//    [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:Row inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
//}

#pragma mark--<点击了cell>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.SelectIndex) {
        self.SelectIndex(self.data.Arry_merchList[indexPath.row]);
    }
}


#pragma mark----UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.Arry_merchList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeVcCoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeVcCoCell class]) forIndexPath:indexPath];
    cell.data = self.data.Arry_merchList[indexPath.row];
    return cell;
}
#pragma mark----UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(150.0*PROPORTION_WIDTH,100.0*PROPORTION_HEIGHT);
}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsZero;
//}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}
- (void)setData:(HomeData *)data{
    _data = data;
    [self.collectionView reloadData];
}
@end
