//
//  XWXustomizeView.h
//  XiaoWang
//
//  Created by blaceman on 2019/2/2.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "FGBaseView.h"

@interface XWXustomizeView : FGBaseView
@property (nonatomic, strong) UITextView *customTextField;  ///< <#Description#>
@property (nonatomic, strong) UIButton *comfigBtn;  ///< <#Description#>
@property (nonatomic,strong)UIView *backGroundView;
-(void)showInView:(UIView *)view;
-(void)remove;
@end
