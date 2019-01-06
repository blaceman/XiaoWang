//
//  HYCellTopView.h
//  hangyeshejiao
//
//  Created by Eric on 2018/4/4.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "FGBaseView.h"

/**
 用于cell 类型 头部控件view
 组成部分:头像,名字,时间,关注按钮(时间和关注按钮 两者只显示一个)
 */
@interface HYCellTopView : FGBaseView

@property (nonatomic, strong) UIButton *followBtn;  ///< 关注Btn
@property (nonatomic, strong) UIButton *avatarBtn;  ///< 头像Btn

@property (nonatomic, strong) UILabel *nameLabel;  ///< 名字

@end
