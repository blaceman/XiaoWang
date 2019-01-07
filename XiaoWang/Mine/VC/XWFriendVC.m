//
//  XWFriendVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/7.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWFriendVC.h"
#import "WXNewsListVC.h"

@interface XWFriendVC ()

@end

@implementation XWFriendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //================== 设置成菜单的文字
    
    self.titleSizeNormal = 16;
    self.titleSizeSelected = 16;
    self.titleColorSelected = UIColorFromHex(0x333333);
    self.titleColorNormal = UIColorFromHex(0x666666);;
    self.progressColor = UIColorFromHex(0xFFDD00);
    self.progressHeight = AdaptedWidth(2);
    self.progressViewCornerRadius = AdaptedWidth(2);
    self.progressWidth = AdaptedWidth(67);
    self.menuViewStyle = WMMenuViewStyleLine;
    self.progressViewBottomSpace = WMMenuViewStyleLine;
    self.showOnNavigationBar = NO;
    self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
//    self.itemsWidths = @[@(kScreenWidth / 2.3),@(kScreenWidth / 2.3)];
    //    [self.menuView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.height.mas_equalTo(AdaptedHeight(47));
    //    }];
    
    
    
    [self.menuView addTopLine];
    //============= 设置标题
    
    NSArray *titles = @[@"我的好友",@"黑名单"];
    NSMutableArray *viewControllers = [NSMutableArray new];
    
    
    WXNewsListVC *vc = [WXNewsListVC new];
    [viewControllers addObject:vc];
    
    WXNewsListVC *vc2 = [WXNewsListVC new];
    [viewControllers addObject:vc2];
    
    [self setupViewcontrollers:viewControllers titles:titles];
    
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
