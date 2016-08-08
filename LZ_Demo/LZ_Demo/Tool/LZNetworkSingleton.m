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
        
            LZManger = [[self alloc]init];
    });

    return LZManger ;
}

/**
 *  判断网络
 */
#pragma mark - 判断网络
+ (LZNetworkStatus)checkingNetwork
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
#pragma mark - GET请求
/**
 *  GET请求
 */
+ (void)GET:(NSString *)url Parameters:(NSDictionary *)parameters Success:(Success)successRequest Failure:(Failure)failRequest
{
    //检查网络连接
    if ([self checkingNetwork] == StatusNotReachable)
    {
        return ;
    }
    NSAssert(url != nil, @"url不能为空");
    
    //使用AFNetworking进行网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.requestSerializer.timeoutInterval = 10;
    //发起get请求
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successRequest) {
            successRequest(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failRequest) {
            failRequest(error);
        }
    }];

}


/**
 *  POST请求
 */
#pragma mark - POST请求
+ (void)POST:(NSString *)url Parameters:(NSDictionary *)parameters Success:(Success)successRequest Failure:(Failure)failRequest
{
    //检查网络连接
    if ([self checkingNetwork] == StatusNotReachable)
    {
        return ;
    }
    
    //断言
    NSAssert(url != nil, @"url不能为空");
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //JSON解析
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
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
/**
 *  NSData上传文件
 */
#pragma mark - NSData上传文件
+ (void)updataFileDataURL:(NSString *)urlStr FileData:(NSData *)fileData Progress:(Progress)progress Completion:(void(^)(id object,NSError *error))completion
{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager uploadTaskWithRequest:request fromData:fileData progress:^(NSProgress * _Nonnull uploadProgress)
    {
        progress(uploadProgress);
    }
    completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)
    {
        completion(responseObject,error);
    }];
}
/**
 *  NSURL上传文件
 */
#pragma mark - NSURL上传文件
+ (void)updataFileURL:(NSString *)urlStr FromFile:(NSURL *)fromUrl Progress:(Progress)progress Completion:(void(^)(id object,NSError *error))completion
{
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager uploadTaskWithRequest:request fromFile:fromUrl progress:^(NSProgress * _Nonnull uploadProgress)
    {
        progress(uploadProgress);
    }
    completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)
    {
        completion(responseObject,error);
    }];
}
/**
 *  上传图片
 */
#pragma mark - 上传图片
+ (void)updataImageURl:(NSString *)imgURLStr Parameters:(NSDictionary *)parameters Image:(UIImage *)image ImageName:(NSString *)imgName progress:(Progress)progress Success:(Success)successRequest Failure:(Failure)failRequest
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSString * url = [NSString stringWithFormat:@"%@%@",APP_HTTP,UPLOADUSERIMG];
    
    [manager POST:imgURLStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    {
        //将获取的图片转成NSData
        //图片不允许重名
        //可自己更改图片文件格式
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:imgName fileName:fileName mimeType:@"image/jpeg"];
    }
    progress:^(NSProgress * _Nonnull uploadProgress)
    {
        progress(uploadProgress);
    }
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSMutableDictionary *dic =
        [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (successRequest)
        {
            successRequest(dic);
        }
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        //上传出错
        if (failRequest)
        {
            failRequest(error);
        }
    }];
}
/**
 *  使用百度API
 */
#pragma mark - 百度API-请求加apikey
+ (void)AddValueWithGET:(NSString *)urlStr addAPIKEY:(NSString *)apikey success:(Success)successRequest  fail:(Failure)failRequest
{
    //检查网络连接
    if ([self checkingNetwork] == StatusNotReachable)
    {
        return ;
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
        [request setHTTPMethod: @"GET"];
        [request addValue: apikey forHTTPHeaderField: @"apikey"];
        [NSURLConnection sendAsynchronousRequest: request queue: [NSOperationQueue mainQueue]completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error)
    {
        if (error)
        {
            failRequest(error);
        }
        else
        {
            NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];successRequest(result);
        }
    }];

}


@end
