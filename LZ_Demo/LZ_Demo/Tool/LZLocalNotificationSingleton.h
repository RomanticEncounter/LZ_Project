//
//  LZLocalNotificationSingleton.h
//  LZ_Demo
//
//  Created by mac on 16/8/15.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#define LZNotificationActionIdentifierStar @"LZNotificationActionIdentifileStar"//第一个按钮的identifier
#define LZNotificationActionIdentifierComment @"LZNotificationActionIdentifileComment"//第二个按钮的identifier
#define LZNotificationCategory @"LZNOtificationCategory"//带有按钮的推送的category

@interface LZLocalNotificationSingleton : NSObject
{
//    AVAudioPlayer *player ;
}

@property(nonatomic,strong) UIMutableUserNotificationCategory *categorys;
@property(nonatomic,strong) UIMutableUserNotificationCategory *categorys_1 ;
@property (nonatomic, strong) NSTimer *timer ;
@property (nonatomic, strong) AVAudioPlayer *player ;

+ (void)registLocalNotification ;

+ (void)registLocalNotificationAction ;

+ (void)sendMess:(NSInteger)alertTime body:(NSString *)alertBody noticeStr:(NSString *)str ;

+ (void)actionSendMess:(NSInteger)alertTime body:(NSString *)alertBody noticeStr:(NSString *)str ;

+ (void)cancelLocalNotificationWithKey:(NSString *)key ;

@end
