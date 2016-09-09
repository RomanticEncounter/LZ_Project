//
//  CommonSingleton.h
//  LZ_Demo
//
//  Created by mac on 16/8/8.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__,  ##__VA_ARGS__);
#else
#   define DLog(...)
#endif
#define S_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds) //屏幕宽度
#define S_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds) //屏幕高度
#define STATUSHEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高
#define NAVHEIGHT self.navigationController.navigationBar.frame.size.height //导航栏高
#define TABBARHEIGHT self.tabBarController.tabBar.frame.size.height //分栏导航器高度

@interface CommonSingleton : NSObject

@property (nonatomic, strong) MBProgressHUD *mbHUD ;

+ (CommonSingleton *)shareSingleton ;

/*********************** SVProgressHUD ***********************/

/**
 *  SV菊花+文字
 */
+ (void)SVHUDloadingWithString:(NSString *)str ;
/**
 *  SV旋转的loading+文字
 */
+ (void)SVHUDNativeloadingWithString:(NSString *)str ;
/**
 *  SVHUD正确提示
 */
+ (void)SVHUDSuccessWithString:(NSString *)str ;
/**
 *  SVHUD错误提示
 */
+ (void)SVHUDErrorWithString:(NSString *)str ;
/**
 *  SVHUD警告提示
 */
+ (void)SVHUDWarningWithString:(NSString*)str ;
/**
 *  SVHUD消失
 */
+ (void)SVHUDdismiss ;

/*********************** MBProgressHUD ***********************/

/**
 *  MB文字HUD
 */
+ (void)MBTextHUDAddView:(UIView *)view Text:(NSString *)text ;

/**
 *  MB图片HUD
 */
+ (void)MBPictureHUDAddView:(UIView *)view ImageName:(NSString *)imageName Text:(NSString *)text ;
/**
 *  MB菊花
 */
+ (void)MBLoadingHUDAddView:(UIView *)view ;

/**
 *  MB菊花 + 文字
 */
+ (void)MBLoadingHUDAddView:(UIView *)view Text:(NSString *)text ;

/**
 *  MB详情HUD
 */
+ (void)MBDetailHUDAddView:(UIView *)view Text:(NSString *)text DetaiText:(NSString *)detailText ;

/**
 *  MBHUD + 进度
 */
+ (void)MBProgressHUDAddView:(UIView *)view Text:(NSString *)text Progress:(NSProgress *)progress ;


/**
 *  MBHUD✅正确提示
 */
+ (void)MBSuccessHUDAddView:(UIView *)view Text:(NSString *)text ;

/**
 *  MBHUD❎错误提示
 */
+ (void)MBErrorHUDAddView:(UIView *)view Text:(NSString *)text ;

/**
 *  MBHUD消失
 */
+ (void)MBHUDdismiss ;
@end
