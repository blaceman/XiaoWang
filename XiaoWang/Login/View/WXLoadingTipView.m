//
//  WXLoadingTipView.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/4.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "WXLoadingTipView.h"

@interface WXLoadingTipView()
@property (nonatomic,strong)UIButton *avaterMine;
@property (nonatomic,strong)UIButton *avaterOther;
@property (nonatomic,strong)UIButton *loadBtn;


@property (nonatomic,strong)UILabel *contentLabel;



@property (nonatomic,strong)UIView *backGroundView;
@end

@implementation WXLoadingTipView


-(void)setupViews{
    self.backgroundColor = UIColorFromHex(0xffffff);
    [self fg_cornerRadius:AdaptedWidth(7) borderWidth:0 borderColor:0];
    
    
    self.avaterMine = [UIButton fg_imageString:@"icon_head2" imageStringSelected:@"icon_head2"];
    [self addSubview:self.avaterMine];

    
    self.avaterOther = [UIButton fg_imageString:@"icon_head2" imageStringSelected:@"icon_head2"];
    [self addSubview:self.avaterOther];
    
    self.loadBtn = [UIButton fg_imageString:@"icon_loading" imageStringSelected:@"icon_loading"];
    [self addSubview:self.loadBtn];
    
    
    
    
    self.contentLabel = [UILabel fg_text:@"小网速配中……" fontSize:19 colorHex:0x333333];
    [self addSubview:self.contentLabel];
    //    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    
    
   
    
}
-(void)setupLayout{
    [self.avaterMine fg_cornerRadius:AdaptedWidth(50) borderWidth:0 borderColor:0];
    [self.avaterMine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedHeight(45));
        make.left.offset(AdaptedWidth(38));
        make.width.height.mas_equalTo(AdaptedWidth(100));
    }];
    
    [self.avaterOther fg_cornerRadius:AdaptedWidth(50) borderWidth:0 borderColor:0];
    [self.avaterOther mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedHeight(45));
        make.right.offset(AdaptedWidth(-38));
        make.width.height.mas_equalTo(AdaptedWidth(100));
    }];
    
    [self.loadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avaterMine);
        make.centerX.offset(0);
    }];
  
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.avaterMine.mas_bottom).offset(AdaptedHeight(44));
        make.bottom.offset(AdaptedHeight(-53));
    }];
    
   
    
    
}

-(void)showInView:(UIView *)view{
    self.backGroundView = [UIView new];
    WeakSelf
    [self.backGroundView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        StrongSelf
        [self remove];
        
    }];
    self.backGroundView.backgroundColor = UIColorFromHexWithAlpha(0x000000, 0.5);
    [view addSubview:self.backGroundView];
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.offset(AdaptedHeight(0));
        make.left.offset(AdaptedWidth(47));
        make.right.offset(AdaptedWidth(-47));
    }];
}

-(void)remove{
    [self.backGroundView removeFromSuperview];
    [self removeFromSuperview];
}

@end
