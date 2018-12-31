//
//  ICBaseWebViewController.m
//  ichezhidao
//
//  Created by qiuxiaofeng on 16/6/29.
//  Copyright © 2016年 figo. All rights reserved.
//

#import "FGBaseWebViewController.h"

@interface FGBaseWebViewController ()<FGBaseWebViewDelegate>

@property (nonatomic, strong) FGBaseWebView *webView;

@end

@implementation FGBaseWebViewController

- (instancetype)initWithUrl:(NSString *)urlString
{
    if (self = [super init])
    {
        _urlString = urlString;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = UIColorFromHex(0xffffff);
    self.webView = [FGBaseWebView new];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    if (self.contentStr) {
        [self.webView loadHTMLString:self.contentStr];
        
    }
    
    
    
    if (self.urlString) {
        [self.webView loadURL:[NSURL URLWithString:self.urlString]];

    }
    if (self.nameTitle) {
        [self.navigationView setTitle:self.nameTitle];
    }
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.offset(64);
    }];

}


- (void)fgwebViewDidStartLoad:(FGBaseWebView *)webview
{
}

- (void)fgwebView:(FGBaseWebView *)webview shouldStartLoadWithURL:(NSURL *)URL
{
//    [kKeyWindow ]
//    [self.navigationController showLoadingHUDWithMessage:nil];

}
- (void)fgwebView:(FGBaseWebView *)webview didFinishLoadingURL:(NSURL *)URL
{
//    [self.navigationController hideLoadingHUD];
}

- (void)fgwebView:(FGBaseWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error
{
//    [self.navigationController hideLoadingHUD];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self clearCacheAndCookie];
}

//清除浏览器的缓存和cookie
- (void)clearCacheAndCookie
{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


@end
