//
//  CommonSingleton.m
//  LZ_Demo
//
//  Created by mac on 16/8/8.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "CommonSingleton.h"

#define SVHUDSTYLE SVProgressHUDStyleDark //黑色
#define SVHUDMASKTYPE SVProgressHUDMaskTypeBlack //蒙层颜色
#define MBHUD [CommonSingleton shareSingleton].mbHUD //
#define AppWindow (UIView*)[UIApplication sharedApplication].delegate.window
@implementation CommonSingleton

/**
 *  创建单例
 */
+ (CommonSingleton *)shareSingleton
{
    static CommonSingleton * LZCommon = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        
        LZCommon = [[self alloc]init];
    });
    
    return LZCommon ;
}

#pragma mark - MB文字HUD
/**
 *  MB单一的文字
 *
 *  @param view 加载到view
 *  @param text 文字
 */
+ (void)MBTextHUDAddView:(UIView *)view Text:(NSString *)text
{
    if (view == nil) view = AppWindow ;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeText;
    
    hud.label.text = text ;

    //位置可调
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    //几秒后消失
    [hud hideAnimated:YES afterDelay:2.f];
}
#pragma mark - MB图片HUD
/**
 *  MB图片HUD
 *
 *  @param view      加载到view
 *  @param imageName 图片名
 *  @param text      文字
 */
+ (void)MBPictureHUDAddView:(UIView *)view ImageName:(NSString *)imageName Text:(NSString *)text
{
    if (view == nil) view = AppWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    hud.customView = [[UIImageView alloc] initWithImage:image];
    
    hud.square = YES;
    
    hud.label.text = text ;
    
    [hud hideAnimated:YES afterDelay:2.f];
}
#pragma mark - MB菊花
+ (void)MBLoadingHUDAddView:(UIView *)view
{
    if (view == nil) view = AppWindow;
    
    MBHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //模式
    MBHUD.mode = MBProgressHUDModeIndeterminate ;
    //动画类型
//    MBHUD.animationType = MBProgressHUDAnimationZoomIn ;
    //HUD背景色
//    MBHUD.bezelView.color = [UIColor yellowGreenColor];
    
}
#pragma mark - MB菊花+文字
+ (void)MBLoadingHUDAddView:(UIView *)view Text:(NSString *)text
{
    if (view == nil) view = AppWindow;
    
    MBHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    MBHUD.mode = MBProgressHUDModeIndeterminate ;
    
    MBHUD.label.text = text ;
    
}
#pragma mark - MB详情HUD
+ (void)MBDetailHUDAddView:(UIView *)view Text:(NSString *)text DetaiText:(NSString *)detailText
{
    if (view == nil) view = AppWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.label.text = text ;
    
    hud.detailsLabel.text = detailText ;

}
#pragma mark - MBHUD + 进度
+ (void)MBProgressHUDAddView:(UIView *)view Text:(NSString *)text Progress:(NSProgress *)progress
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    //MBProgressHUDModeDeterminateHorizontalBar 进度条
    hud.mode = MBProgressHUDModeDeterminate;
    
    hud.label.text = text ;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        hud.progress = progress.fractionCompleted;
        hud.detailsLabel.text = [NSString stringWithFormat:@"%2.f%%",progress.fractionCompleted*100];
    });
}
#pragma mark - MBHUD✔️正确提示
+ (void)MBSuccessHUDAddView:(UIView *)view Text:(NSString *)text
{
    if (view == nil) view = AppWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    UIImage *image = [[UIImage imageNamed:@"success.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    hud.customView = [[UIImageView alloc] initWithImage:image];
    
    hud.square = YES;
    
    hud.label.text = text ;
    
    [hud hideAnimated:YES afterDelay:2.f];
}
#pragma mark - MBHUD❌错误提示
+ (void)MBErrorHUDAddView:(UIView *)view Text:(NSString *)text
{
    if (view == nil) view = AppWindow;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    
    UIImage *image = [[UIImage imageNamed:@"error.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    hud.customView = [[UIImageView alloc] initWithImage:image];
    
    hud.square = YES;
    
    hud.label.text = text ;
    
    [hud hideAnimated:YES afterDelay:2.f];
}
#pragma mark - MBHUD消失

+ (void)MBHUDdismiss
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBHUD hideAnimated:YES];
    });
}




#pragma mark - SV菊花
/**
 *  SV菊花
 */
+ (void)SVHUDloadingWithString:(NSString *)str
{
    [SVProgressHUD showWithStatus:str];
    //类型
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    //颜色
    [SVProgressHUD setDefaultStyle:SVHUDSTYLE];
    //蒙层颜色
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
}
#pragma mark - SV旋转load
/**
 *  SV旋转loading框
 */
+ (void)SVHUDNativeloadingWithString:(NSString *)str
{
    [SVProgressHUD showWithStatus:str];
    //类型
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    //颜色
    [SVProgressHUD setDefaultStyle:SVHUDSTYLE];
    //蒙层颜色
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
}
#pragma mark - SV正确提示框
/**
 *  SV正确提示
 */
+ (void)SVHUDSuccessWithString:(NSString *)str
{
    [SVProgressHUD showSuccessWithStatus:str];
    [SVProgressHUD setFadeOutAnimationDuration:0.6];
    [SVProgressHUD setFadeInAnimationDuration:0.6];
    [SVProgressHUD setDefaultStyle:SVHUDSTYLE];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        [NSThread sleepForTimeInterval:1];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
        });
    });
    
}
#pragma mark - SV错误提示框
/**
 *  SV错误提示
 */
+ (void)SVHUDErrorWithString:(NSString *)str
{
    [SVProgressHUD showErrorWithStatus:str];
    [SVProgressHUD setFadeOutAnimationDuration:0.6];
    [SVProgressHUD setFadeInAnimationDuration:0.6];
    [SVProgressHUD setDefaultStyle:SVHUDSTYLE];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        [NSThread sleepForTimeInterval:1];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
        });
    });
    
}
#pragma mark - SV警告提示框
/**
 *  SV警告提示框
 */
+ (void)SVHUDWarningWithString:(NSString*)str
{
    [SVProgressHUD showWithStatus:str];
    //类型
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    // 颜色
    [SVProgressHUD setDefaultStyle:SVHUDSTYLE];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
        });
    });
}
#pragma mark - SVHUD消失
/**
 *  SVHUD消失
 */
+ (void)SVHUDdismiss
{
    [SVProgressHUD dismiss];
}

@end
