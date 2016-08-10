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
    UIWebView *webView = [[UIWebView alloc]init];
    
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
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:webView];

    [self.bridge registerHandler:@"ObjC Echo" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"ObjC Echo called with: %@", data);
        responseCallback(data);
    }];
    
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
