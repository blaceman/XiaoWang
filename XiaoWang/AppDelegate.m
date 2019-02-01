//
//  AppDelegate.m
//  XiaoWang
//
//  Created by blaceman on 2018/12/31.
//  Copyright © 2018年 new4545. All rights reserved.
//

#import "AppDelegate.h"
#import "FGRegisterVC.h"
#import "XWMineVC.h"
#import "XWPairVC.h"
#import <NIMKit.h>

@interface AppDelegate ()<NIMLoginManagerDelegate,NIMSystemNotificationManagerDelegate,NIMUserManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self naviSet];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self setupNIMSDK];
    [self loginNotification];
    self.pidDic = [NSMutableDictionary new];
    return YES;
}

- (void)naviSet{
    // Do any additional setup after loading the view.
    //统一调整 导航栏 设置
    EasyNavigationOptions *options = [EasyNavigationOptions shareInstance];
    options.titleColor = UIColorFromHex(0x333333);
    options.titleFont = AdaptedFontSize(23);
    options.navigationBackButtonImage = [UIImage imageNamed:@"icon_return"];
    options.navBackGroundColor = UIColorFromHex(0xffffff);
    options.navLineColor = UIColorFromHex(kColorLine);
    options.buttonTitleFont = AdaptedFontSize(16);
    options.buttonTitleColor = UIColorFromHex(0x3A75FD);
    
    
    if ([FGCacheManager sharedInstance].token) {
        XWPairVC *vc = [XWPairVC new];
        
        FGBaseNavigationController *navi = [[FGBaseNavigationController alloc]initWithRootViewController:vc];
        self.window.rootViewController = navi;
        return;
    }
    FGRegisterVC *vc = [FGRegisterVC new];
    
    FGBaseNavigationController *navi = [[FGBaseNavigationController alloc]initWithRootViewController:vc];
    
    self.window.rootViewController = navi;
    
   
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)setupNIMSDK
{
    //推荐在程序启动的时候初始化 NIMSDK
    NSString *appKey        = @"9e174a0b261a3993562da3a53bc803b5";
    NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:appKey];
    option.apnsCername      = @"your APNs cer name";
    option.pkCername        = @"your pushkit cer name";
    [[NIMSDK sharedSDK] registerWithOption:option];
    
    //网易云信 系统通知
    [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
    
    [[NIMSDK sharedSDK].loginManager addDelegate:self];
    [[NIMSDK sharedSDK].userManager addDelegate:self];
    
    [self loginNotification];
    
}

#pragma mark - notification

- (void)loginNotification
{
    //云信 自动登录
    NSString *userName = [FGCacheManager sharedInstance].userModel.uid;
    NSString *password = [FGCacheManager sharedInstance].userModel.code;

    if (!IsEmpty(userName)) {
        [[[NIMSDK sharedSDK] loginManager] login:userName token:password completion:^(NSError * _Nullable error) {
            DLog(@"云信登录%@",error.description);
            if (!error) {
                //差自定义通知
                if ([NIMSDK sharedSDK].conversationManager.allUnreadCount ||  [NIMSDK sharedSDK].systemNotificationManager.allUnreadCount) {
                    
                }
               
            }
        }];
        //        [[[NIMSDK sharedSDK] loginManager] autoLogin:userName token:userName];
    }
}


-(void)match_info{
    [FGHttpManager getWithPath:[NSString stringWithFormat:@"api/match/match_info/%@",@"ID"] parameters:@{} success:^(id responseObject) {
        
    } failure:^(NSString *error) {
        
    }];
}
@end
