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
#import "XWStepModel.h"
#import "XWChatVC.h"
@interface XWPairPassVC ()
@property (nonatomic,strong)UIButton *tipBtn;

@property (nonatomic,strong)RACDisposable *dispoable;

@property (nonatomic,strong)RACDisposable *stepDispoable;

@property (nonatomic, strong) XWPairBodyView *bodyView;  ///< <#Description#>
@property (nonatomic, assign) NSInteger time;  ///< <#Description#>

@property (nonatomic,strong)XWStepModel *stepModel;

@property (nonatomic,assign)BOOL isAnswer;

@end

@implementation XWPairPassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"速配通关"];
    self.view.backgroundColor = UIColorFromHex(0xffffff);
    
    XWPairHeaderView *headerView = [XWPairHeaderView new];
    if (self.userModel) {
        [headerView configWithModel:self.userModel];

    }else if (self.messageModel){
        [headerView configWithModel:self.messageModel];

    }
    [self.bgScrollView.contentView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
    }];
    
    XWPairBodyView *bodyView = [XWPairBodyView new];
    if (self.userModel) {
        [bodyView configWithModel:self.userModel];

    }else if (self.messageModel){
        [bodyView configWithModel:self.messageModel];

    }
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
        [self passAnswerData];
        
    }];
    
    UIButton *tipBtn = [UIButton fg_title:@"" fontSize:13 titleColorHex:0x666666];
    self.tipBtn = tipBtn;
    self.tipBtn.hidden = YES;
    [self.bgScrollView.contentView addSubview:tipBtn];
    [tipBtn setImage:UIImageWithName(@"") forState:(UIControlStateNormal)];
    [tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(bodyView.mas_bottom).offset(AdaptedHeight(0));
        make.bottom.offset(AdaptedHeight(0));
    }];
    tipBtn.hidden = YES;
    [self countDown];//倒数
    [self setMachedStep];//匹配进度
    
    
    self.navigationView.navigationBackButtonCallback = ^(UIView *view) {
        StrongSelf
        [self quitMatch];
        [self.navigationController popViewControllerAnimated:YES];
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)countDown{
    //30秒定时器
    self.tipBtn.hidden = NO;
//    [self.tipBtn setImage:nil forState:(UIControlStateNormal)];
//    [self.tipBtn setTitle:[NSString stringWithFormat:@"开始答题"] forState:(UIControlStateNormal)];
    self.time = kAppDelegate.countDowmTime;
    
    WeakSelf
   self.dispoable = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
       StrongSelf
       self.bodyView.countDowmLabel.text = [NSString stringWithFormat:@"倒计时 %ld",self.time];
       self.time--;
       if (self.time == 0) {
           //通关失败
           [self.dispoable dispose];
           [self matchStatusViewWithStatus:3 isMe:YES];
       }
    }];
}


-(void)passAnswerData{
    WeakSelf
    [FGHttpManager postWithPath:@"api/match/answer" parameters:@{@"answer":self.bodyView.answerField.text,@"match_id":self.userModel.match_id ?self.userModel.match_id : self.messageModel.match_id} success:^(id responseObject) {
        StrongSelf
      

        [self.view endEditing:YES];
        [self.dispoable dispose];

        NSNumber *status = [responseObject valueForKey:@"result"];
        if (status.integerValue == 1) { //回答正确
            self.isAnswer = YES;
            if (self.stepModel.code.integerValue == -1) {
                [self showTextHUDWithMessage:@"已答对,等待对方回答"];
                
                return ;
            }else if (self.stepModel.code.integerValue == 0){
                [self showTextHUDWithMessage:@"已答对,对方回答中"];
                return;
            }else if(self.stepModel.code.integerValue == 1){//对方回答成功
                [self matchStatusViewWithStatus:1 isMe:YES]; //回答成功
                return;
            }else if(self.stepModel.code.integerValue == 2){
                [self matchStatusViewWithStatus:2 isMe:YES];
            }else if (self.stepModel.code.integerValue == 3){
                [self matchStatusViewWithStatus:3 isMe:YES];

            }
        }else{//回答失败
            [self matchStatusViewWithStatus:2 isMe:YES];
        }
        
       
        
    } failure:^(NSString *error) {
        [self showTextHUDWithMessage:error.description];
//        [self.tipBtn setTitle:[NSString stringWithFormat:@"答案错误,请继续答题...."] forState:(UIControlStateNormal)];
    }];
    
}


-(void)dealloc{
    [self.dispoable dispose];
    [self.stepDispoable dispose];
}

