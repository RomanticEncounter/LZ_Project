//
//  CommonSingleton.m
//  LZ_Demo
//
//  Created by mac on 16/8/8.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "CommonSingleton.h"
#import "SVProgressHUD.h"
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
#pragma mark - 菊花
/**
 *  菊花
 */
+ (void)HUDloadingWithString:(NSString *)str
{
    [SVProgressHUD showWithStatus:str];
    //类型
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    //颜色
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    //蒙层颜色
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
}
#pragma mark - 旋转load
/**
 *  旋转loading框
 */
+ (void)HUDNativeloadingWithString:(NSString *)str
{
    [SVProgressHUD showWithStatus:str];
    //类型
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    //颜色
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    //蒙层颜色
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
}
#pragma mark - 正确提示框
/**
 *  正确提示
 */
+ (void)SuccessWithString:(NSString *)str
{
    [SVProgressHUD showSuccessWithStatus:str];
    [SVProgressHUD setFadeOutAnimationDuration:0.6];
    [SVProgressHUD setFadeInAnimationDuration:0.6];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        [NSThread sleepForTimeInterval:1];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
        });
    });
    
}
#pragma mark - 错误提示框
+ (void)ErrorWithString:(NSString *)str
{
    [SVProgressHUD showErrorWithStatus:str];
    [SVProgressHUD setFadeOutAnimationDuration:0.6];
    [SVProgressHUD setFadeInAnimationDuration:0.6];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        [NSThread sleepForTimeInterval:1];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
        });
    });
    
}
#pragma mark - 警告提示框
/**
 *  警告提示框
 */
+ (void)WarningWithString:(NSString*)str
{
    [SVProgressHUD showWithStatus:str];
    //类型
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    // 颜色
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
        });
    });
}
#pragma mark - HUD消失
/**
 *  HUD消失
 */
+(void)HUDdismiss
{
    [SVProgressHUD dismiss];
    
}

@end
