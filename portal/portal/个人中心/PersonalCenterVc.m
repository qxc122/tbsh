//
//  PersonalCenterVc.m
//  portal
//
//  Created by Store on 2017/9/5.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "PersonalCenterVc.h"
#import "PersonalCenterCell.h"
#import "ModifyNicknameVc.h"
#import "MembershipLevelVc.h"
#import "PortalHelper.h"
#import "ChangeHeadVc.h"
#import "MACRO_NOTICE.h"

@interface PersonalCenterVc ()<MWPhotoBrowserDelegate>
@property (nonatomic,strong) ChangeHeadVc* browser;
@property (nonatomic,strong) id imageResouce;
@end

@implementation PersonalCenterVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = VIEW_BACKGROUND_COLOR;
    self.tableView.contentInset = UIEdgeInsetsMake(HEIGHT_NAVBAR, 0, 0, 0);
    [self.tableView registerClass:[PersonalCenterCell class] forCellReuseIdentifier:NSStringFromClass([PersonalCenterCell class])];

    if (self.data) {
        self.empty_type = succes_empty_num;
        self.header.hidden = YES;
    } else {
        [self.header beginRefreshing];
    }
    self.title = NSLocalizedString(@"Personal Center", @"Personal Center");

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(CHANGE_NAME_NOTIFICATIONFunc:)
                                                 name:CHANGE_NAME_NOTIFICATION
                                               object:nil];
}

- (void)CHANGE_NAME_NOTIFICATIONFunc:(NSNotification *)user{
    self.data = [PortalHelper sharedInstance].userInfo;
    [self.tableView reloadData];
}
#pragma --mark<登录退出的通知>
- (void)LOGIN_EXIT_NOTIFICATIONFunC:(NSNotification *)user{
    if (![PortalHelper sharedInstance].userInfo && [self.navigationController.topViewController isEqual:self]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)loadNewData{
    kWeakSelf(self);
    [[ToolRequest sharedInstance]usermyInfosuccess:^(id dataDict, NSString *msg, NSInteger code) {
        weakself.data = [UserInfo mj_objectWithKeyValues:dataDict];
        [weakself loadNewDataEndHeadsuccessSet:nil code:code footerIsShow:NO hasMore:nil];
#ifdef DEBUG
        NSString *strTmp = [dataDict DicToJsonstr];
        NSLog(@"strTmp=%@",strTmp);
#endif
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"sdf");
        [weakself loadNewDataEndHeadfailureSet:nil errorCode:errorCode];
    }];
}

#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([PersonalCenterCell class]) configuration:^(PersonalCenterCell *cell) {
        [weakself configurePersonalCenterCell:cell atIndexPath:indexPath];
    }];
}

#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalCenterCell *cell = [PersonalCenterCell returnCellWith:tableView];
    [self configurePersonalCenterCell:cell atIndexPath:indexPath];
    return  cell;
}

#pragma --mark< 配置HomeVcCell 的数据>
- (void)configurePersonalCenterCell:(PersonalCenterCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.data = self.data;
    kWeakSelf(self);
    cell.GoToEditThePersonalInfo = ^(NSString *Identifier) {
        if ([Identifier isEqualToString:IconMoreBtnIdentifier]) {
            [weakself openChangeHeadVc];
        } else if ([Identifier isEqualToString:nikeNameMoreBtnIdentifier]) {
            [weakself openModifyNicknameVc];
        } else if ([Identifier isEqualToString:MemberMoreBtnIdentifier]) {
            [weakself openMembershipLevelVc];
        } else if ([Identifier isEqualToString:ExitBtnIdentifier]) {
            [weakself exitSelf];
        }
    };
}

#pragma -mark<打开 修改头像 控制器>
- (void)openChangeHeadVc{
    ChangeHeadVc *browser = [[ChangeHeadVc alloc] initWithDelegate:self];
    self.browser = browser;
    
    // Set options
    //    browser.CusBackColor = [UIColor whiteColor];
    browser.displayActionButton = NO; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = YES; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = NO; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    
    browser.data = self.data;
    kWeakSelf(self);
    browser.returnImage = ^(id image) {
        weakself.imageResouce = image;
        weakself.browser.IsItACroppedPicture = YES;
        [weakself.browser reloadData];
    };
    // Customise selection images to change colours if required
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:0];
    UINavigationController *photoNavigationController = [[UINavigationController alloc] initWithRootViewController:browser];
    photoNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:photoNavigationController animated:YES completion:nil];
}


#pragma -mark<退出登陆>
- (void)exitSelf{
    kWeakSelf(self);
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Drop out...", @"Drop out...") toView:self.view];
    [[ToolRequest sharedInstance]userlogoutssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:NSLocalizedString(@"Quit successfully", @"Quit successfully")];
        [weakself.navigationController popToRootViewControllerAnimated:YES];

        [PortalHelper sharedInstance].userInfo = nil;
        NSNotification *notification =[NSNotification notificationWithName:LOGIN_EXIT_NOTIFICATION object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
        
    }];
}

#pragma -mark<打开 修改昵称 控制器>
- (void)openModifyNicknameVc{
    ModifyNicknameVc *vc = [ModifyNicknameVc new];
    vc.data = self.data;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma -mark<打开 会员等级 控制器>
- (void)openMembershipLevelVc{
    MembershipLevelVc *vc = [MembershipLevelVc new];
    vc.data = self.data;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


#pragma --mark<SDCycleScrollViewDelegate  照片浏览器的回调   有多少个>
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return 1;
}
#pragma --mark<SDCycleScrollViewDelegate  照片浏览器的回调  每个MWPhoto>
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    MWPhoto *oen;
    if (self.imageResouce) {
        if ([self.imageResouce isKindOfClass:[UIImage class]]) {
            oen = [[MWPhoto alloc]initWithImage:self.imageResouce];
        } else if ([self.imageResouce isKindOfClass:[PHAsset class]]) {
            oen = [[MWPhoto alloc]initWithAsset:self.imageResouce targetSize:CGSizeMake(SCREENWIDTH*[[UIScreen mainScreen] scale], SCREENWIDTH*[[UIScreen mainScreen] scale])];
        }
    } else {
        if (self.data.headUrl) {
            oen = [[MWPhoto alloc]initWithURL:self.data.headUrl];
        }
    }
    if (!oen) {
        oen = [[MWPhoto alloc]initWithURL:[NSURL URLWithString:@"https://gss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/5882b2b7d0a20cf46144dddf7d094b36adaf99dd.jpg"]];
        
//        oen = [[MWPhoto alloc]initWithImage:[UIImage imageNamed:SD_HEAD_ALTERNATIVE_PICTURES]];
    }
    return oen;
}

- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index{
    NSString *title;
    if (self.browser.IsItACroppedPicture) {
        title = NSLocalizedString(@"Cut", @"Cut");
    } else {
        title = NSLocalizedString(@"Set Avatar", @"Set Avatar");
    }
    return  title;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
