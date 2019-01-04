//
//  XWPairTipView.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/4.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWPairTipView.h"
@interface XWPairTipView()
@property (nonatomic,strong)UIButton *dissBtn;
@property (nonatomic,strong)UIButton *lockBtn;

@property (nonatomic,strong)UILabel *tileLabel;
@property (nonatomic,strong)UILabel *contentLabel;

@property (nonatomic,strong)UIButton *setBtn;


@property (nonatomic,strong)UIView *backGroundView;
@end
@implementation XWPairTipView


-(void)setupViews{
    self.backgroundColor = UIColorFromHex(0xffffff);
    [self fg_cornerRadius:AdaptedWidth(7) borderWidth:0 borderColor:0];
    
    
    self.dissBtn = [UIButton fg_imageString:@"icon_close" imageStringSelected:@"icon_close"];
    [self addSubview:self.dissBtn];
    [self.dissBtn addTarget:self action:@selector(remove) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.lockBtn = [UIButton fg_imageString:@"icon_lock" imageStringSelected:@"icon_lock"];
    [self addSubview:self.lockBtn];
    
    
    
    self.tileLabel = [UILabel fg_text:@"您还没有设置通关口令" fontSize:16 colorHex:0x333333];
    [self addSubview:self.tileLabel];
    self.tileLabel.textAlignment = NSTextAlignmentCenter;

    
    
    self.contentLabel = [UILabel fg_text:@"需要设置通关口令才能速配好友哦~" fontSize:13 colorHex:0x999999];
    [self addSubview:self.contentLabel];
//    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    
    
    self.setBtn = [UIButton fg_title:@"去设置" fontSize:16 titleColorHex:0x333333];
    self.setBtn.backgroundColor = UIColorFromHex(0xFFDD00);
    [self addSubview:self.setBtn];
    
}
-(void)setupLayout{
    [self.dissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedHeight(18));
        make.right.offset(AdaptedWidth(-18));
    }];
    
    [self.lockBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(AdaptedHeight(35));
    }];
    
    
    [self.tileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.lockBtn.mas_bottom).offset(AdaptedHeight(24));
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.tileLabel.mas_bottom).offset(AdaptedHeight(12));
    }];
    
    [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(AdaptedHeight(28));
        make.bottom.offset(0);
        make.height.mas_equalTo(AdaptedHeight(50));
    }];
    
    
}

-(void)showInView:(UIView *)view{
    self.backGroundView = [UIView new];
    self.backGroundView.backgroundColor = UIColorFromHexWithAlpha(0x000000, 0.5);
    [view addSubview:self.backGroundView];
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(AdaptedHeight(0));
        make.left.offset(AdaptedWidth(74));
        make.right.offset(AdaptedWidth(-74));
    }];
}

-(void)remove{
    [self.backGroundView removeFromSuperview];
    [self removeFromSuperview];
}

@end
