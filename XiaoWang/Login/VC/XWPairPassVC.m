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


@interface XWPairPassVC ()

@end

@implementation XWPairPassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"速配通关"];
    
    XWPairHeaderView *headerView = [XWPairHeaderView new];
    [self.bgScrollView.contentView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
    }];
    
    XWPairBodyView *bodyView = [XWPairBodyView new];
    [self.bgScrollView.contentView addSubview:bodyView];
    [bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView.mas_bottom).offset(AdaptedHeight(7));
        make.left.right.offset(0);

    }];
    WeakSelf
    [[bodyView.commitBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)]subscribeNext:^(__kindof UIControl * _Nullable x) {
        StrongSelf
        XWPairPassView *tipView = [XWPairPassView new];
        [tipView showInView:self.navigationController.view];
        
    }];
    
    UIButton *tipBtn = [UIButton fg_title:@"  对方已答对，用时23秒" fontSize:13 titleColorHex:0x666666];
    [self.bgScrollView.contentView addSubview:tipBtn];
    [tipBtn setImage:UIImageWithName(@"icon_adopt") forState:(UIControlStateNormal)];
    [tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(bodyView.mas_bottom).offset(AdaptedHeight(20));
        make.bottom.offset(AdaptedHeight(-20));
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
