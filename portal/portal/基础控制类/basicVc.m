//
//  basicVc.m
//  Tourism
//
//  Created by Store on 16/11/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "basicVc.h"
#import "AFNetworkReachabilityManager.h"
#import "LoginRegis.h"
#import "basicUiTableView.h"
#import "CashierVc.h"
#import "NSString+Add.h"
@interface basicVc ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end


@implementation basicVc
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBar];
    [self customBackButton];
    self.view.backgroundColor = RGBACOLOR(255, 255, 255, 1);
    self.empty_type = In_loading_empty_num;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(LOGIN_EXIT_NOTIFICATIONFunC:)
                                                 name:LOGIN_EXIT_NOTIFICATION
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(GET_NEW_TOKEN_NOTIFICATIONFunc:)
                                                 name:GET_NEW_TOKEN_NOTIFICATION
                                               object:nil];
}

- (void)GET_NEW_TOKEN_NOTIFICATIONFunc:(NSNotification *)user{
    self.FLAG_IN_DATA_UPDATE = YES;
    [self loadNewData];
}

#pragma --mark<登录退出的通知>
- (void)LOGIN_EXIT_NOTIFICATIONFunC:(NSNotification *)user{   
    self.FLAG_IN_DATA_UPDATE = YES;
    [self loadNewData];
    if (![PortalHelper sharedInstance].userInfo && [self.navigationController.topViewController isEqual:self]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


- (void)customNavigationBar
{
    // 1.2设置所有导航条的标题颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[NSFontAttributeName] = PingFangSC_Regular(17);
    md[NSForegroundColorAttributeName] = ColorWithHex(0x2D2D2D, 1.0);
    [navBar setTitleTextAttributes:md]; 
}

- (void)customBackButton
{
    UIImage* image = [[UIImage imageNamed:NAVIGATION_BAR_RETURN_BUTTONP] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem* leftBarutton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    self.navigationItem.leftBarButtonItem = leftBarutton;
}
- (void)setDZNEmptyDelegate:(id)TabOrColl{
    if ([TabOrColl isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)TabOrColl;
        tableView.emptyDataSetSource = self;
        tableView.emptyDataSetDelegate = self;
    }else if ([TabOrColl isKindOfClass:[UICollectionView class]]) {
        UICollectionView *colobleView = (UICollectionView *)TabOrColl;
        colobleView.emptyDataSetSource = self;
        colobleView.emptyDataSetDelegate = self;
    }
}

- (void)popSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self hideBottomBarWhenPush];
        self.NodataTitle = NSLocalizedString(@"No data", @"No data");
        self.NodataDescribe = @" ";
    }
    return self;
}
- (void)hideBottomBarWhenPush
{
    self.hidesBottomBarWhenPushed = YES;
}

#pragma -mark<mj_header  头部>
- (MJRefreshHeader *)header{
    if (!_header) {
//        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//        [header setImages:@[[UIImage imageNamed:@"type1"],[UIImage imageNamed:@"type2"],[UIImage imageNamed:@"type3"],[UIImage imageNamed:@"type4"]] forState:MJRefreshStateIdle];
//        // Set the pulling state of animated images（Enter the status of refreshing as soon as loosen）
//        [header setImages:@[[UIImage imageNamed:@"type1"],[UIImage imageNamed:@"type2"],[UIImage imageNamed:@"type3"],[UIImage imageNamed:@"type4"]] forState:MJRefreshStatePulling];
//        // Set the refreshing state of animated images
//        [header setImages:@[[UIImage imageNamed:@"type1"],[UIImage imageNamed:@"type2"],[UIImage imageNamed:@"type3"],[UIImage imageNamed:@"type4"]] forState:MJRefreshStateRefreshing];
//        
//        // Hide the time
//        header.lastUpdatedTimeLabel.hidden = YES;
//        
//        // Hide the status
//        header.stateLabel.hidden = YES;
//        // Set header
//        
//        _header = header;
        
        MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _header = header;
    }
    return _header;
}

#pragma -mark<加载新数据>
- (void)loadNewData{
    
}
#pragma -mark<加载更多数据>
- (void)loadMoreData{
    
}

