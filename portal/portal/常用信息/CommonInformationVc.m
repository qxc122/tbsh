//
//  CommonInformationVc.m
//  portal
//
//  Created by Store on 2017/9/4.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "CommonInformationVc.h"
#import "WJItemsControlView.h"
#import "MACRO_UI.h"

#define HEIGHT_itemControlView  57.f
#define HEIGHT_viewLine  0.5

@interface CommonInformationVc ()<UIScrollViewDelegate>
{
    WJItemsControlView *_itemControlView;
}
@end

@implementation CommonInformationVc
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = InformationType_Passenger;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *back = [[UIView alloc]init];
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    back.backgroundColor = [UIColor clearColor];
    
    NSArray *array = @[NSLocalizedString(@"passengers", @"passengers"),NSLocalizedString(@"contacts", @"contacts"),NSLocalizedString(@"address", @"address")];
    //头部控制的segMent
    WJItemsConfig *config = [[WJItemsConfig alloc]init];
    
    config.lineHieght= 2.0;
    config.itemWidth = SCREENWIDTH/3.0;
    config.itemFont = PingFangSC_Regular(16);
    config.selectedColor = ColorWithHex(0x4EA2FF, 1.0);
    config.textColor = ColorWithHex(0x000000, 0.86);
    
    _itemControlView = [[WJItemsControlView alloc]initWithFrame:CGRectMake(0, HEIGHT_NAVBAR, SCREENWIDTH, HEIGHT_itemControlView)];
    _itemControlView.tapAnimation = YES;
    _itemControlView.config = config;
    _itemControlView.titleArray = array;
    

    
    //4页内容的scrollView
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_itemControlView.frame), SCREENWIDTH, SCREENHEIGHT-HEIGHT_itemControlView-HEIGHT_NAVBAR)];
    NSLog(@"SCREENHEIGHT=%f",SCREENHEIGHT);
    [self.view addSubview:scroll];
    scroll.delegate = self;
    scroll.pagingEnabled = YES;
    scroll.bounces = NO;
    scroll.showsVerticalScrollIndicator = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.contentSize = CGSizeMake(SCREENWIDTH*array.count,CGRectGetHeight(scroll.frame));
    for (int i=0; i<array.count; i++) {
        CommonInformationOneVc *vc = [[CommonInformationOneVc alloc]init];
        vc.type = i;
        [self addChildViewController:vc];
        vc.view.frame = CGRectMake(SCREENWIDTH*i, 0, SCREENWIDTH, CGRectGetHeight(scroll.frame));
        [scroll addSubview:vc.view];
    }
    
    __weak typeof (scroll)weakScrollView = scroll;
    [_itemControlView setTapItemWithIndex:^(NSInteger index,BOOL animation){
        [weakScrollView setContentOffset:CGPointMake(index*SCREENWIDTH, 0) animated:YES];
    }];
    [self.view addSubview:_itemControlView];

    
    UIView *viewLine = [[UIView alloc]init];
    [self.view addSubview:viewLine];
    [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@0.5);
        make.bottom.equalTo(scroll.mas_top);
    }];
    viewLine.backgroundColor = GENERAL_GREY_COLOR;
    
    if (self.type != InformationType_Passenger) {
        [_itemControlView moveToIndex:self.type];
        [scroll setContentOffset:CGPointMake(self.type*scroll.contentSize.width/3.0, 0) animated:NO];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.x;
    offset = offset/CGRectGetWidth(scrollView.frame);
    [_itemControlView moveToIndex:offset];
}

@end
