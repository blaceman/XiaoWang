//
//  XWFriendsInformationVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/7.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWFriendsInformationVC.h"
#import "HYHomeTCell.h"
#import "XWPairHeaderView.h"

@interface XWFriendsInformationVC ()

@end

@implementation XWFriendsInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"好友信息"];
    [self setupEstimatedRowHeight:100 cellClasses:@[[HYHomeTCell class]]];
    [self headerViewSet];
    [self beginRefresh];
    
}
-(void)requestDataWithOffset:(NSInteger)offset success:(void (^)(NSArray *))success failure:(void (^)(NSString *))failure{
    success(@[@"",@"",@"",@""]);
}
-(void)headerViewSet{
    XWPairHeaderView *headView = [XWPairHeaderView new];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth);
    }];
    [headView setNeedsLayout];
    [headView layoutIfNeeded];
    
    self.myTableView.tableHeaderView = headView;
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
    }];
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
