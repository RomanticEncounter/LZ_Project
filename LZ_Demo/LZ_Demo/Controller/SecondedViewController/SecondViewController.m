//
//  SecondViewController.m
//  LZ_Demo
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "SecondViewController.h"
#import "CommonSingleton.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"第三页";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(hudClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)hudClick:(UIButton *)button
{
//    [CommonSingleton MBTextHUDAddView:self.navigationController.view Text:@""];
    [CommonSingleton MBLoadingHUDAddView:self.view];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        sleep(3);
        dispatch_async(dispatch_get_main_queue(), ^{
            [CommonSingleton MBHUDdismiss];
        });
    });

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
