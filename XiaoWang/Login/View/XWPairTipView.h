//
//  XWPairTipView.h
//  XiaoWang
//
//  Created by blaceman on 2019/1/4.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "FGBaseView.h"

@interface XWPairTipView : FGBaseView
@property (nonatomic,strong)UIButton *setBtn;

-(void)showInView:(UIView *)view;
-(void)remove;
@end
