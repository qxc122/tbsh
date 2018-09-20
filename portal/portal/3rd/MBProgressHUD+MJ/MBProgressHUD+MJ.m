//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"


#define show_time 2.0

#define PROMPT_SUCCESS NSLocalizedString(@"Successful operation", @"Successful operation")
#define PROMPT_FAILURE NSLocalizedString(@"operation failed", @"operation failed")
#define PROMPT_LOADING NSLocalizedString(@"In load...", @"In load...")

@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text DetailedText:(NSString *)detailedText icon:(NSString *)icon view:(UIView *)view
{
    
    if (view == nil) view = [UIApplication sharedApplication].delegate.window;
    if (![NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^(){
            // 快速显示一个提示信息
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
            hud.userInteractionEnabled = NO;
//            hud.labelText = [NSString stringWithFormat:@"%@-%@",text,text];;
            hud.detailsLabelText = text;
            if (icon != nil && icon.length!=0) {
                // 设置图片
                hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
                
                // 再设置模式
                hud.mode = MBProgressHUDModeCustomView;
            }else{
                // 再设置模式
                hud.mode = MBProgressHUDModeText;
            }
            if (detailedText != nil && detailedText.length!=0) {
                hud.detailsLabelText = detailedText;
            }
            // 隐藏时候从父控件中移除
            hud.removeFromSuperViewOnHide = YES;
            
            // 1秒之后再消失
            [hud hide:YES afterDelay:show_time];
        });
    }else{
        // 快速显示一个提示信息
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.userInteractionEnabled = NO;
//        hud.labelText = text;
        hud.detailsLabelText = text;
        if (icon != nil && icon.length!=0) {
            // 设置图片
            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
            
            // 再设置模式
            hud.mode = MBProgressHUDModeCustomView;
        }else{
            // 再设置模式
            hud.mode = MBProgressHUDModeText;
        }
        if (detailedText != nil && detailedText.length!=0) {
            hud.detailsLabelText = detailedText;
        }
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        
        // 1秒之后再消失
        [hud hide:YES afterDelay:show_time];
    }
    
//    // 快速显示一个提示信息
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.label.text = text;
//    if (icon != nil && icon.length!=0) {
//        // 设置图片
//        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
//        
//        // 再设置模式
//        hud.mode = MBProgressHUDModeCustomView;
//    }else{
//        // 再设置模式
//        hud.mode = MBProgressHUDModeText;
//    }
//    if (detailedText != nil && detailedText.length!=0) {
//        hud.detailsLabel.text = detailedText;
//    }
//    // 隐藏时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
//    
//    // 1秒之后再消失
//    [hud hideAnimated:YES afterDelay:1.0];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    if (error == nil || error.length < 1) {
        error = PROMPT_FAILURE;
    }
    [self show:error DetailedText:nil icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    if (success == nil || success.length < 1) {
        success = PROMPT_SUCCESS;
    }
    [self show:success  DetailedText:nil icon:@"success.png" view:view];
}

+ (void)showPrompt:(NSString *)prompt toView:(UIView *)view{
    if (prompt != nil && prompt.length >0) {
        [self show:prompt  DetailedText:nil icon:nil view:view];
    }
}

+ (void)showPrompt:(NSString *)prompt  DetailedPrompt:(NSString *)DetailedPrompt toView:(UIView *)view{
    if (prompt != nil && prompt.length >0 && DetailedPrompt != nil && DetailedPrompt.length >0 ) {
        [self show:prompt  DetailedText:DetailedPrompt icon:nil view:view];
    }
}

#pragma mark 显示一些信息
+ (void)showLoadingMessage:(NSString *)message toView:(UIView *)view {
    if (message == nil || message.length < 1) {
        message = PROMPT_LOADING;
    }
    if (view == nil) view = [UIApplication sharedApplication].delegate.window;
    if (![NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^(){
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//            hud.labelText = message;
            hud.detailsLabelText = message;
            // 隐藏时候从父控件中移除
            hud.removeFromSuperViewOnHide = YES;
            // YES代表需要蒙版效果
            //    hud.dimBackground = YES;
            //    return hud;
        });
    }else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//        hud.labelText = message;
        hud.detailsLabelText = message;
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        // YES代表需要蒙版效果
        //    hud.dimBackground = YES;
        //    return hud;
    }
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.label.text = message;
    // 隐藏时候从父控件中移除
//    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    //    hud.dimBackground = YES;
//    return hud;
//    return nil;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil]; 
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (void)showPrompt:(NSString *)prompt{
    [self showPrompt:prompt toView:nil];
}

+ (void)showPrompt:(NSString *)prompt  DetailedPrompt:(NSString *)DetailedPrompt{
   [self showPrompt:prompt DetailedPrompt:DetailedPrompt toView:nil];
}

+ (void)showLoadingMessage:(NSString *)message
{
    [self showLoadingMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].delegate.window;
    if (![NSThread isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^(){
             [self hideHUDForView:view animated:YES];
        });
    }else{
         [self hideHUDForView:view animated:YES];
    }
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
@end
