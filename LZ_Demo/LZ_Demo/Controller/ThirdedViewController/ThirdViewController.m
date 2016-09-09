//
//  ThirdViewController.m
//  LZ_Demo
//
//  Created by mac on 16/8/3.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "ThirdViewController.h"
#import "LZLocalNotificationSingleton.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"第三页";
    self.view.backgroundColor = [UIColor brownColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(pushAPP) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [LZLocalNotificationSingleton registLocalNotification];
}
- (void)pushAPP
{
    [LZLocalNotificationSingleton sendMess:60 body:@"早上好" noticeStr:@"早"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
