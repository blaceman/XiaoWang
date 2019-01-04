//
//  XWLabelVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/4.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWLabelVC.h"
#import "XWLabelView.h"
#import "XWPairVC.h"


@interface XWLabelVC ()

@end

@implementation XWLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"个性标签"];
    WeakSelf
    [self.navigationView addRightButtonWithTitle:@"跳过" clickCallBack:^(UIView *view) {
        StrongSelf
        XWPairVC *vc = [XWPairVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    NSArray *titleArr = @[@"职业",@"职业",@"职业",@"职业"];
    
    UIView *bufferView;
    for (int i = 0; i< titleArr.count; i++) {
        XWLabelView *labelView = [[XWLabelView alloc]initWithDataSource:@[@"医生",@"医生",@"医生",@"医生",@"医生",@"医生"]];
        [self.bgScrollView.contentView addSubview:labelView];
        [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.top.offset(0);
            }else{
                make.top.equalTo(bufferView.mas_bottom);
            }
            if (i == titleArr.count - 1) {
                make.bottom.offset(0);
            }
            make.left.right.offset(0);
        }];
        bufferView = labelView;
    }
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
