//
//  XWSetVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/6.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWSetVC.h"
#import "FGCellStyleView.h"

@interface XWSetVC ()

@end

@implementation XWSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"设置"];
    [self setItemView];
    [self loginOutBtnSet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setItemView{
    
    
        [self.bgScrollView.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.bgScrollView.mas_height).priorityMedium();
        }];
    self.bgScrollView.alwaysBounceVertical = YES;
    NSArray *titleArr = @[@"分享",@"免打扰",@"设置",@"黑名单",@"关于小网"];
    
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
//                make.bottom.equalTo(self.bgScrollView.contentView).offset(-AdaptedWidth(14));
            }
        }];
        
        bufferCell = cell;
    }
    
}
-(void)cellAction:(FGCellStyleView *)cell{
    
}


-(void)loginOutBtnSet{
    UIButton *loginOutBtn = [UIButton fg_title:@"退出登录" fontSize:16 titleColorHex:0x000000];
    loginOutBtn.backgroundColor = UIColorFromHex(0xFFE616);
    [self.bgScrollView.contentView addSubview:loginOutBtn];
    [loginOutBtn fg_cornerRadius:AdaptedHeight(20) borderWidth:0 borderColor:0];
    
    [loginOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(AdaptedWidth(44));
        make.right.offset(AdaptedWidth(-44));
        make.bottom.offset(AdaptedWidth(-47));


    }];
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
