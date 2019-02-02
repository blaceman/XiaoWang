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
#import "XWPassModel.h"
#import "XWMessageModel.h"
#import "XWPairPassVC.h"

@interface WXNewsListVC ()

@end

@implementation WXNewsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.type == 0) {
        self.myTableView.mj_footer = nil;

        [self.navigationView setTitle:@"我的消息"];
//        [self.navigationView addRightButtonWithImage:UIImageWithName(@"icon_pot") clickCallBack:^(UIView *view) {
//            
//        }];
    }else if (self.type == 3){
        [self.navigationView setTitle:@"速配过的人"];

    }else{
        self.myTableView.mj_footer = nil;

    }
    [self setupEstimatedRowHeight:100 cellClasses:@[[XWNewsCell class]]];
    [self beginRefresh];

}

-(void)requestDataWithOffset:(NSInteger)offset success:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure{
    if (self.type == 1) {
        [FGHttpManager getWithPath:@"api/friend/lists" parameters:@{@"page":@(offset)} success:^(id responseObject) {
            NSArray<FGUserModel *> *userModelArr = [NSArray modelArrayWithClass:[FGUserModel class] json:[responseObject valueForKey:@"data"]];
            success(userModelArr);
        } failure:^(NSString *error) {
            
        }];
        
//        NSArray *friendList = [[NIMSDK sharedSDK] userManager].myFriends;
//        success(friendList);
//        success(@[@"1",@"1",@"1",@"1",@"1"]);
        return;

    }else if (self.type == 2){
        [FGHttpManager getWithPath:@"api/black/lists" parameters:@{@"page":@(offset)} success:^(id responseObject) {
            NSArray<XWPassModel *> *userModelArr = [NSArray modelArrayWithClass:[XWPassModel class] json:[responseObject valueForKey:@"data"]];
            success(userModelArr);
        } failure:^(NSString *error) {
            
        }];
        
//        NSArray *myblackList = [[NIMSDK sharedSDK] userManager].myBlackList;
//        success(myblackList);
        return;

    }else if(self.type == 3){//@"api/friend/lists"
//        http://59.110.153.91:9999/api/match/lists?pageSize=20&page=1
        
        [FGHttpManager getWithPath:@"api/match/lists" parameters:@{@"page":@(offset)} success:^(id responseObject) {
            NSArray<XWPassModel *> *userModelArr = [NSArray modelArrayWithClass:[XWPassModel class] json:[responseObject valueForKey:@"data"]];
            success(userModelArr);
        } failure:^(NSString *error) {
            
        }];
        return;
    }
    [FGHttpManager getWithPath:@"api/message/lists" parameters:@{@"page":@(offset)} success:^(id responseObject) {
        NSArray<XWMessageModel *> *userModelArr = [NSArray modelArrayWithClass:[XWMessageModel class] json:responseObject];
        success(userModelArr);
    } failure:^(NSString *error) {
        
    }];
    
//    success([NIMSDK sharedSDK].conversationManager.allRecentSessions);
//    success(@[@"",@"",@"",@"",@""]);
}

-(void)configCellSubViewsCallback:(FGBaseTableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    XWNewsCell *newsCell = (XWNewsCell *)cell;
    [[[newsCell.avatetBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)] takeUntil:cell.rac_prepareForReuseSignal]subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.navigationController pushViewController:[XWFriendsInformationVC new] animated:YES];
    }];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 0) {
        XWMessageModel *messageModel = [self.dataSourceArr objectAtIndex:indexPath.row];
//        FGUserModel *userModel = [FGUserModel modelWithJSON:messageModel.modelToJSONObject];
        if ([messageModel.type isEqualToString:@"match"]) {
            if (messageModel.state.integerValue == 1) {
                [self matched_infoWithMach_id:messageModel.match_id.stringValue];
            }else{
                [self showTextHUDWithMessage:@"通关失败"];
            }
        }
        
        
        return;
        
    }
    id model = [self.dataSourceArr objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[FGUserModel class]]) {
    FGUserModel *userModel = [self.dataSourceArr objectAtIndex:indexPath.row];
    NIMSession *session = [NIMSession session:userModel.code type:NIMSessionTypeP2P];
    NIMSessionViewController *vc = [[NIMSessionViewController alloc] initWithSession:session];
    [self.navigationController pushViewController:vc animated:YES];
    }else if ([model isKindOfClass:[NIMRecentSession class]]){
        NIMRecentSession *sessionModel = model;
        NIMSessionViewController *vc = [[NIMSessionViewController alloc] initWithSession:sessionModel.session];
        [self.navigationController pushViewController:vc animated:YES];

    }else if([model isKindOfClass:[XWPassModel class]]){
        XWPassModel *sessionModel = model;
        NIMSessionViewController *vc = [[NIMSessionViewController alloc] initWithSession:[NIMSession session:sessionModel.uid.stringValue type:(NIMSessionTypeP2P)]];
        [self.navigationController pushViewController:vc animated:YES];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
-(void)matched_infoWithMach_id:(NSString *)matchID{
    WeakSelf
    [self showLoadingHUDWithMessage:@""];
    [FGHttpManager getWithPath:[NSString stringWithFormat:@"api/match/match_info/%@",matchID] parameters:@{} success:^(id responseObject) {
        StrongSelf
        [self hideLoadingHUD];
        FGUserModel *userModel = [FGUserModel modelWithJSON:responseObject];
        XWPairPassVC *vc = [XWPairPassVC new];
        vc.userModel = userModel;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    } failure:^(NSString *error) {
        
    }];
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
