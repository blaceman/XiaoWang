//
//  XWPairPassVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/4.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWPairPassVC.h"
#import "XWPairHeaderView.h"
#import "XWPairBodyView.h"
#import "XWPairPassView.h"
#import "XWMineVC.h"
#import "XWMineVC.h"
#import "XWPairPassView.h"
#import <NIMKit.h>

@interface XWPairPassVC ()
@property (nonatomic,strong)UIButton *tipBtn;

@property (nonatomic,strong)RACDisposable *dispoable;
@property (nonatomic, strong) XWPairBodyView *bodyView;  ///< <#Description#>
@property (nonatomic, assign) NSInteger time;  ///< <#Description#>

@end

@implementation XWPairPassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"速配通关"];
    
    XWPairHeaderView *headerView = [XWPairHeaderView new];
    [headerView configWithModel:self.userModel];
    [self.bgScrollView.contentView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
    }];
    
    XWPairBodyView *bodyView = [XWPairBodyView new];
    [bodyView configWithModel:self.userModel];
    self.bodyView = bodyView;
    [self.bgScrollView.contentView addSubview:bodyView];
    [bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(AdaptedHeight(7));
        make.left.right.offset(0);

    }];
    //提交按钮
    WeakSelf
    [[bodyView.commitBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)]subscribeNext:^(__kindof UIControl * _Nullable x) {
        StrongSelf
//        XWPairPassView *tipView = [XWPairPassView new];
//        [tipView showInView:self.navigationController.view];
        [self passAnswerData];
//        XWMineVC *vc = [XWMineVC new];
//        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    UIButton *tipBtn = [UIButton fg_title:@"  对方已答对，用时23秒" fontSize:13 titleColorHex:0x666666];
    self.tipBtn = tipBtn;
    self.tipBtn.hidden = YES;
    [self.bgScrollView.contentView addSubview:tipBtn];
    [tipBtn setImage:UIImageWithName(@"icon_adopt") forState:(UIControlStateNormal)];
    [tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(bodyView.mas_bottom).offset(AdaptedHeight(20));
        make.bottom.offset(AdaptedHeight(-20));
    }];
    tipBtn.hidden = YES;
    [self countDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)countDown{
    //30秒定时器
    self.tipBtn.hidden = NO;
    [self.tipBtn setImage:nil forState:(UIControlStateNormal)];
    [self.tipBtn setTitle:[NSString stringWithFormat:@"开始答题"] forState:(UIControlStateNormal)];
    self.time = kAppDelegate.countDowmTime;
    
    WeakSelf
   self.dispoable = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
       StrongSelf
       self.bodyView.countDowmLabel.text = [NSString stringWithFormat:@"倒计时 %ld",self.time];
       self.time--;
       if (self.time == 0) {
           //通关失败
           [self.dispoable dispose];
           XWPairPassView *tipView = [XWPairPassView new];
           [tipView configWithModel:self.userModel];
           [tipView.loadBtn setImage:UIImageWithName(@"icon_fail") forState:(UIControlStateNormal)];
           [tipView.sendBtn setTitle:@"返回首页" forState:(UIControlStateNormal)];
           Weakify(tipView);
           [[tipView.sendBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)]subscribeNext:^(__kindof UIControl * _Nullable x) {
               StrongSelf
               Strongify(tipView)
               [tipView remove];
               [self.navigationController popViewControllerAnimated:YES];
               
               self.tipBtn.hidden = NO;
               [self.tipBtn setImage:UIImageWithName(@"icon_fail") forState:(UIControlStateNormal)];
               [self.tipBtn setTitle:[NSString stringWithFormat:@"回答超时"] forState:(UIControlStateNormal)];
              
           }];
           tipView.subLabel.text = @"通关失败";
           [tipView showInView:self.navigationController.view];
       }
        
    }];
}


-(void)passAnswerData{
    WeakSelf
    [FGHttpManager postWithPath:@"api/match/answer" parameters:@{@"answer":self.bodyView.answerField.text,@"match_id":self.userModel.match_id} success:^(id responseObject) {
        StrongSelf
        //通关成功

        self.tipBtn.hidden = NO;
        [self.tipBtn setImage:UIImageWithName(@"icon_adopt") forState:(UIControlStateNormal)];
        [self.tipBtn setTitle:[NSString stringWithFormat:@"  对方已答对，用时%ld秒",kAppDelegate.countDowmTime - self.time] forState:(UIControlStateNormal)];
        [self.dispoable dispose];
        XWPairPassView *tipView = [XWPairPassView new];
        
        //发送消息
        Weakify(tipView);
        [[tipView.sendBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)]subscribeNext:^(__kindof UIControl * _Nullable x) {
            StrongSelf
            Strongify(tipView)
            //发送消息
            [tipView remove];
            
            NIMSession *session = [NIMSession session:self.userModel.uid type:NIMSessionTypeP2P];
            NIMSessionViewController *vc = [[NIMSessionViewController alloc] initWithSession:session];
            [self.navigationController pushViewController:vc animated:YES];
//            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [tipView.backGroundView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            StrongSelf
            Strongify(tipView)
            [tipView remove];
        }];
        [tipView showInView:self.navigationController.view];
        
    } failure:^(NSString *error) {
        
    }];
    
}

-(void)matchInfo{
    [FGHttpManager getWithPath:[NSString stringWithFormat:@"api/match/info/%@",self.userModel.match_id] parameters:@{} success:^(id responseObject) {
        
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
