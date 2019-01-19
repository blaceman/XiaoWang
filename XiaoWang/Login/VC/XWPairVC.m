//
//  XWPairVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/4.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWPairVC.h"
#import "XWPairTipView.h"
#import "WXLoadingTipView.h"
#import "XWPairPassVC.h"
#import "XWMineVC.h"
#import "XWNewsVC.h"

@interface XWPairVC ()

@end

@implementation XWPairVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"小网"];
    UIImageView *img = [UIImageView fg_imageString:@"pic_home"];
//    img.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.top.offset(0);
        make.center.offset(0);
    }];
    
    UIButton *contactBtn = [UIButton fg_imageString:@"icon_mine" imageStringSelected:@"icon_mine"];
    contactBtn.tag = 0;
    [self.view addSubview:contactBtn];
    [contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(AdaptedHeight(-25));
        make.left.offset(AdaptedWidth(33));
    }];
    [contactBtn addTarget:self action:@selector(pairBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *goBtn = [UIButton fg_imageString:@"icon_start" imageStringSelected:@"icon_start"];
    goBtn.tag = 1;
    [self.view addSubview:goBtn];
    [goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(AdaptedHeight(-25));
        make.centerX.offset(0);
    }];
    [goBtn addTarget:self action:@selector(pairBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *messageBtn = [UIButton fg_imageString:@"icon_news" imageStringSelected:@"icon_news"];
    messageBtn.tag = 2;
    [self.view addSubview:messageBtn];
    [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(AdaptedHeight(-25));
        make.right.offset(AdaptedWidth(-33));
    }];
    [messageBtn addTarget:self action:@selector(pairBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIButton *pairBtn = [UIButton fg_title:@"速配通关" fontSize:16 titleColorHex:0x000000];
    pairBtn.tag = 3;
    pairBtn.backgroundColor = UIColorFromHex(0xFFE616);
    [pairBtn fg_cornerRadius:AdaptedHeight(20) borderWidth:0 borderColor:0];
    [self.view addSubview:pairBtn];
    [pairBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.bottom.equalTo(goBtn.mas_bottom).offset(AdaptedHeight(-52));
        make.width.mas_equalTo(AdaptedWidth(158));
        make.height.mas_equalTo(AdaptedHeight(40));
    }];
    
    [pairBtn addTarget:self action:@selector(pairBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)pairBtnAction:(UIButton *)sender{
    if (sender.tag == 0) { //我的主页
        XWMineVC *vc = [XWMineVC new];
        [self.navigationController pushViewController:vc animated:YES];
        
        
//        XWPairTipView *tipView = [XWPairTipView new];
//        [tipView showInView:self.navigationController.view];
    }else if (sender.tag == 1){ //筛选条件
        WXLoadingTipView *tipView = [WXLoadingTipView new];
        [tipView showInView:self.navigationController.view];
    }else if (sender.tag == 2){ //消息页面
        XWNewsVC *vc = [XWNewsVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 3){//速配通关
        XWPairPassVC *vc = [XWPairPassVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
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
