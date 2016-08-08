//
//  FirstDetailViewController.m
//  LZ_Demo
//
//  Created by mac on 16/8/5.
//  Copyright © 2016年 LZ. All rights reserved.
//

#import "FirstDetailViewController.h"
#import "LZNetworkSingleton.h"
@interface FirstDetailViewController ()<UIWebViewDelegate>
/**
 *  面板
 */
@property (nonatomic, strong) UIView *panelView;
/**
 *  加载视图
 */
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation FirstDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //加载等待视图
    self.panelView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.panelView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.panelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    self.loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loadingView.frame = CGRectMake((self.view.frame.size.width - self.loadingView.frame.size.width) / 2, (self.view.frame.size.height - self.loadingView.frame.size.height) / 2, self.loadingView.frame.size.width, self.loadingView.frame.size.height);
    self.loadingView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.panelView addSubview:self.loadingView];

   
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, S_WIDTH,  self.view.frame.size.height)];
    webView.delegate = self;
    
    webView.opaque = NO; //不设置这个值 页面背景始终是白色
    
    webView.backgroundColor = [UIColor clearColor];
    
    webView.scalesPageToFit = NO;  //禁止用户缩放页面
    
    webView.dataDetectorTypes = UIDataDetectorTypePhoneNumber|UIDataDetectorTypeLink;
    
    webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0,0, 0);
    
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    NSString *jsString = [[NSString alloc] initWithFormat:@"document.body.style.fontSize=%f;document.body.style.backgroundColor=%@;var paras = document.getElementsByTagName('p');for (var i=0; i< paras.length; i++) {document.getElementsByTagName('p')[i].style.background=%@;document.getElementsByTagName('p')[i].style.color='#fff';}document.getElementsByClassName('cont-title')[0].getElementsByTagName('h3')[0].style.color=%@;var spanparas = document.getElementsByClassName('cont-bot')[0].getElementsByTagName('span');for (var n=0; n< spanparas.length; n++) {document.getElementsByClassName('cont-bot')[0].getElementsByTagName('span')[n].style.color=%@; document.getElementsByClassName('cont-bot')[0].getElementsByTagName('span')[n].style.background='#2e2e2e';}",16.0,@"'#2E2E2E'",@"'#2E2E2E'",@" '#ffffff' ",@" '#ffffff' "];
    
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_URL]];
    [self.view addSubview: webView];
    
    [webView loadRequest:request];

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