-(void)setMachedStep{
    WeakSelf
    self.stepDispoable = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        StrongSelf
        [FGHttpManager getWithPath:[NSString stringWithFormat:@"api/match/info/%@",self.userModel.match_id] parameters:@{} success:^(id responseObject) {
            XWStepModel *stepModel = [XWStepModel modelWithJSON:responseObject];
            self.stepModel = stepModel;
            if (stepModel.code.integerValue == -1) {
                [self.tipBtn setImage:nil forState:(UIControlStateNormal)];
                [self.tipBtn setTitle:[NSString stringWithFormat:@"等待对方答题"] forState:(UIControlStateNormal)];
            }else if (stepModel.code.integerValue == 0){
                [self.tipBtn setImage:nil forState:(UIControlStateNormal)];
                [self.tipBtn setTitle:[NSString stringWithFormat:@"对方答题中"] forState:(UIControlStateNormal)];
            }else if (stepModel.code.integerValue == 1){
                [self.tipBtn setImage:UIImageWithName(@"icon_adopt") forState:(UIControlStateNormal)];
                [self.tipBtn setTitle:[NSString stringWithFormat:@"对方答题正确"] forState:(UIControlStateNormal)];
                if (self.isAnswer) {
                    [self matchStatusViewWithStatus:1 isMe:NO];
                    [self.stepDispoable dispose];
                }
            }else if (stepModel.code.integerValue == 2){
                [self.tipBtn setImage:nil forState:(UIControlStateNormal)];
                [self.tipBtn setTitle:[NSString stringWithFormat:@"对方答题错误"] forState:(UIControlStateNormal)];
                [self matchStatusViewWithStatus:2 isMe:NO];
                [self.stepDispoable dispose];
            }else if (stepModel.code.integerValue == 3){
                [self.tipBtn setImage:nil forState:(UIControlStateNormal)];
                [self.tipBtn setTitle:[NSString stringWithFormat:@"对方答题超时"] forState:(UIControlStateNormal)];
                [self matchStatusViewWithStatus:3 isMe:NO];
                [self.stepDispoable dispose];
            }
        } failure:^(NSString *error) {
            
        }];
        
    }];
}

-(void)quitMatch{
    [FGHttpManager getWithPath:[NSString stringWithFormat:@"api/match/give_up/%@",self.userModel.match_id] parameters:@{} success:^(id responseObject) {
        
    } failure:^(NSString *error) {
        
    }];
}

-(void)matchStatusViewWithStatus:(NSInteger )status isMe:(BOOL)isme{
    WeakSelf
    XWPairPassView *tipView = [XWPairPassView new];
    if (self.userModel) {
        [tipView configWithModel:self.userModel];
        
    }else if (self.messageModel){
        [tipView configWithModel:self.messageModel];
        
    }
    
    if (status == 1) {
        tipView.contentLabel.text = @"速配通关成功！";
        [tipView.loadBtn setImage:UIImageWithName(@"icon_adopt") forState:(UIControlStateNormal)];
        tipView.subLabel.text = @"恭喜你们成为好友！开始聊天吧";
        [tipView.sendBtn setTitle:@"发送消息" forState:(UIControlStateNormal)];

    }else if(status == 2){
        tipView.contentLabel.text = @"速配通关失败！";
        [tipView.loadBtn setImage:UIImageWithName(@"icon_fail") forState:(UIControlStateNormal)];
        tipView.subLabel.text = isme ? @"回答错误,没关系,继续加油" : @"对方回答错误,答题结束";
        [tipView.sendBtn setTitle:@"返回首页" forState:(UIControlStateNormal)];
    }else if(status == 3){
        tipView.contentLabel.text = @"速配通关失败！";
        tipView.subLabel.text = isme ?@"回答超时,没关系,继续加油" : @"对方回答超时,答题结束";
        [tipView.loadBtn setImage:UIImageWithName(@"icon_fail") forState:(UIControlStateNormal)];
        [tipView.sendBtn setTitle:@"返回首页" forState:(UIControlStateNormal)];
    }
    Weakify(tipView);

    [tipView.backGroundView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        Strongify(tipView)
        [tipView remove];
    }];
    //发送消息
    [[tipView.sendBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)]subscribeNext:^(__kindof UIControl * _Nullable x) {
        StrongSelf
        //发送消息
       
        if (status == 1) {
            NSLog(@"uid:%@",[FGCacheManager sharedInstance].userModel.uid);
            NIMSession *session = [NIMSession session:self.userModel ? self.userModel.uid : self.messageModel.uid type:NIMSessionTypeP2P];
            XWChatVC *vc = [[XWChatVC alloc] initWithSession:session];
            vc.userModel = self.userModel;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
            [self quitMatch];
        }
       
    }];
    
    if (status == 1) {
        [tipView.backGroundView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            StrongSelf
            Strongify(tipView)
            [tipView remove];
        }];
    }
  
    [tipView showInView:self.navigationController.view];
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
