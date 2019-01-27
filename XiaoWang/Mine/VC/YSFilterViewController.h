//
//  YSFilterViewController.h
//  XiaoWang
//
//  Created by blaceman on 2019/1/27.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "FGBaseViewController.h"
#import "XWLabelView.h"

@interface YSFilterViewController : FGBaseViewController
@property (nonatomic, strong) UISwitch *switchView;  ///< <#Description#>
@property (nonatomic,strong) XWLabelView *labelViewSex;

@property (nonatomic,strong)XWLabelView *labelViewAge;
@property (nonatomic,strong)XWLabelView *labelViewloaction;
@end
