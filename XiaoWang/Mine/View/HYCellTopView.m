//
//  HYCellTopView.m
//  hangyeshejiao
//
//  Created by Eric on 2018/4/4.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "HYCellTopView.h"
#import "NSString+FGDate.h"
#import <UIView+JKVisuals.h>
#import "NSString+FGDate.h"

@interface HYCellTopView ()

@property (nonatomic, strong) UIImageView *vImageView;  ///< 大V
//@property (nonatomic,strong)UILabel *statusInfoLabel; //大V 头衔

@property (nonatomic, strong) UILabel *timeLabel;  ///< <#Description#>

@end

@implementation HYCellTopView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}

- (void)setupViews
{
    self.avatarBtn = [UIButton fg_imageString:@"ic_default_avatar" imageStringSelected:nil];
    [self.avatarBtn fg_cornerRadius:AdaptedWidth(38)/2 borderWidth:0 borderColor:0];
    [self addSubview:self.avatarBtn];
    
    self.nameLabel = [UILabel fg_text:@" " fontSize:16 colorHex:0x848484];
    [self addSubview:self.nameLabel];
    
    self.vImageView = [UIImageView fg_imageString:@"ic_v_yellow"];
    [self addSubview:self.vImageView];
    
//    self.statusInfoLabel = [UILabel fg_text:@"" fontSize:13 colorHex:0xaaaaaa];
//    [self addSubview:self.statusInfoLabel];
    
    self.timeLabel = [UILabel fg_text:@" " fontSize:13 colorHex:0xaaaaaa];
    [self addSubview:self.timeLabel];
    
    self.followBtn = [UIButton fg_title:@"关注" fontSize:13 titleColorHex:0x999999];
    [self.followBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [self.followBtn setTitleColor:UIColorFromHex(0x999999) forState:UIControlStateSelected];
    [self addSubview:self.followBtn];
    WeakSelf
    [RACObserve(self.followBtn, selected) subscribeNext:^(NSNumber * _Nullable x) {
        StrongSelf
        if (x.boolValue) {
            [self.followBtn fg_cornerRadius:13 borderWidth:kOnePixel borderColor:0xaaaaaa];
        }else{
            [self.followBtn fg_cornerRadius:13 borderWidth:kOnePixel borderColor:0xaaaaaa];
        }
    }];
}

- (void)setupLayout
{
    [self.avatarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(AdaptedWidth(38));
        make.left.top.bottom.offset(AdaptedWidth(0));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarBtn);
        make.left.equalTo(self.avatarBtn.mas_right).offset(AdaptedWidth(14));
    }];
    
    [self.vImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).offset(AdaptedWidth(6));
    }];
    
//    [self.statusInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.vImageView);
//        make.left.equalTo(self.vImageView.mas_right).offset(AdaptedWidth(10));
//        make.right.lessThanOrEqualTo(self.followBtn.mas_left).offset(AdaptedWidth(-6));
//    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.avatarBtn).offset(-AdaptedHeight(1));
        make.left.equalTo(self.avatarBtn.mas_right).offset(AdaptedWidth(14));
        make.right.lessThanOrEqualTo(self.followBtn.mas_left).offset(AdaptedWidth(-6));
    }];
    
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatarBtn);
        make.right.offset(AdaptedWidth(0));
        make.size.mas_equalTo(CGSizeMake(AdaptedWidth(65), AdaptedWidth(30)));
    }];
}

- (void)configWithModel:(id)model
{
    self.nameLabel.text = @"名字名字";
    self.timeLabel.text = [@"1384556554" fg_stringWithFormat:@"yyyy-MM-dd HH:mm"];

//    [self.avatarBtn sd_setImageWithURL:[NSURL URLWithString:m.user.avatarFull] forState:UIControlStateNormal placeholderImage:UIImageWithName(@"ic_default_avatar")];

}


@end
