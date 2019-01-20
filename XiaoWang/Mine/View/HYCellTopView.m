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
#import "XWAlbumModel.h"


@interface HYCellTopView ()



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
    [self.avatarBtn fg_cornerRadius:AdaptedWidth(44)/2 borderWidth:0 borderColor:0];
    [self addSubview:self.avatarBtn];
    
    self.nameLabel = [UILabel fg_text:@" " fontSize:16 colorHex:0x307FD7];
    [self addSubview:self.nameLabel];
    
   
    
    self.timeLabel = [UILabel fg_text:@" " fontSize:13 colorHex:0xaaaaaa];
    [self addSubview:self.timeLabel];
    
   
}

- (void)setupLayout
{
    [self.avatarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(AdaptedWidth(44));
        make.left.top.bottom.offset(AdaptedWidth(0));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatarBtn);
        make.left.equalTo(self.avatarBtn.mas_right).offset(AdaptedWidth(9));
    }];
    

    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatarBtn);
        make.right.offset(AdaptedWidth(0));
    }];
    
   
}

- (void)configWithModel:(id)model
{
    XWAlbumModel *albumModel = model;
   
    self.nameLabel.text = albumModel.nickname ? albumModel.nickname :@"未命名";
    if (albumModel.ID.integerValue == [FGCacheManager sharedInstance].userModel.ID.integerValue) {
        self.nameLabel.text = @"我";
    }
    
    self.timeLabel.text = [albumModel.create_time fg_stringWithFormat:@"MM-dd HH:mm"];

    [self.avatarBtn sd_setImageWithURL:[NSURL URLWithString:albumModel.avatar] forState:UIControlStateNormal placeholderImage:UIImageWithName(@"icon_head2")];

}


@end
