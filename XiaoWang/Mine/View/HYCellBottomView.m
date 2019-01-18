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

//@property (nonatomic, strong) UIButton *shareBtn;  ///< 分享
@property (nonatomic, strong) UIButton *lookBtn;  ///< 查看
@property (nonatomic, strong) UIButton *zanBtn;  ///< 点赞
@property (nonatomic, strong) UIButton *ruoBtn;  ///< 踩

@property (nonatomic, strong) UIButton *flowerBtn;  ///< 鲜花🌹


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
//    self.shareBtn = [UIButton fg_title:@" " fontSize:15 titleColorHex:0x838383];
//    [self.shareBtn setImage:UIImageWithName(@"ic_share_gray") forState:UIControlStateNormal];
//    [self addSubview:self.shareBtn];
    
    self.lookBtn = [UIButton fg_title:@" " fontSize:15 titleColorHex:0x838383];
//    [self.lookBtn setImage:UIImageWithName(@"ic_browse_gray") forState:UIControlStateNormal];
    [self addSubview:self.lookBtn];
    
    self.zanBtn = [UIButton fg_imageString:@"icon_like" imageStringSelected:@"icon_like"];
    self.zanBtn.titleLabel.font = AdaptedFontSize(15);
    [self.zanBtn setTitleColor:UIColorFromHex(0x838383) forState:(UIControlStateNormal)];
    [self addSubview:self.zanBtn];
    
    self.ruoBtn = [UIButton fg_imageString:@"icon_comment" imageStringSelected:@"icon_comment"];
    self.ruoBtn.titleLabel.font = AdaptedFontSize(15);
    [self.ruoBtn setTitleColor:UIColorFromHex(0x838383) forState:(UIControlStateNormal)];
    [self addSubview:self.ruoBtn];
    
    WeakSelf
    [self.zanBtn jk_addActionHandler:^(NSInteger tag) {
        StrongSelf
        if (self.zanBlock) {
            self.zanBlock(YES, self.zanBtn.selected);
        }
    }];
    [self.ruoBtn jk_addActionHandler:^(NSInteger tag) {
        StrongSelf
        if (self.zanBlock) {
            self.zanBlock(NO, self.ruoBtn.selected);
        }
    }];
    
    self.flowerBtn = [UIButton fg_imageString:@"icon_share" imageStringSelected:@"icon_share"];
    self.flowerBtn.titleLabel.font = AdaptedFontSize(15);
    [self.flowerBtn setTitleColor:UIColorFromHex(0x838383) forState:(UIControlStateNormal)];
    [self.flowerBtn setTitleColor:UIColorFromHex(0xFA6779) forState:(UIControlStateSelected)];
    [self addSubview:self.flowerBtn];
    [self.flowerBtn jk_addActionHandler:^(NSInteger tag) {
        StrongSelf
        if (self.flowBlock) {
            self.flowBlock(self.flowerBtn.selected);
        }
    }];
}

- (void)setupLayout
{
//    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.offset(0);
//    }];
    
    [self.lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.offset(0);

//        make.centerY.equalTo(self.shareBtn);
//        make.left.equalTo(self.shareBtn.mas_right).offset(AdaptedWidth(30));
    }];
    
    [self.zanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lookBtn);
        make.right.equalTo(self.ruoBtn.mas_left).offset(AdaptedWidth(-24));
    }];
    
    [self.ruoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lookBtn);
        make.right.offset(AdaptedWidth(0));
    }];
    
    [self.flowerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lookBtn);
        make.right.equalTo(self.zanBtn.mas_left).offset(AdaptedWidth(-24));
    }];
}

- (void)configWithModel:(id)model
{
    if ([model isKindOfClass:[XWAlbumModel class]]) {
        XWAlbumModel *albumModel = model;
        [self.lookBtn setTitle:[NSString stringWithFormat:@"  %@     删除",[albumModel.create_time fg_stringWithFormat:@"MM-dd HH:mm"]] forState:UIControlStateNormal];
        
        [self.zanBtn setTitle:[NSString stringWithFormat:@"  %@",albumModel.comment] forState:UIControlStateNormal];
        
        [self.ruoBtn setTitle:[NSString stringWithFormat:@"  %@",albumModel.enjoy] forState:UIControlStateNormal];
        return;
    }
//    [self.shareBtn setTitle:[NSString stringWithFormat:@"  %@",@"100"] forState:UIControlStateNormal];
    [self.lookBtn setTitle:[NSString stringWithFormat:@"  %@",@"09:52     删除"] forState:UIControlStateNormal];
//    self.ruoBtn.backgroundColor = UIColorFromRandom;
//    self.zanBtn.backgroundColor = UIColorFromRandom;

    [self.zanBtn setTitle:[NSString stringWithFormat:@"  %@",@"548"] forState:UIControlStateNormal];
    [self.ruoBtn setTitle:[NSString stringWithFormat:@"  %@",@"64"] forState:UIControlStateNormal];
    
  
    
    
}


@end
