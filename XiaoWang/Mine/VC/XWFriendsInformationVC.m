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
#import "XWLabelView.h"
#import "XWLableListModel.h"
#import "FGNavPopMenuView.h"

@interface XWFriendsInformationVC ()
@property (strong, nonatomic)  FGNavPopMenuView *showView;
@property (nonatomic, strong) UIControl *maskView;

@property (assign, nonatomic)  BOOL  isShow;

@end

@implementation XWFriendsInformationVC

- (void)viewDidLoad {
    [self headerViewSet];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"好友信息"];
    [self setupEstimatedRowHeight:100 cellClasses:@[[HYHomeTCell class]]];
    [self beginRefresh];
    
    [((UIView *)self.navigationView.rightViewArray.firstObject) removeFromSuperview];
    [self.navigationView.rightViewArray removeAllObjects];
    if (!((self.userModel.uid.integerValue == [FGCacheManager sharedInstance].userModel.uid.integerValue))) {
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
    }
    self.showView = [[FGNavPopMenuView alloc]initWithFrame:(CGRect){CGRectGetWidth(self.view.frame)-120-10,5 + kNavBarHeight,120,0}
                                                     items:@[@"加入黑名单", @"举报"]
                                                 showPoint:(CGPoint){CGRectGetWidth(self.view.frame)-25,10 + kNavBarHeight}];
    
    self.showView.sq_backGroundColor = [UIColor blackColor];
    self.showView.itemTextColor = UIColorFromHex(0xffffff);
    
    [kKeyWindow addSubview:self.showView];
    
    
    [self.showView selectBlock:^(FGNavPopMenuView *view, NSInteger index) {
        if (index == 0) {
            [self de_friendWithuid:self.userModel.uid];
        }else if (index == 1){
            [self reportWithuid:self.userModel.uid];
        }
    }];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.dataSourceArr.count) {
        return AdaptedHeight(35);
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [UILabel fg_text:@"  相册" fontSize:13 colorHex:0x3A75FD];
    label.backgroundColor = UIColorFromHex(kColorBG);
    return label;
}

-(void)headerViewSet{
    UIView *tableViewHeadView = [UIView new];
    
    
    XWPairHeaderView *headView = [XWPairHeaderView new];
    [headView configWithModel:self.userModel];
    [tableViewHeadView addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        if (!self.userModel.labels.count) {
            make.bottom.offset(0);
        }
    }];
    
    if (self.userModel.labels.count) {
        UILabel *tipLabel = [UILabel fg_text:@"  个性标签" fontSize:13 colorHex:0x3A75FD];
        tipLabel.backgroundColor = UIColorFromHex(kColorBG);
        [tableViewHeadView addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.top.equalTo(headView.mas_bottom).offset(0);
            make.height.mas_equalTo(AdaptedHeight(35));
        }];
        
        
        
        XWLabelView *labelView = [[XWLabelView alloc]initWithDataSource:self.userModel.labels title:@"" isMore:YES];
        labelView.userInteractionEnabled = NO;
        [tableViewHeadView addSubview:labelView];
        [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.bottom.offset(0);
            make.top.equalTo(tipLabel.mas_bottom);
        }];
    }
   
    
    [tableViewHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    [tableViewHeadView setNeedsLayout];
    [tableViewHeadView layoutIfNeeded];
    self.myTableView.tableHeaderView = tableViewHeadView;
    [tableViewHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)de_friendWithuid:(NSString *)uid{
    [FGHttpManager getWithPath:[NSString stringWithFormat:@"api/black/de_friend/%@",uid] parameters:@{} success:^(id responseObject) {
        [self showTextHUDWithMessage:@"加入黑名单成功"];
    } failure:^(NSString *error) {
        [self showTextHUDWithMessage:error.description];
    }];
}
-(void)reportWithuid:(NSString *)uid{
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