#pragma -mark<mj_footer  头部>
- (MJRefreshFooter *)footer{
    if (!_footer) {
        MJRefreshFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        _footer = footer;
    }
    return _footer;
}

#pragma --mark<打开登录页面>
- (void)openLoginView:(LoginSuccess)block{
    LoginRegis *losgin = [[LoginRegis alloc]init];
    losgin.Successblock = block;
//    UINavigationController *nnvc = [[UINavigationController alloc]initWithRootViewController:losgin];
//    [self presentViewController:nnvc animated:YES completion:nil];
        [self.navigationController pushViewController:losgin animated:YES];
}
#pragma --mark<打开登录页面>
- (void)openLoginViewisCacel:(LoginSuccessWithStaue)block{
    LoginRegis *losgin = [[LoginRegis alloc]init];
    losgin.blockWithStaue = block;
//    UINavigationController *nnvc = [[UINavigationController alloc]initWithRootViewController:losgin];;
//    [self presentViewController:nnvc animated:YES completion:nil];
    
    [self.navigationController pushViewController:losgin animated:YES];
}
#pragma --mark<打开 支付 页面>
- (void)openCashierVcWithData:(id)data block:(LoginSuccess)block{
    CashierVc *vc = [CashierVc new];
    vc.data = data;
    vc.Successblock = block;
//    UINavigationController *nnvc = [[UINavigationController alloc]initWithRootViewController:vc];
//    [self presentViewController:nnvc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}



//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    if (self.isNeedRefreth && [self isKindOfClass:[basicUiTableView class]]) {
//        self.isNeedRefreth = NO;
//        self.header.hidden = NO;
//        [self.header beginRefreshing];
//    }
//}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.CTrollersToR.count) {
        NSMutableArray *muArry =[self.navigationController.viewControllers mutableCopy];
        for (UIViewController *vc in self.navigationController.viewControllers) {
            for (Class class in self.CTrollersToR) {
                if ([vc isKindOfClass:class]) {
                    [muArry removeObject:vc];
                    break;
                }
            }
        }
        self.navigationController.viewControllers = muArry;
        self.CTrollersToR = nil;
    }
}

#pragma --<空白页处理>
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.empty_type == succes_empty_num) {
        return [UIImage imageNamed:PIC_NONE_DATA_PLACE];
    } else if (self.empty_type == fail_empty_num) {
        return [UIImage imageNamed:PIC_NONE_NET_PLACE];
    } else if (self.empty_type == NoNetworkConnection_empty_num) {
        return [UIImage imageNamed:PIC_NONE_NET_PLACE];
    }else{
        return [UIImage imageNamed:PIC_NONE_NET_PLACE];
    }
    return nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
   
    if (self.empty_type == NoNetworkConnection_empty_num) {
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"\n%@",NSLocalizedString(@"Your mobile phone has no network connection", @"Your mobile phone has no network connection")] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }if (self.empty_type == NoNetworkConnection_TO_NetworkConnection_empty_num) {
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"\n%@",NSLocalizedString(@"Your mobile phone network connection is normal", @"Your mobile phone network connection is normal")] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }else if (self.empty_type == succes_empty_num){
        
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"\n%@",self.NodataTitle&&self.NodataTitle.length?self.NodataTitle:@" "] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }else{
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"\n%@",NSLocalizedString(@"The server is deserted. Refresh it", @"The server is deserted. Refresh it")] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }
    return nil;
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.empty_type == NoNetworkConnection_empty_num) {
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        [all appendAttributedString:[@"\n\n\n " CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x2D2D2D, 0.3) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0]];
        return all;
    }if (self.empty_type == NoNetworkConnection_TO_NetworkConnection_empty_num) {
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        [all appendAttributedString:[@"\n\n\n " CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x2D2D2D, 0.3) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0]];
        return all;
    }else if (self.empty_type == succes_empty_num){
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"%@\n\n",self.NodataDescribe&&self.NodataDescribe.length?self.NodataDescribe:@" "] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }else{
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        [all appendAttributedString:[@"\n\n\n " CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x2D2D2D, 0.3) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0]];
        return all;
    }
    return nil;
}
//按钮文本或者背景样式
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (self.empty_type == NoNetworkConnection_empty_num) {
        return [NSLocalizedString(@"Check settings", @"Check settings") CreatMutableAttributedStringWithFont:PingFangSC_Regular(16) Color:ColorWithHex(0x4EA2FF, 1.0) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
    }else if (self.empty_type != succes_empty_num){
        return [NSLocalizedString(@"Reload", @"Reload") CreatMutableAttributedStringWithFont:PingFangSC_Regular(16) Color:ColorWithHex(0x4EA2FF, 1.0) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
    }if (self.empty_type == NoNetworkConnection_TO_NetworkConnection_empty_num) {
        return [NSLocalizedString(@"Reload", @"Reload") CreatMutableAttributedStringWithFont:PingFangSC_Regular(16) Color:ColorWithHex(0x4EA2FF, 1.0) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
    }
    return nil;
}
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if(self.empty_type != succes_empty_num || self.empty_type == NoNetworkConnection_empty_num || self.empty_type == NoNetworkConnection_TO_NetworkConnection_empty_num){
        return  [UIImage imageNamed:EMPTY_STATUS_BUTTON_BOX];
    }
    return nil;
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView{
      return CGPointMake(SCREENWIDTH*0.5, 300);
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return 30;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 15.0;
}


//空白页的背景色

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor clearColor];
}

