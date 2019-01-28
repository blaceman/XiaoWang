//
//  XWPairPassView.h
//  XiaoWang
//
//  Created by blaceman on 2019/1/5.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "FGBaseView.h"

@interface XWPairPassView : FGBaseView
@property (nonatomic,strong)UIButton *loadBtn;
@property (nonatomic,strong)UILabel *subLabel;
@property (nonatomic,strong)UIView *backGroundView;
@property (nonatomic,strong)UIButton *sendBtn;
@property (nonatomic,strong)UILabel *contentLabel;


-(void)showInView:(UIView *)view;
-(void)remove;
@end
