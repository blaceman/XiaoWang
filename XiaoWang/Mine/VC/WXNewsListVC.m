//
//  WXNewsVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/7.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "WXNewsListVC.h"
#import "XWNewsCell.h"
#import "XWFriendsInformationVC.h"


@interface WXNewsListVC ()

@end

@implementation WXNewsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.type == 0) {
        [self.navigationView setTitle:@"我的消息"];
        [self.navigationView addRightButtonWithImage:UIImageWithName(@"icon_pot") clickCallBack:^(UIView *view) {
            
        }];
    }else if (self.type == 0){
        [self.navigationView setTitle:@"速配过的人"];

    }
    [self setupEstimatedRowHeight:100 cellClasses:@[[XWNewsCell class]]];
    [self beginRefresh];

}

-(void)requestDataWithOffset:(NSInteger)offset success:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure{
    if (self.type == 1) {
        success(@[@"1",@"1",@"1",@"1",@"1"]);
        return;

    }else if (self.type == 2){
        success(@[@"2",@"2",@"2",@"2",@"2"]);

    }
    success(@[@"",@"",@"",@"",@""]);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[XWFriendsInformationVC new] animated:YES];
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
