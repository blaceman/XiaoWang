//
//  XWPairPassView.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/5.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWPairPassView.h"
@interface XWPairPassView()
@property (nonatomic,strong)UIButton *avaterMine;
@property (nonatomic,strong)UIButton *avaterOther;






@end
@implementation XWPairPassView

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
    
    self.subLabel = [UILabel fg_text:@"恭喜你们成为好友！开始聊天吧" fontSize:14 colorHex:0x666666];
    [self addSubview:self.subLabel];
    
    self.sendBtn = [UIButton fg_title:@"发送消息" fontSize:16 titleColorHex:0x000000];
    self.sendBtn.backgroundColor = UIColorFromHex(0xFFE616);
    [self.sendBtn fg_cornerRadius:AdaptedHeight(20) borderWidth:0 borderColor:0];
    [self addSubview:self.sendBtn];

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
//        make.bottom.offset(AdaptedHeight(-53));
    }];
    
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(AdaptedHeight(15));
        make.centerX.offset(0);

    }];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subLabel.mas_bottom).offset(AdaptedHeight(43));
        make.left.offset(AdaptedWidth(37));
        make.right.offset(AdaptedWidth(-37));
        make.bottom.offset(AdaptedHeight(-46));
        make.height.mas_equalTo(AdaptedHeight(40));
        
    }];
    
}

-(void)showInView:(UIView *)view{
    self.backGroundView = [UIView new];
    WeakSelf
//    [self.backGroundView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
//        StrongSelf
//        [self remove];
//
//    }];
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

-(void)configWithModel:(id)model{
    FGUserModel *userModel = model;
    [self.avaterMine setImageWithURL:[NSURL URLWithString:[FGCacheManager sharedInstance].userModel.avatar] forState:(UIControlStateNormal) placeholder:UIImageWithName(@"icon_head2")];
    
    [self.avaterOther setImageWithURL:[NSURL URLWithString:userModel.avatar] forState:(UIControlStateNormal) placeholder:UIImageWithName(@"icon_head2")];
}
@end
