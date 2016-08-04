//
//  LZNetworkSingleton.h
//  LZ_Demo
//
//  Created by mac on 16/8/4.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LZNetworkStatus)
{
    
    StatusUnknown = -1,//未知
    StatusNotReachable = 0,//无网状态
    ReachableViaWWAN = 1,//手机网络
    StatusReachableViaWiFi = 2//Wifi网络
//    ReachableVia2G,//2G网络
//    ReachableVia3G,//3G网络
//    ReachableVia4G,//4G网络

} ;

@interface LZNetworkSingleton : NSObject
@property (nonatomic, assign) LZNetworkStatus netStatus;
/**
 *  创建单例
 */
+ (LZNetworkSingleton *)shareSingleton ;

/**
 *  判断网络
 */
- (LZNetworkStatus)checkingNetwork ;

@end
