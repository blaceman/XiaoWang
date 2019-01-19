//
//  HYCellBottomView.m
//  hangyeshejiao
//
//  Created by Eric on 2018/4/4.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "HYCellBottomView.h"
#import "XWAlbumModel.h"

@interface HYCellBottomView ()

@property (nonatomic, strong) UIButton *shareBtn;  ///< 分享
@property (nonatomic, strong) UIButton *delBtn;  ///< 删除
@property (nonatomic, strong) UIButton *enjoy;  ///< 点赞
@property (nonatomic, strong) UIButton *comment;  ///< 评论



@end

@implementation HYCellBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setupViews
{
    self.shareBtn = [UIButton fg_title:@" " fontSize:15 titleColorHex:0x838383];
    [self.shareBtn setImage:UIImageWithName(@"icon_share") forState:UIControlStateNormal];
    [self addSubview:self.shareBtn];
    
    self.delBtn = [UIButton fg_title:@" " fontSize:15 titleColorHex:0x838383];
    [self addSubview:self.delBtn];
    
    self.enjoy = [UIButton fg_imageString:@"icon_like" imageStringSelected:@"icon_like_red"];
    self.enjoy.titleLabel.font = AdaptedFontSize(15);
    [self.enjoy setTitleColor:UIColorFromHex(0x838383) forState:(UIControlStateNormal)];
    [self addSubview:self.enjoy];
    
    self.comment = [UIButton fg_imageString:@"icon_comment" imageStringSelected:@"icon_comment"];
    self.comment.titleLabel.font = AdaptedFontSize(15);
    [self.comment setTitleColor:UIColorFromHex(0x838383) forState:(UIControlStateNormal)];
    [self addSubview:self.comment];
    
    WeakSelf

    [self.comment jk_addActionHandler:^(NSInteger tag) {
        StrongSelf
        if (self.commentBlock) {
            self.commentBlock();
        }
    }];
    
    [self.delBtn jk_addActionHandler:^(NSInteger tag) {
       StrongSelf
        if (self.delBlock) {
            self.delBlock();
        }
    }];
    
    
    RAC(self.enjoy,selected) = [[self.enjoy rac_signalForControlEvents:(UIControlEventTouchUpInside)] map:^id _Nullable(__kindof UIButton * _Nullable value) {
        StrongSelf
        if (self.zanBlock) {
            self.zanBlock(!value.selected);
        }
        return @(!value.selected);
    }];
}

- (void)setupLayout
{
    
    
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.offset(0);
    }];
    
    [self.enjoy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.delBtn);
        make.right.equalTo(self.comment.mas_left).offset(AdaptedWidth(-24));
    }];
    
    [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.delBtn);
        make.right.offset(AdaptedWidth(0));
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.delBtn);
        make.right.equalTo(self.enjoy.mas_left).offset(AdaptedWidth(-24));
    }];
}

- (void)configWithModel:(id)model
{
    if ([model isKindOfClass:[XWAlbumModel class]]) {
        XWAlbumModel *albumModel = model;
        [self.delBtn setTitle:[NSString stringWithFormat:@"  %@     删除",[albumModel.create_time fg_stringWithFormat:@"MM-dd HH:mm"]] forState:UIControlStateNormal];
        [self.enjoy setTitle:[NSString stringWithFormat:@"  %@",albumModel.enjoy] forState:UIControlStateNormal];
        [self.comment setTitle:[NSString stringWithFormat:@"  %@",albumModel.comment] forState:UIControlStateNormal];
        
        self.enjoy.selected = albumModel.is_praise.boolValue;
        return;
    }
//    [self.shareBtn setTitle:[NSString stringWithFormat:@"  %@",@"100"] forState:UIControlStateNormal];
    [self.delBtn setTitle:[NSString stringWithFormat:@"  %@",@"09:52     删除"] forState:UIControlStateNormal];
//    self.comment.backgroundColor = UIColorFromRandom;
//    self.enjoy.backgroundColor = UIColorFromRandom;

    [self.enjoy setTitle:[NSString stringWithFormat:@"  %@",@"548"] forState:UIControlStateNormal];
    [self.comment setTitle:[NSString stringWithFormat:@"  %@",@"64"] forState:UIControlStateNormal];
    
  
    
    
}


@end
