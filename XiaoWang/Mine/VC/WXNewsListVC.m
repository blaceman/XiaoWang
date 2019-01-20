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
//        [self.navigationView addRightButtonWithImage:UIImageWithName(@"icon_pot") clickCallBack:^(UIView *view) {
//            
//        }];
    }else if (self.type == 3){
        [self.navigationView setTitle:@"速配过的人"];

    }
    [self setupEstimatedRowHeight:100 cellClasses:@[[XWNewsCell class]]];
    [self beginRefresh];

}

-(void)requestDataWithOffset:(NSInteger)offset success:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure{
    if (self.type == 1) {
        NSArray *friendList = [[NIMSDK sharedSDK] userManager].myFriends;
        success(friendList);
//        success(@[@"1",@"1",@"1",@"1",@"1"]);
        return;

    }else if (self.type == 2){
        NSArray *myblackList = [[NIMSDK sharedSDK] userManager].myBlackList;
        success(myblackList);
        return;

    }else if(self.type == 3){
        [FGHttpManager getWithPath:@"api/friend/lists" parameters:@{} success:^(id responseObject) {
            NSArray<FGUserModel *> *userModelArr = [NSArray modelArrayWithClass:[FGUserModel class] json:[responseObject valueForKey:@"data"]];
            success(userModelArr);
        } failure:^(NSString *error) {
            
        }];
    }
    
    success([NIMSDK sharedSDK].conversationManager.allRecentSessions);
//    success(@[@"",@"",@"",@"",@""]);
}

-(void)configCellSubViewsCallback:(FGBaseTableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    XWNewsCell *newsCell = (XWNewsCell *)cell;
    [[[newsCell.avatetBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.navigationController pushViewController:[XWFriendsInformationVC new] animated:YES];
    }];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FGUserModel *userModel = [self.dataSourceArr objectAtIndex:indexPath.row];
    NIMSession *session = [NIMSession session:userModel.code.stringValue type:NIMSessionTypeP2P];
    NIMSessionViewController *vc = [[NIMSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:vc animated:YES];
   
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
