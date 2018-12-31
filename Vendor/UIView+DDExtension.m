//
//  UIView+DDExtension.m
//  dingdingxuefu
//
//  Created by Eric on 2018/7/24.
//

#import "UIView+DDExtension.h"

@implementation UIView (DDExtension)

/**
 制作背景view
 */
+ (UIView *)makeBGView
{
    UIView *view = [UIView new];
    view.backgroundColor = UIColorFromHex(kColorBG);
    return view;
}

/**
 显示卡片风格
 */
- (void)dd_showCardStyle
{
    [self fg_cornerRadius:AdaptedWidth(7) borderWidth:kOnePixel borderColor:0x384F86];
    self.layer.borderColor = UIColorFromHexWithAlpha(0x384F86, 0.1).CGColor;
    [self jk_shadowWithColor:UIColorFromHex(0x7D735A) offset:CGSizeMake(AdaptedWidth(3), AdaptedWidth(3)) opacity:0.16 radius:0];
}

@end
