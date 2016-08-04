//
//  LZNetworkSingleton.m
//  LZ_Demo
//
//  Created by mac on 16/8/4.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "LZNetworkSingleton.h"
#import "AFNetworking.h"
@interface LZNetworkSingleton ()

@end

@implementation LZNetworkSingleton

/**
 *  创建单例
 */
+ (LZNetworkSingleton *)shareSingleton
{
    static LZNetworkSingleton *LZManger = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        if (LZManger == nil)
        {
            LZManger = [[self alloc]init];
        }
    });

    return LZManger ;
}

/**
 *  判断网络
 */
- (LZNetworkStatus)checkingNetwork
{
    __block NSInteger InterNetworking = -1;
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager manager];
    
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusUnknown)
        {
            InterNetworking = StatusUnknown;
            
        }
        else if (status == AFNetworkReachabilityStatusNotReachable)
        {
            InterNetworking = StatusNotReachable;
            
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWWAN)
        {
            InterNetworking = StatusReachableViaWiFi;
            
        }
        else if (status == AFNetworkReachabilityStatusReachableViaWiFi)
        {
            InterNetworking = StatusReachableViaWiFi;
        }
    }];
    return InterNetworking;

}

/**
 *  GET请求
 */
- (void)GET:(NSString *)url Parameters:(NSDictionary *)parameters Success:(void (^)(id))successRequest Fail:(void (^)(NSError *))failRequest
{
    //检查网络连接
    if ([self checkingNetwork] == StatusNotReachable)
    {
        return ;
    }
    
    //断言
    NSAssert(url != nil, @"url不能为空");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    
    //GET请求
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {}
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {//成功
//         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
        
        //block回调字典
        if (successRequest)
        {
            successRequest(responseObject);
        }
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {//失败
        //block回调Error
        if (failRequest)
        {
            failRequest(error);
        }
    }];
    
}
/**
 *  POST请求
 */
- (void)POST:(NSString *)url Parameters:(NSDictionary *)parameters Success:(void (^)(id))successRequest Failure:(void (^)(NSError *))failRequest
{
    //检查网络连接
    if ([self checkingNetwork] == StatusNotReachable)
    {
        return ;
    }
    
    //断言
    NSAssert(url != nil, @"url不能为空");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //json解析
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //超时
    manager.requestSerializer.timeoutInterval = 10;
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {}
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {//成功
        successRequest(responseObject);
    }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {//失败
        failRequest(error);
    }];
    
}

@end
