//
//  AppDelegate.h
//  XiaoWang
//
//  Created by blaceman on 2018/12/31.
//  Copyright © 2018年 new4545. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) NSInteger countDowmTime;  ///< <#Description#>
@property (nonatomic ,strong) NSMutableDictionary<NSString *,NSMutableArray *> *pidDic;
- (void)loginNotification;

@end

