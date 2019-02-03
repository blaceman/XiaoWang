//
//  XWChatVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/2/3.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWChatVC.h"
#import "FGNavPopMenuView.h"

@interface XWChatVC ()
@property (strong, nonatomic)  FGNavPopMenuView *showView;
@property (nonatomic, strong) UIControl *maskView;

@property (assign, nonatomic)  BOOL  isShow;
@end

@implementation XWChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:self.userModel.nickname];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset(NavigationHeight_N());
    }];
    WeakSelf
    [self.navigationView addRightButtonWithImage:UIImageWithName(@"icon_pot") clickCallBack:^(UIView *view) {
        StrongSelf
        self.isShow = !self.isShow;
        
        if (self.isShow) {
            self.maskView.hidden = NO;
            [self.showView showView];
            
        }else{
            self.maskView.hidden = YES;
            [self.showView dismissView];
        }
    }];
    
    
    self.showView = [[FGNavPopMenuView alloc]initWithFrame:(CGRect){CGRectGetWidth(self.view.frame)-120-10,5 + kNavBarHeight,120,0}
                                                     items:@[@"加入黑名单", @"举报"]
                                                 showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-25,10 + kNavBarHeight}];
    
    self.showView.sq_backGroundColor = [UIColor blackColor];
    self.showView.itemTextColor = UIColorFromHex(0xffffff);
    
    [kKeyWindow addSubview:self.showView];
    
    
    [self.showView selectBlock:^(FGNavPopMenuView *view, NSInteger index) {
        if (index == 0) {
            [self de_friendWithuid:self.userModel.f_uid];
        }else if (index == 1){
            [self reportWithuid:self.userModel.f_uid];
        }
    }];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.maskView.hidden = YES;
//    [self.showView dismissView];
    
}

- (UIControl *)maskView
{
    if (!_maskView) {
        _maskView = [UIControl new];
        _maskView.backgroundColor = [UIColor clearColor];
        //        [_maskView addTarget:self action:@selector(RightBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
        _maskView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
    return _maskView;
}
-(void)de_friendWithuid:(NSNumber *)uid{
    [FGHttpManager getWithPath:[NSString stringWithFormat:@"api/black/de_friend/%@",uid] parameters:@{} success:^(id responseObject) {
        [self showTextHUDWithMessage:@"加入黑名单成功"];
    } failure:^(NSString *error) {
        [self showTextHUDWithMessage:error.description];
    }];
}
-(void)reportWithuid:(NSNumber *)uid{
    [FGHttpManager getWithPath:[NSString stringWithFormat:@"api/black/report/%@",uid] parameters:@{} success:^(id responseObject) {
        [self showTextHUDWithMessage:@"举报成功"];
    } failure:^(NSString *error) {
        [self showTextHUDWithMessage:error.description];
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
