//
//  CommonSingleton.h
//  LZ_Demo
//
//  Created by mac on 16/8/8.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import <Foundation/Foundation.h>

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
