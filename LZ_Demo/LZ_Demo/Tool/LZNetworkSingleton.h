//
//  LZNetworkSingleton.h
//  LZ_Demo
//
//  Created by mac on 16/8/4.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
typedef NS_ENUM(NSInteger, LZNetworkStatus)
{
    
    StatusUnknown = -1,//未知
    StatusNotReachable ,//无网状态
    ReachableViaWWAN ,//手机网络
    StatusReachableViaWiFi = 2//Wifi网络
//    ReachableVia2G,//2G网络
//    ReachableVia3G,//3G网络
//    ReachableVia4G,//4G网络

} ;
/*! 返回字典 */
typedef void (^Success)(NSMutableDictionary *dic);
/*! 返回错误 */
typedef void(^Failure)(NSError *error);
/* 进度 */
typedef void(^Progress)(NSProgress *uploadProgress);



@interface LZNetworkSingleton : NSObject

//@property (nonatomic, assign) LZNetworkStatus netStatus;
/**
 *  创建单例
 */
+ (LZNetworkSingleton *)shareSingleton ;

/**
 *  判断网络
 */
+ (LZNetworkStatus)checkingNetwork ;

/**
 *  GET请求
 */
+ (void)GET:(NSString *)url Parameters:(NSDictionary *)parameters Success:(Success)successRequest Failure:(Failure)failRequest;

/**
 *  POST请求
 */
+ (void)POST:(NSString *)url Parameters:(NSDictionary *)parameters Success:(Success)successRequest Failure:(Failure)failRequest;

/**
 *  NSData上传文件
 */
+ (void)updataFileDataURL:(NSString *)urlStr FileData:(NSData *)fileData Progress:(Progress)progress Completion:(void(^)(id object,NSError *error))completion ;

/**
 *  URL上传文件
 */
+ (void)updataFileURL:(NSString *)urlStr FromFile:(NSURL *)fromUrl Progress:(Progress)progress Completion:(void(^)(id object,NSError *error))completion ;

/**
 *  POST上传图片
 *
 *  @param imgURLStr      上传地址
 *  @param parameters     字典
 *  @param image          需要上传的图片
 *  @param imgName        图片字段
 *  @param progress       进度
 *  @param successRequest 长传成功回调
 *  @param failRequest    上传出错回调
 */
+ (void)updataImageURl:(NSString *)imgURLStr Parameters:(NSDictionary *)parameters Image:(UIImage *)image ImageName:(NSString *)imgName progress:(Progress)progress Success:(Success)successRequest Failure:(Failure)failRequest ;
/**
 *  百度API请求
 *
 *  @param urlStr         URL
 *  @param apikey         百度apikey
 *  @param successRequest 成功
 *  @param failRequest    失败
 */
+ (void)AddValueWithGET:(NSString *)urlStr addAPIKEY:(NSString *)apikey success:(Success)successRequest fail:(Failure)failRequest ;
@end
