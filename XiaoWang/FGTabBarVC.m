//
//  FGTabBarVC.m
//  jingpai
//
//  Created by qiuxiaofeng on 2018/5/30.
//  Copyright © 2018年 JP. All rights reserved.
//

#import "FGTabBarVC.h"
//#import "FGLoginVC.h"


@interface FGTabBarVC ()<UITabBarControllerDelegate>

@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *normalImageNameArray;
@property (nonatomic,strong)NSMutableArray *selectedImageNameArray;

@end

@implementation FGTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //统一调整 导航栏 设置
    EasyNavigationOptions *options = [EasyNavigationOptions shareInstance];
    options.titleColor = UIColorFromHex(0x010101);
    options.navigationBackButtonImage = [UIImage imageNamed:@"ic_arrow_left_return_black"];
    options.navBackGroundColor = UIColorFromHex(0xffffff);
    options.navLineColor = UIColorFromHex(kColorLine);
    options.buttonTitleFont = AdaptedFontSize(16);
    options.buttonTitleColor = UIColorFromHex(0xFF8A00);
//    options.buttonTitleColorHieght = UIColorFromHex(0xFF8A00);
    self.titleArray = [NSMutableArray arrayWithArray:@[@"首页", @"资讯",@"冲关", @"我的"]];
    
    
    NSMutableArray *arrNavi = [[NSMutableArray alloc]init];
    NSArray *arrVC = @[@"YSHomeViewController",@"YSNewsViewController",@"YSPunchPreVC",@"YSMineViewController"];
    for (int i = 0; i < arrVC.count; i++) {
        FGBaseNavigationController *navi = [[FGBaseNavigationController alloc]initWithRootViewController:[[NSClassFromString(arrVC[i]) alloc]init]];
        [arrNavi addObject:navi];
    }
    
    self.viewControllers = arrNavi;
    self.tabBar.translucent = NO;
    self.delegate = self;
    //    self.tabBar.shadowImage = [UIImage imageWithColor:UIColorFromHex(kColorLine) size:CGSizeMake(kScreenWidth, kOnePixel)];
    
    [self customizeTabBar];
}

- (void)customizeTabBar
{
    
    _normalImageNameArray = [NSMutableArray arrayWithArray:@[@"ic_main_tab_home_normal",@"ic_main_tab_information_normal", @"ic_main_tab_customs_clearance_normal", @"ic_main_tab_user_center_normal"]];
    _selectedImageNameArray = [NSMutableArray arrayWithArray:@[@"ic_main_tab_home_pressed",@"ic_main_tab_information_pressed", @"ic_main_tab_customs_clearance_pressed", @"ic_main_tab_user_center_pressed"]];
    
    NSUInteger index = 0;
    for (UINavigationController *navigationController in self.viewControllers) {
        
        UIViewController *viewController = navigationController.viewControllers.firstObject;
        
        NSString *title = self.titleArray[index];
        NSString *normalImageName = _normalImageNameArray[index];
        NSString *selectedImageName = _selectedImageNameArray[index];
        
        UIImage *normalImage = UIImageWithName(normalImageName);
        UIImage *selectedImage = UIImageWithName(selectedImageName);
        
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage tag:index];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorFromHex(0x666666)} forState:UIControlStateNormal];
        [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColorFromHex(0x000000)} forState:UIControlStateSelected];
        if ([normalImage respondsToSelector:@selector(imageWithRenderingMode:)]) {
            normalImage = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        //        [tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        tabBarItem.image = normalImage;
        tabBarItem.selectedImage = selectedImage;
        
        viewController.tabBarItem = tabBarItem;
        
        index++;
    }
}


- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
