//
//  XWAlbumVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/6.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWAlbumVC.h"
#import "HYHomeTCell.h"

@interface XWAlbumVC ()

@end

@implementation XWAlbumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"我的相册"];
    WeakSelf
    [self.navigationView addRightButtonWithImage:UIImageWithName(@"icon_release") clickCallBack:^(UIView *view) {
        StrongSelf
        
    }];
    
    [self setupEstimatedRowHeight:100 cellClasses:@[[HYHomeTCell class]]];
    [self beginRefresh];
}
-(void)requestDataWithOffset:(NSInteger)offset success:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure{
    success(@[@"发哈实例和",@"发斯蒂芬",@"发多少",@"发答案是"]);
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
