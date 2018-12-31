//
//  ICBaseWebView.h
//  ichezhidao
//
//  Created by qiuxiaofeng on 16/6/29.
//  Copyright © 2016年 figo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class FGBaseWebView;

@protocol FGBaseWebViewDelegate <NSObject>
@optional
- (void)fgwebView:(FGBaseWebView *)webview didFinishLoadingURL:(NSURL *)URL;
- (void)fgwebView:(FGBaseWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error;
- (void)fgwebView:(FGBaseWebView *)webview shouldStartLoadWithURL:(NSURL *)URL;
- (void)fgwebViewDidStartLoad:(FGBaseWebView *)webview;

@end

@interface FGBaseWebView : UIView<WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate>

@property (nonatomic, weak) id <FGBaseWebViewDelegate> delegate;

@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIWebView *uiWebView;
@property (nonatomic, strong) UIColor *tintColor;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)loadRequest:(NSURLRequest *)request;
- (void)loadURL:(NSURL *)URL;
- (void)loadURLString:(NSString *)URLString;
- (void)loadHTMLString:(NSString *)HTMLString;

@end
