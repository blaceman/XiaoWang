//
//  YIEmptyView.m
//  yiquanqiu
//
//  Created by Eric on 2017/8/10.
//  Copyright © 2017年 YangWeiCong. All rights reserved.
//

#import "YIEmptyView.h"
#import "UIView+JKFrame.h"


@interface YIEmptyView ()

@end

@implementation YIEmptyView

- (instancetype)initWithImageString:(NSString *)imageString text:(NSString *)text
{
    self = [super init];
    if (self) {
        
        UIImageView *imageView = [UIImageView fg_imageString:imageString];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(60);
            make.centerY.equalTo(self);
            make.centerX.equalTo(self);
        }];
        
        text = IsEmpty(text) ? @"" : text;
        UILabel *label = [UILabel fg_text:text fontSize:14 colorHex:0x666666];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imageView);
            make.top.equalTo(imageView.mas_bottom).offset(10);
            make.bottom.equalTo(self);
        }];
        
        _emptyImg = imageView;
        _emptyLabel = label;
        
//        CGSize size = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        [self layoutIfNeeded];
        self.frame = CGRectMake(0, 0, kScreenWidth, self.jk_height);
    }
    return self;
}

- (void)setImageTopConstraint:(CGFloat)imageTopConstraint
{
    _imageTopConstraint = imageTopConstraint;
    [self.emptyImg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(imageTopConstraint);
    }];
    
    CGSize size = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    self.frame = CGRectMake(0, 0, kScreenWidth, size.height);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
