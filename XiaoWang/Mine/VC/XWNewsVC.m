//
//  XWNewsVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/7.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWNewsVC.h"
#import "FGCellStyleView.h"
#import "WXNewsListVC.h"
#import "XWFriendVC.h"
#import "XWAlbumVC.h"


@interface XWNewsVC ()

@end

@implementation XWNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"消息"];
    [self setItemView];
}

-(void)setItemView{
    
    
    [self.bgScrollView.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.bgScrollView.mas_height).priorityMedium();
    }];
    self.bgScrollView.alwaysBounceVertical = YES;
    NSArray *titleArr = @[@"我的消息",@"动态",@"好友列表",@"速配过的人"];
    NSArray *imgArr = @[@"icon_mynews",@"icon_dynamic",@"icon_group",@"icon_addpeople"];
    
    UIView *bufferCell;
    for (int i = 0; i < titleArr.count; i++) {
        FGTextFeidViewModel *model = [FGTextFeidViewModel new];
        model.leftImgPathMargin = AdaptedWidth(36);
        model.isNotEnable = NO;
        model.leftImgPath = imgArr[i];
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
    if ([cell.model.leftTitle isEqualToString:@"我的消息"]) {
        WXNewsListVC *vc = [WXNewsListVC new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([cell.model.leftTitle isEqualToString:@"好友列表"]){
        [self.navigationController pushViewController:[XWFriendVC new] animated:YES];
    }else if ([cell.model.leftTitle isEqualToString:@"速配过的人"]){
        WXNewsListVC *vc = [WXNewsListVC new];
        vc.type = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([cell.model.leftTitle isEqualToString:@"动态"]){
        XWAlbumVC *vc = [XWAlbumVC new];
        [self.navigationController pushViewController:vc animated:YES];

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
