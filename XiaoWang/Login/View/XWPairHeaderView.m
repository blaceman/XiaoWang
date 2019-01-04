//
//  XWPairHeaderView.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/4.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWPairHeaderView.h"
@interface XWPairHeaderView()
@property (nonatomic,strong)UIButton *avaterBtn;
@property (nonatomic,strong)UIButton *genderBtn;

@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *numLabel;

@property (nonatomic,strong)UIButton *addressBtn;


@end
@implementation XWPairHeaderView

-(void)setupViews{
    self.backgroundColor = UIColorFromHex(0xffffff);

    
    
    self.avaterBtn = [UIButton fg_imageString:@"icon_head2" imageStringSelected:@"icon_head2"];
    [self addSubview:self.avaterBtn];
   
    self.nameLabel = [UILabel fg_text:@"恋恋Baby" fontSize:16 colorHex:0x333333];
    [self addSubview:self.nameLabel];
    
    
    
    self.genderBtn = [UIButton fg_imageString:@"icon_female" imageStringSelected:@"icon_female"];
    [self addSubview:self.genderBtn];
    
    
    
    self.addressBtn = [UIButton fg_title:@"  南昌市 距离1.5km" fontSize:13 titleColorHex:0x999999];
    [self.addressBtn setImage:UIImageWithName(@"icon_coordinates") forState:(UIControlStateNormal)];
    [self addSubview:self.addressBtn];
    
    
    
    self.numLabel = [UILabel fg_text:@"小网号：646417" fontSize:13 colorHex:0x999999];
    [self addSubview:self.numLabel];
    //    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.numLabel];
    
    
    
}
-(void)setupLayout{
    [self.avaterBtn fg_cornerRadius:AdaptedWidth(50) borderWidth:0 borderColor:0];
    [self.avaterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedHeight(20));
        make.centerX.offset(0);
        make.width.height.mas_equalTo(AdaptedWidth(100));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.avaterBtn.mas_bottom).offset(AdaptedHeight(12));
    }];
    
    
    [self.genderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel).offset(0);
        make.left.equalTo(self.nameLabel.mas_right).offset(AdaptedHeight(10));
    }];
    
    [self.addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AdaptedWidth(73));
        make.top.equalTo(self.nameLabel.mas_bottom).offset(AdaptedHeight(12));
    }];
    
    UIView *lineView  = [UIView new];
    [self addSubview:lineView];
    lineView.backgroundColor = UIColorFromHex(kColorLine);
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.centerY.equalTo(self.addressBtn);
        make.left.equalTo(self.addressBtn.mas_right).offset(AdaptedWidth(21));
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.addressBtn);
        make.left.equalTo(self.addressBtn.mas_right).offset(AdaptedWidth(43));
        make.bottom.offset(AdaptedHeight(-22));
    }];
    
    
}

@end
