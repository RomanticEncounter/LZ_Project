//
//  LZLocalNotificationSingleton.m
//  LZ_Demo
//
//  Created by mac on 16/8/15.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "LZLocalNotificationSingleton.h"
#import "AppDelegate.h"
@implementation LZLocalNotificationSingleton

+ (LZLocalNotificationSingleton *)shareSingleton
{
    static LZLocalNotificationSingleton * LZPush = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        
        LZPush = [[self alloc]init];
    });
    
    return LZPush ;
}
/**
 *  注册推送
 */
+ (void)registLocalNotification
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    }
}
/**
 *  普通推送
 *
 *  @param alertTime 推送时间
 *  @param alertBody 推送消息
 *  @param str       key
 */
+ (void)sendMess:(NSInteger)alertTime body:(NSString *)alertBody noticeStr:(NSString *)str
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
    notification.repeatInterval = kCFCalendarUnitSecond;
    
    // 通知内容
    notification.alertBody =  alertBody;
    notification.applicationIconBadgeNumber = 1;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:str forKey:@"key"];
    notification.userInfo = userDict;
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}
/**
 *  注册下拉有按钮
 */
+ (void)registLocalNotificationAction
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
//        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        
        UIUserNotificationSettings* newSetting= [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:[NSSet setWithObjects:[LZLocalNotificationSingleton shareSingleton].categorys, [LZLocalNotificationSingleton shareSingleton].categorys_1,nil]];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:newSetting];
        notification.repeatInterval = NSCalendarUnitDay;
    }
    else
    {
        notification.repeatInterval = NSCalendarUnitDay;
    }
}
/**
 *  下拉带有两个按钮的本地推送
 *
 *  @param title1    第一个按钮的名称
 *  @param title2    第二个按钮的名称
 *  @param alertTime 时间
 *  @param alertBody 推送消息
 *  @param str       key
 */
+ (void)actionSendMess:(NSInteger)alertTime body:(NSString *)alertBody noticeStr:(NSString *)str
{
    UIMutableUserNotificationAction* action1 = [[UIMutableUserNotificationAction alloc] init];
    
    action1.identifier = LZNotificationActionIdentifierStar;
    action1.authenticationRequired = NO;
    action1.destructive = NO;
    action1.activationMode = UIUserNotificationActivationModeBackground;//后台
    action1.title = @"关闭闹钟";
    UIMutableUserNotificationAction* action2 = [[UIMutableUserNotificationAction alloc] init];
    
    action2.identifier = LZNotificationActionIdentifierComment;
    action2.title = @"5分钟后";
    action2.authenticationRequired = NO;
    action2.destructive = NO;
    action2.activationMode = UIUserNotificationActivationModeBackground;//后台
    
    [LZLocalNotificationSingleton shareSingleton].categorys = [[UIMutableUserNotificationCategory alloc] init];
    [LZLocalNotificationSingleton shareSingleton].categorys.identifier = LZNotificationCategory;
    [[LZLocalNotificationSingleton shareSingleton].categorys setActions:@[action1,action2] forContext:UIUserNotificationActionContextDefault];
    UIUserNotificationSettings* newSetting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:[NSSet setWithObject:[LZLocalNotificationSingleton shareSingleton].categorys]];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:newSetting];
    
    
    
    if(newSetting.types == UIUserNotificationTypeNone)
    {
        UIUserNotificationSettings* newSetting= [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:[NSSet setWithObject:[LZLocalNotificationSingleton shareSingleton].categorys]];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:newSetting];
    }
    else
    {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    }
    
    UILocalNotification * notification=[[UILocalNotification alloc] init];
    
    notification.alertTitle = @"闹钟";
    
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    
    notification.alertBody = alertBody;
    
    notification.repeatInterval = NSCalendarUnitDay;
    
    
    notification.applicationIconBadgeNumber=1;
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.hasAction = YES;
    notification.category = LZNotificationCategory;
    
    notification.userInfo=@{@"key":str};
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //
    
    
//    [AppDelegate.creatTimer:alertTime];
    
//    [[UIApplication sharedApplication] creatTimer:alertTime];
    
//    [LZLocalNotificationSingleton shareSingleton].timer = [NSTimer timerWithTimeInterval:alertTime+5 target:self selector:@selector(playMusic) userInfo:nil repeats:YES];
//    
//    [[NSRunLoop currentRunLoop] addTimer:[LZLocalNotificationSingleton shareSingleton].timer forMode:NSRunLoopCommonModes];
}

/**
 *  取消某个本地推送通知
 */
+ (void)cancelLocalNotificationWithKey:(NSString *)key
{
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[@"key"];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil)
            {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}


@end
