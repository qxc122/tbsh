//
//  sysPhto.m
//  TourismT
//
//  Created by Store on 16/12/28.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "sysPhto.h"
#import "SuPhotoManager.h"
#import "sysphoCell.h"
#import "PortalHelper.h"


@interface sysPhto ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *images; //总的资源
@property (nonatomic, weak) UICollectionView * collectionView;
@end

@implementation sysPhto

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images = [NSMutableArray array];
    [self getXiangChen];
    self.title = NSLocalizedString(@"Select photos", @"Select photos");
    
}

- (void)getXiangChen{
    kWeakSelf(self);
    [weakself.images removeAllObjects];
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Read album...", @"Read album...") toView:self.view];
    [[PortalHelper sharedInstance]photoSHouquanOKsuccess:^{
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        weakself.images = [[[SuPhotoManager manager]fetchAllAssets]mutableCopy];
        [weakself setUi];
    } failure:^{
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [weakself popSelf];
    }];
}

- (void)setUi{
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc]init];
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayOut];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[sysphoCell class] forCellWithReuseIdentifier:NSStringFromClass([sysphoCell class])];

    [self setDZNEmptyDelegate:collectionView];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    collectionView.contentInset = UIEdgeInsetsMake(HEIGHT_NAVBAR+5, 0, 5, 0);
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}


#pragma --mark----UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    sysphoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([sysphoCell class]) forIndexPath:indexPath];
    cell.imageResouce =self.images[indexPath.row];
    return cell;
}


#pragma mark----UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREENWIDTH-5.0*3)/4.0,(SCREENWIDTH-15)/4.0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.0;
}

#pragma --mark UICollectionView Delegate
#pragma --mark<点击了一个cell>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.returnImage) {
        self.returnImage(self.images[indexPath.row]);
        [self popSelf];
    }
}
@end
