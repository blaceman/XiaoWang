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
#import "XWChatVC.h"
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
            NSArray<FGUserModel *> *userModelArr = [NSArray modelArrayWithClass:[FGUserModel class] json:[responseObject valueForKey:@"data"]];
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
        [self messageRead];

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
                [self matched_infoWithMach_id:messageModel];
            }else{
                [self showTextHUDWithMessage:@"通关失败"];
            }
        }
        
        
        return;
        
    }
    id model = [self.dataSourceArr objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[FGUserModel class]]) {
    FGUserModel *userModel = [self.dataSourceArr objectAtIndex:indexPath.row];
    NIMSession *session = [NIMSession session:userModel.f_uid.stringValue type:NIMSessionTypeP2P];
    XWChatVC *vc = [[XWChatVC alloc] initWithSession:session];
        vc.userModel = userModel;
//        [vc.navigationController setTitle:userModel.nickname];
    [self.navigationController pushViewController:vc animated:YES];
       

        
    }else if([model isKindOfClass:[XWPassModel class]]){
        XWPassModel *sessionModel = model;
        if (sessionModel.state.integerValue == 20) {
            [self getFriendsWithUid:sessionModel.match_id.stringValue];
        }else{
            [self showTextHUDWithMessage:@"通关失败"];
        }

    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
-(void)matched_infoWithMach_id:(XWMessageModel *)messageModel{
    WeakSelf
    [self showLoadingHUDWithMessage:@""];
    [FGHttpManager getWithPath:[NSString stringWithFormat:@"api/match/match_info/%@",messageModel.match_id] parameters:@{} success:^(id responseObject) {
        StrongSelf
        [self hideLoadingHUD];
        FGUserModel *userModel = [FGUserModel modelWithJSON:responseObject];
        userModel.match_id = @(messageModel.match_id.integerValue);
        userModel.uid = messageModel.uid;
        XWPairPassVC *vc = [XWPairPassVC new];
        vc.userModel = userModel;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    } failure:^(NSString *error) {
        
    }];
}

-(void)messageRead{
    if (self.type == 0) {
        NSString *str = @"";
        for (XWMessageModel *model in self.dataSourceArr) {
            if ([str isEqualToString:@""]) {
                
                str = model.msg_id.stringValue;
            }else{
                str = [NSString stringWithFormat:@"%@,%@",str,model.msg_id];
            }
        }
        
        [FGHttpManager postWithPath:@"api/message/read" parameters:@{@"ids":str} success:^(id responseObject) {
       
            
        } failure:^(NSString *error) {
            
        }];
    }
}

-(void)relieveWithUid:(NSString *)uid{
    WeakSelf
    NSLog(@"token:%@",[FGCacheManager sharedInstance].token);
    [FGHttpManager getWithPath:[NSString stringWithFormat:@"api/match/relieve/%@",uid] parameters:@{} success:^(id responseObject) {
        StrongSelf
        [self showCompletionHUDWithMessage:@"解除成功" completion:^{
            
            [self beginRefresh];
        }];
    } failure:^(NSString *error) {
        [self showTextHUDWithMessage:error.description];
    }];
}
-(void)black_cancelWithUid:(NSString *)uid{
    WeakSelf
    NSLog(@"token:%@",[FGCacheManager sharedInstance].token);
    [FGHttpManager getWithPath:[NSString stringWithFormat:@"api/black/cancel/%@",uid] parameters:@{} success:^(id responseObject) {
        StrongSelf
        [self showCompletionHUDWithMessage:@"移除成功" completion:^{
            
            [self beginRefresh];
        }];
    } failure:^(NSString *error) {
        [self showTextHUDWithMessage:error.description];
    }];
    
}

-(void)getFriendsWithUid:(NSString *)uid{
    [FGHttpManager getWithPath:[NSString stringWithFormat:@"api/friend/info/%@",uid] parameters:@{} success:^(id responseObject) {
        XWFriendsInformationVC *vc = [XWFriendsInformationVC new];
        vc.isDynamic = YES;
        vc.userModel = [FGUserModel modelWithJSON:responseObject];
        vc.userModel.uid = uid;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSString *error) {
        
    }];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 2 || self.type == 3) {
        return YES;
    }
    return NO;
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle ==UITableViewCellEditingStyleDelete) {
        
        //如果编辑样式为删除样式if (indexPath.row<[self.arrayOfRows count]) {[self.arrayOfRows removeObjectAtIndex:indexPath.row];//移除数据源的数据[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];//移除tableView中的数据}
        if (self.type == 3) {
            XWPassModel *model = [self.dataSourceArr objectAtIndex:indexPath.row];
            [self relieveWithUid:model.match_id.stringValue];
        }else if (self.type == 2){
            FGUserModel *model = [self.dataSourceArr objectAtIndex:indexPath.row];
            [self black_cancelWithUid:model.b_uid];
        }
    
    
}}
    
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 3) {
        return @"解除\n速配关系";
    }
    return @"移除\n黑名单";
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
