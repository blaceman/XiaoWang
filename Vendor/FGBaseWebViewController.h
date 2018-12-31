//
//  ICBaseWebViewController.h
//  ichezhidao
//
//  Created by qiuxiaofeng on 16/6/29.
//  Copyright © 2016年 figo. All rights reserved.
//

#import "FGBaseViewController.h"
#import "FGBaseWebView.h"

@interface FGBaseWebViewController : FGBaseViewController

@property (nonatomic, strong, readonly) FGBaseWebView *webView;
@property (nonatomic, strong) NSString *contentStr;  ///< <#Description#>
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *nameTitle;

- (instancetype)initWithUrl:(NSString *)urlString;

@end
