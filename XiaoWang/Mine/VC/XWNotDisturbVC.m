//
//  XWNotDisturbVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/7.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWNotDisturbVC.h"
#import "FGCellStyleView.h"

@interface XWNotDisturbVC ()

@end

@implementation XWNotDisturbVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"免打扰"];
    [self setItemView];
}

-(void)setItemView{
    
    
    [self.bgScrollView.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.bgScrollView.mas_height).priorityMedium();
    }];
    self.bgScrollView.alwaysBounceVertical = YES;
    NSArray *titleArr = @[@"静音",@"震动"];
    
    UIView *bufferCell;
    for (int i = 0; i < titleArr.count; i++) {
        FGTextFeidViewModel *model = [FGTextFeidViewModel new];
        model.leftImgPathMargin = AdaptedWidth(36);
        model.isNotEnable = NO;
        //        model.leftImgPath = imgArr[i];
        model.rightImgPath = @"icon_select";
        model.leftTitle = titleArr[i];
        model.leftTitleColor = UIColorFromHex(0x333333);
        
        
        FGCellStyleView *cell = [[FGCellStyleView alloc] initWithModel:model];
        [cell addBottomLine];
        cell.tag = i;
        if (i != titleArr.count - 1) {
            [cell addBottomLineWithEdge:UIEdgeInsetsMake(0, AdaptedWidth(16), 0, 0)];
        }
        [self.bgScrollView.contentView addSubview:cell];
        [cell addTarget:self action:@selector(cellAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgScrollView.contentView);
            if (i == 0) {
                make.top.offset(AdaptedHeight(0));
            }else{
                
                make.top.equalTo(bufferCell.mas_bottom);
            }
            make.height.mas_equalTo(AdaptedHeight(57));
            if (i == titleArr.count - 1) {
                //                make.bottom.equalTo(self.bgScrollView.contentView).offset(-AdaptedWidth(14));
            }
        }];
        
        bufferCell = cell;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cellAction:(FGCellStyleView *)cell{
    if ([cell.model.leftTitle isEqualToString:@"版本信息"]) {
       
    }
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