//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    if (self.empty_type == In_loading_empty_num){
        return NO;
    }
    return YES;
}

//空白页点击事件
//- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
//    [self DidTap];
//}

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{
    if (self.empty_type == NoNetworkConnection_empty_num) {
        [self CheckNetWork];
    }else{
        [self DidTap];
    }
}
- (void)CheckNetWork{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}
- (void)DidTap{
    if (self.empty_type != succes_empty_num) {
        if ([AFNetworkReachabilityManager sharedManager].reachable) {
            self.header.hidden = NO;
            [self.header beginRefreshing];
        }
    }
}

#pragma --<友梦分享>
- (void)shareTwoWebPageToPlatformType:(UMSocialPlatformType)platformType withTitle:(NSString *)title withDescr:(NSString *)descr withWebOrImageUrl:(id )WebOrImageUrl withThumImage:(id)thumImage IsImage:(BOOL)IsImage success:(ShareSuccess)successBlock failure:(ShareFailure)failureBlock
{
    if (platformType < UMSocialPlatformType_Predefine_Begin || platformType > UMSocialPlatformType_Predefine_end) {
        failureBlock(NSLocalizedString(@"Illegal sharing platform", @"Illegal sharing platform"));
        return;
    }
    
    if ((platformType == UMSocialPlatformType_WechatTimeLine || platformType == UMSocialPlatformType_WechatSession) && ![[UMSocialManager defaultManager]isInstall:platformType]) {
        failureBlock(NSLocalizedString(@"You did not install the WeChat client", @"You did not install the WeChat client"));
        return;
    }

    if (!title || !title.length) {
        title = NSLocalizedString(@"Living in the country", @"Living in the country");
    }
    if (!descr || !descr.length) {
        descr = NSLocalizedString(@"Living in the country", @"Living in the country");
    }
    
        [MBProgressHUD showLoadingMessage:NSLocalizedString(@"Ready to share!", @"Ready to share!")];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *imageData;
            UIImage *tmp = thumImage;
            if ([thumImage isKindOfClass:[UIImage class]]) {
                
                imageData = UIImageJPEGRepresentation(tmp,0.2);//进行图片压缩
                
                if (!imageData) {
                    imageData = UIImagePNGRepresentation(thumImage);
                }
                
                CGFloat yasou=0.5;
                NSLog(@"原来的大小 imageData.leng=%ld k %@",imageData.length/1024,[NSThread currentThread]);
                while ((imageData.length - 1024*1024) >0) {
                    tmp = thumImage;
                    NSLog(@"太大了 分享  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
                    imageData = UIImageJPEGRepresentation(tmp, yasou);
                    if (imageData.length > 10*1024*1024) {
                        failureBlock(NSLocalizedString(@"The platform does not support sharing more than 10M of images", @"The platform does not support sharing more than 10M of images"));
                        return;
                    } else if (imageData.length > 5*1024*1024){
                        yasou *=0.02;
                    } else if (imageData.length > 4*1024*1024){
                        yasou *=0.06;
                    } else if (imageData.length > 3*1024*1024){
                        yasou *=0.07;
                    } else if (imageData.length > 2*1024*1024){
                        yasou *=0.08;
                    } else {
                        yasou *=0.09;
                    }
                    if (yasou<0.001) {
                        break;
                    }
                    NSLog(@"压小后 分享  imageData.leng=%ld   yasou=%f",imageData.length/(1024*1024),yasou);
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //回调或者说是通知主线程刷新，
                NSLog(@"imageData.leng=%ld k",imageData.length/1024);
                //                if (!imageData.length) {
                //                    thumImage = ImageNamed(place_image_image);
                //                }
                [MBProgressHUD hideHUD];
                
                //创建分享消息对象
                UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
                if (IsImage) {
                    UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:descr thumImage:imageData?imageData:thumImage];
                    shareObject.shareImage = WebOrImageUrl;
                    //分享消息对象设置分享内容对象
                    messageObject.shareObject = shareObject;
                } else {
                    //创建网页内容对象
                    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:imageData?imageData:thumImage];
                    //设置网页地址
                    if ([WebOrImageUrl isKindOfClass:[NSString class]]) {
                        shareObject.webpageUrl = WebOrImageUrl;
                    } else if ([WebOrImageUrl isKindOfClass:[NSURL class]]) {
                        shareObject.webpageUrl = [WebOrImageUrl absoluteString];
                    }
                    //分享消息对象设置分享内容对象
                    messageObject.shareObject = shareObject;
                }
                
                //调用分享接口
                [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                    if (error) {
                        if (error.code == UMSocialPlatformErrorType_Cancel) {
                            failureBlock(NSLocalizedString(@"You cancelled the sharing", @"You cancelled the sharing"));
                        } else {
                            failureBlock(NSLocalizedString(@"Share failure", @"Share failure"));
                        }
                        UMSocialLogInfo(@"************Share fail with error %@*********",error);
                    }else{
                        if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                            UMSocialShareResponse *resp = data;
                            successBlock(NSLocalizedString(@"Share success", @"Share success"));
                            //分享结果消息
                            UMSocialLogInfo(@"response message is %@",resp.message);
                            //第三方原始返回的数据
                            UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                            
                        }else{
                            failureBlock(NSLocalizedString(@"Share failure", @"Share failure"));
                            //                failureBlock([NSString stringWithFormat:@"%@",error]);
                            UMSocialLogInfo(@"response data is %@",data);
                        }
                    }
                }];
            });
            
        });
}

