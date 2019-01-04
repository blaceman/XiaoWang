//
//  XWPairBodyView.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/5.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWPairBodyView.h"
@interface XWPairBodyView()
@property (nonatomic,strong)UIImageView *countDownImg;

@property (nonatomic,strong)UILabel *contentLabel;

@property (nonatomic,strong)UITextView *answerField;



@end
@implementation XWPairBodyView

-(void)setupViews{
    self.backgroundColor = UIColorFromHex(0xffffff);
    
    

    
    self.contentLabel = [UILabel fg_text:@"明明是个近视眼，也是个出名的馋小子，在他面前放一堆书，放一个苹果，他会先看什么?" fontSize:16 colorHex:0x333333];
    self.contentLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 22, 0, 22);
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.textAlignment = NSTextAlignmentCenter;

    [self.contentLabel addAllLine];
    [self addSubview:self.contentLabel];
    
    
    self.countDownImg = [UIImageView fg_imageString:@"icon_count"];
    [self addSubview:self.countDownImg];
    
    
    self.answerField = [[UITextView alloc] init];
    self.answerField.backgroundColor = UIColorFromHex(0xFCFCFC);
    [self.answerField addAllLine];
    self.answerField.textAlignment = NSTextAlignmentCenter;
    self.answerField.font = AdaptedFontSize(16);
    self.answerField.textColor = UIColorFromHex(0x999999);
    [self.answerField jk_addPlaceHolder:@"请输入你的答案"];
    [self addSubview:self.answerField];
    
    
    
    self.commitBtn = [UIButton fg_title:@"提交答案" fontSize:16 titleColorHex:0x000000];
    [self addSubview:self.commitBtn];
    self.commitBtn.backgroundColor = UIColorFromHex(0xFFE616);
    [self.commitBtn fg_cornerRadius:AdaptedHeight(20) borderWidth:0 borderColor:0];
    
    
    

    
    
    
}
-(void)setupLayout{
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedHeight(49));
        make.left.offset(AdaptedWidth(17));
        make.right.offset(AdaptedWidth(-17));
        make.height.mas_equalTo(AdaptedWidth(120));
    }];
    
    [self.countDownImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.centerY.equalTo(self.contentLabel.mas_top);
    }];
    
    
    [self.answerField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentLabel);
        make.top.equalTo(self.contentLabel.mas_bottom);
        make.height.mas_equalTo(AdaptedHeight(122));
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AdaptedWidth(44));
        make.right.offset(AdaptedWidth(-44));
        make.top.equalTo(self.answerField.mas_bottom).offset(AdaptedHeight(33));
        make.height.mas_equalTo(AdaptedHeight(40));
        make.bottom.offset(AdaptedWidth(-44));

    }];
    
   
    
    
}


@end
