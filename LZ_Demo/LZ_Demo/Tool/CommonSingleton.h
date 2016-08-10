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

+ (CommonSingleton *)shareSingleton ;
/**
 *  HUD
 */
+ (void)HUDloadingWithString:(NSString *)str ;
/**
 *  旋转的HUD
 */
+ (void)HUDNativeloadingWithString:(NSString *)str ;
/**
 *  正确提示
 */
+ (void)SuccessWithString:(NSString *)str ;
/**
 *  错误提示
 */
+(void)ErrorWithString:(NSString *)str ;
/**
 *  警告提示
 */
+ (void)WarningWithString:(NSString*)str ;
/**
 *  HUD消失
 */
+ (void)HUDdismiss ;
@end