- (void)LoadGlobalParam{
    if ([PortalHelper sharedInstance].token) {
        [[ToolRequest sharedInstance]appgetGlobalParamssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            [PortalHelper sharedInstance].globalParameter = [GlobalParameter mj_objectWithKeyValues:dataDict];
            
//            [PortalHelper sharedInstance].globalParameter.isPassForIOS = @"1";
//            [PortalHelper sharedInstance].globalParameter.isPassForIOSQQ = @"1";
#ifdef DEBUG
            
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
        } failure:^(NSInteger errorCode, NSString *msg) {
            NSLog(@"sdf");
        }];
    }
}

- (void)LoadGlobalParam:(LoadGlobalParam)block{
    if ([PortalHelper sharedInstance].token) {
        [[ToolRequest sharedInstance]appgetGlobalParamssuccess:^(id dataDict, NSString *msg, NSInteger code) {
            [PortalHelper sharedInstance].globalParameter = [GlobalParameter mj_objectWithKeyValues:dataDict];
            
            //            [PortalHelper sharedInstance].globalParameter.isPassForIOS = @"1";
//            [PortalHelper sharedInstance].globalParameter.isPassForIOSQQ = @"1";
            if (block) {
                block();
            }
#ifdef DEBUG
            
            NSString *strTmp = [dataDict DicToJsonstr];
            NSLog(@"strTmp=%@",strTmp);
#endif
        } failure:^(NSInteger errorCode, NSString *msg) {
            NSLog(@"sdf");
        }];
    }
}
@end
