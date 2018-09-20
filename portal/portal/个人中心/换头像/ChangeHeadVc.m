//
//  ChangeHeadVc.m
//  portal
//
//  Created by Store on 2017/9/6.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "ChangeHeadVc.h"
#import "MWPhotoBrowserPrivate.h"
#import "DACircularProgressView.h"
#import "sysPhto.h"
#import "UIImageView+Add.h"
#import "PortalHelper.h"
#import "AlertAction.h"
#import "AlertView.h"
#define PADDINGMy                  10.0 //覆盖 PADDING

@interface ChangeHeadVc ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,weak) UIImageView  *imageView;
@property (nonatomic,strong) UIColor *backColor; //背景颜色
@property (nonatomic,assign) BOOL isChoosePhotos; //默认否
@end

@implementation ChangeHeadVc

- (void)viewDidLoad {
    self.enableSwipeToDismiss = NO;//取消上滑 和 下滑
    self.backColor = [UIColor whiteColor];
    [super viewDidLoad];
    
    [self SetChangeHeadVcUI];
    [self CusBackcolor];

}

#pragma --mark<设置 控制器的背景颜色>
- (void)CusBackcolor{
    for (UIView *tmp in self.view.subviews) {
        if ([tmp isKindOfClass:[UIScrollView class]]) {
            tmp.backgroundColor = self.backColor;
        }
    }
}
- (void)SetChangeHeadVcUI{

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem  alloc]initWithImage:[UIImage imageNamed:NAVIGATION_BAR_RETURN_BUTTONP] style:UIBarButtonItemStylePlain target:self action:@selector(backBtn)];;
    [self setRightBtn];
    // 1.2设置所有导航条的标题颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[NSFontAttributeName] = PingFangSC_Regular(17);
    md[NSForegroundColorAttributeName] = ColorWithHex(0x2D2D2D, 1.0);
    [navBar setTitleTextAttributes:md];
    
    UIButton  *back = [[UIButton alloc] init];
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(HEIGHT_NAVBAR);
        make.bottom.equalTo(self.view);
    }];
    back.backgroundColor = [UIColor whiteColor];
    [self.view sendSubviewToBack:back];
    
    UIImageView  *imageView = [[UIImageView alloc] init];
    self.imageView  =imageView;
    imageView.alpha = 0.5;
    [imageView setImage:ImageNamed(HEAD_COVER_PLATE)];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(0.5*HEIGHT_NAVBAR);
        make.height.equalTo(self.view.mas_width);
    }];
}
- (void)setRightBtn{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem  alloc]initWithImage:[UIImage imageNamed:SHARE_BLACK_PICTURES] style:UIBarButtonItemStylePlain target:self action:@selector(SelecetImage)];
}
- (void)SelecetImage{
    AlertView *alertView = [AlertView popoverView];
    alertView.backgroundColor=[UIColor clearColor];
    alertView.showShade = YES; // 显示阴影背景
    [alertView showWithActions:[self selectActions]];
}
- (void)backBtn{
    [self dimissSelf];
}

- (void)toggleControls {
    
}
#pragma --mark<图片显示的区域>
- (CGRect)frameForPagingScrollView {
    return CGRectMake(-PADDINGMy, (SCREENHEIGHT-SCREENWIDTH-HEIGHT_NAVBAR)*0.5+HEIGHT_NAVBAR, SCREENWIDTH+2*PADDINGMy, SCREENWIDTH);
}

- (void)setNavBarAppearance:(BOOL)animated {
    //    [self.navigationController setNavigationBarHidden:NO animated:animated];
    //    UINavigationBar *navBar = self.navigationController.navigationBar;
    //    navBar.tintColor = [UIColor whiteColor];
    //    navBar.barTintColor = nil;
    //    navBar.shadowImage = nil;
    //    navBar.translucent = YES;
    //    navBar.barStyle = UIBarStyleBlackTranslucent;
    //    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //    [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsLandscapePhone];
}

#pragma --mark<修复只有一张图片的时候 无标题>
- (void)updateNavigation {
    [super updateNavigation];
    if ([self numberOfPhotos]==1) {
        if ([self.delegate respondsToSelector:@selector(photoBrowser:titleForPhotoAtIndex:)]) {
            self.title = [self.delegate photoBrowser:self titleForPhotoAtIndex:self.currentIndex];
        }
    }
}

