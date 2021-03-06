//
//  XWHelpVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/6.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWHelpVC.h"
#import "FGCellStyleView.h"
#import "XWHelpCenterVC.h"
#import "XWFeedbackVC.h"



@interface XWHelpVC ()

@end

@implementation XWHelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"帮助反馈"];
    [self setItemView];
}


-(void)setItemView{
    
    
    //    [self.bgScrollView.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.height.equalTo(self.bgScrollView.mas_height).priorityMedium();
    //    }];
    self.bgScrollView.alwaysBounceVertical = YES;
    NSArray *titleArr = @[@"帮助中心",@"意见反馈"];
    
    UIView *bufferCell;
    for (int i = 0; i < titleArr.count; i++) {
        FGTextFeidViewModel *model = [FGTextFeidViewModel new];
        model.leftImgPathMargin = AdaptedWidth(36);
        model.isNotEnable = NO;
//        model.leftImgPath = imgArr[i];
        model.rightImgPath = @"icon_more";
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
                make.bottom.equalTo(self.bgScrollView.contentView).offset(-AdaptedWidth(14));
            }
        }];
        
        bufferCell = cell;
    }
    
}
-(void)cellAction:(FGCellStyleView *)cell{
    if ([cell.model.leftTitle isEqualToString:@"帮助中心"]) {
        XWHelpCenterVC *vc = [XWHelpCenterVC new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([cell.model.leftTitle isEqualToString:@"意见反馈"]){
        XWFeedbackVC *vc = [XWFeedbackVC new];
        [self.navigationController pushViewController:vc animated:YES];
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
