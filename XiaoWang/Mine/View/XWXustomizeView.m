//
//  XWXustomizeView.m
//  XiaoWang
//
//  Created by blaceman on 2019/2/2.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWXustomizeView.h"

@implementation XWXustomizeView

-(void)setupViews{
    self.customTextField = [UITextView new];
    self.customTextField.backgroundColor = UIColorFromHex(0xffffff);
    [self addSubview:self.customTextField];
    self.customTextField.textColor = UIColorFromHex(0x333333);
    self.customTextField.font = AdaptedFontSize(16);
    self.customTextField.textContainer.lineFragmentPadding = AdaptedWidth(17);
    [self.customTextField jk_addPlaceHolder:@"  请输入自定义标签"];
    
    self.comfigBtn = [UIButton fg_title:@"确定" fontSize:16 titleColorHex:0x333333];
    self.comfigBtn.backgroundColor = UIColorFromHex(0xFFE616);
    [self addSubview:self.comfigBtn];
    
    
}
-(void)setupLayout{
    [self.comfigBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(AdaptedHeight(50));
    }];
    
    [self.customTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.right.offset(0);
        make.bottom.equalTo(self.comfigBtn.mas_top);
        make.height.mas_equalTo(AdaptedHeight(119));
    }];
}

-(void)showInView:(UIView *)view{
    self.backGroundView = [UIView new];
    [self.backGroundView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self endEditing:YES];
    }];
    self.backGroundView.backgroundColor = UIColorFromHexWithAlpha(0x000000, 0.5);
    [view addSubview:self.backGroundView];
    [self.backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.offset(0);
    }];
}
-(void)remove{
    [self.backGroundView removeFromSuperview];
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