#pragma --mark<修复控件的背景颜色>
- (void)configurePage:(MWZoomingScrollView *)page forIndex:(NSUInteger)index {
    [super configurePage:page forIndex:index];
    if (self.backColor) {
        NSInteger all = 0;
        for (UIView* tmp in page.subviews)
        {
            if ([tmp isKindOfClass:[MWTapDetectingView class]]) {
                tmp.backgroundColor = self.backColor;
                all++;
            }else if ([tmp isKindOfClass:[DACircularProgressView class]]) {
                DACircularProgressView *progress = (DACircularProgressView *)tmp;
                progress.trackTintColor = [UIColor grayColor];
                progress.progressTintColor = RGBACOLOR(255, 107, 78, 1.0);
                all++;
            }
            if (all==2) {
                break;
            }
        }
    }
}
- (void)performLayout {
    [super performLayout];
    if (self.IsItACroppedPicture) {
        [self setRightOkBtn];
    } else {
        [self setRightBtn];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[PortalHelper sharedInstance]photoSHouquan];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)setIsItACroppedPicture:(BOOL)IsItACroppedPicture{
    _IsItACroppedPicture = IsItACroppedPicture;
    if (IsItACroppedPicture) {
        [self setRightOkBtn];
    }
}
- (void)setRightOkBtn{
    self.navigationItem.rightBarButtonItem = nil;
    UIButton *okBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [okBtn setTitle:NSLocalizedString(@"Preservation", @"Preservation") forState:UIControlStateNormal];
    [okBtn setTitleColor:ColorWithHex(0x4EA2FF , 1.0) forState:UIControlStateNormal];
    okBtn.titleLabel.font = PingFangSC_Regular(17);
    [okBtn addTarget:self action:@selector(okBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:okBtn];
}
#pragma --mark<保存了头像>
- (void)okBtnClick:(UIButton *)btn{
    self.imageView.hidden = YES;
    UIImage *res = [self.imageView GetScreenShotWithScreen:self.view];
    kWeakSelf(self);
    [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Submission...", @"Submission...") toView:self.view];
    [[ToolRequest sharedInstance]appuserupdateWithAvtor:res progress:^(NSProgress *uploadProgress) {
//        [MBProgressHUD hideHUDForView:weakself.view];
        
    } success:^(id dataDict, NSString *msg, NSInteger code) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:NSLocalizedString(@"Submit successfully", @"Submit successfully") toView:weakself.view];
        UserInfo *tmp = [UserInfo mj_objectWithKeyValues:dataDict];
        
        UserInfo *date = [PortalHelper sharedInstance].userInfo;
        date.headUrl = tmp.headUrl;
        [PortalHelper sharedInstance].userInfo = date;
        
        NSNotification *notification =[NSNotification notificationWithName:CHANGE_NAME_NOTIFICATION object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [weakself performSelector:@selector(dimissSelf) withObject:nil afterDelay:MANY_SECONDS];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD hideHUDForView:weakself.view];
        [MBProgressHUD showPrompt:msg toView:weakself.view];
    }];
    self.imageView.hidden = NO;
    
}

- (void)dimissSelf{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSMutableArray<AlertAction *> *)selectActions {
    // 全部支付 action
    AlertAction *allPayAction = [AlertAction actionWithImage:[UIImage imageNamed:@"selcetShape"] title:NSLocalizedString(@"Select from album", @"Select from album") handler:^(AlertAction *action) {
        [self OpensysPhtoVc];
    }];
    // 快捷支付 action
    AlertAction *fastAction = [AlertAction actionWithImage:[UIImage imageNamed:@"selcetShape"] title:NSLocalizedString(@"Photograph", @"Photograph") handler:^(AlertAction *action) {
        [self openCamera];
    }];
    // 取消
    AlertAction *cancelAction = [AlertAction actionWithTitle:NSLocalizedString(@"cancel", @"cancel") handler:^(AlertAction *action) {
  
    }];
    NSArray *section1 =@[allPayAction, fastAction];
    NSArray *section2 =@[cancelAction];
    AlertAction *alert=[[AlertAction alloc]init];
    alert.selectRow = 3;
    NSMutableArray *actionArr=[NSMutableArray arrayWithObjects:section1, section2,alert, nil];
    return actionArr;
}

- (void)OpensysPhtoVc{
    sysPhto *vc = [sysPhto new];
    kWeakSelf(self);
    vc.returnImage = ^(id image) {
        if (weakself.returnImage) {
            weakself.returnImage(image);
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma --mark<打开照相机>
/**
 
 *  调用照相机
 
 */
- (void)openCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES; //可编辑
    //判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        [MBProgressHUD showPrompt:NSLocalizedString(@"Change device does not support camera", @"Change device does not support camera") toView:self.view];
    }
}

#pragma mark - UIImagePickerControllerDelegate
// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        if(image && self.returnImage){
            self.returnImage(image);
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
