//
//  FirstDetailViewController.m
//  LZ_Demo
//
//  Created by mac on 16/8/5.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "FirstDetailViewController.h"
#import "LZNetworkSingleton.h"
#import "CommonSingleton.h"
@interface FirstDetailViewController ()<UIWebViewDelegate>
@property WebViewJavascriptBridge* bridge;
@end

@implementation FirstDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, S_WIDTH, S_HEIGHT)];
    
    webView.delegate = self;
    
    webView.opaque = NO; //不设置这个值 页面背景始终是白色
    
    webView.backgroundColor = [UIColor clearColor];
    
    webView.scalesPageToFit = NO;  //禁止用户缩放页面
    
    webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber|UIDataDetectorTypeLink;
    
    webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0,0, 0);
    
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_URL]];
    [self.view addSubview: webView];
    
    [webView loadRequest:request];
//    self.bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
//
//    [self.bridge registerHandler:@"ObjC Echo" handler:^(id data, WVJBResponseCallback responseCallback) {
//        NSLog(@"ObjC Echo called with: %@", data);
//        responseCallback(data);
//    }];
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [CommonSingleton SVHUDNativeloadingWithString:@"正在努力加载..."];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [CommonSingleton SVHUDdismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [CommonSingleton SVHUDdismiss];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"错误" message:@"页面加载失败..." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *reloadingAction = [UIAlertAction actionWithTitle:@"重新加载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_URL]];
        [webView loadRequest:request];
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:reloadingAction];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
