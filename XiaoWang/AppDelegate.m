//
//  AppDelegate.m
//  XiaoWang
//
//  Created by blaceman on 2018/12/31.
//  Copyright © 2018年 new4545. All rights reserved.
//

#import "AppDelegate.h"
#import "FGRegisterVC.h"
#import "XWPairVC.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self naviSet];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

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
    options.buttonTitleColor = UIColorFromHex(0xFF8A00);
    
    
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


@end
