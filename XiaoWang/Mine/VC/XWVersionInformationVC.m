//
//  XWVersionInformationVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/7.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWVersionInformationVC.h"
#import "FGCellStyleView.h"


@interface XWVersionInformationVC ()

@end

@implementation XWVersionInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"版本信息"];
    [self setItemView];
}

-(void)setItemView{
    self.bgScrollView.backgroundColor = UIColorFromHex(0xffffff);
    UIImageView *img = [UIImageView fg_imageString:@""];
    [self.bgScrollView.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(AdaptedHeight(27));
        make.centerX.offset(0);
        make.width.height.mas_equalTo(AdaptedWidth(114));
    }];
    
    UILabel *tipLabel = [UILabel fg_text:@"小网V1.0" fontSize:16 colorHex:0x666666];
    [self.bgScrollView.contentView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(img.mas_bottom).offset(AdaptedHeight(23));
        make.centerX.offset(0);
    }];
    
    
    
    [self.bgScrollView.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.bgScrollView.mas_height).priorityMedium();
    }];
    self.bgScrollView.alwaysBounceVertical = YES;
    NSArray *titleArr = @[@"当前版本",@"最新版本"];
    NSArray *contentArr = @[@"V1.0",@"V2.0"];

    
    UIView *bufferCell;
    for (int i = 0; i < titleArr.count; i++) {
        FGTextFeidViewModel *model = [FGTextFeidViewModel new];
        model.leftImgPathMargin = AdaptedWidth(36);
        model.isNotEnable = NO;
        //        model.leftImgPath = imgArr[i];
//        model.rightImgPath = @"icon_takedown";
        model.leftTitle = titleArr[i];
        model.leftTitleColor = UIColorFromHex(0x333333);
        model.contentColor = UIColorFromHex(0x999999);
        model.alignment = NSTextAlignmentRight;
        model.content = contentArr[i];
        
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
                make.top.equalTo(tipLabel.mas_bottom).offset(AdaptedHeight(24));
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
 
    
    UIButton *updateBtn = [UIButton fg_title:@"马上更新" fontSize:16 titleColorHex:0x000000];
    updateBtn.backgroundColor = UIColorFromHex(0xFFE616);
    [updateBtn fg_cornerRadius:AdaptedHeight(20) borderWidth:0 borderColor:0];
    [self.bgScrollView.contentView addSubview:updateBtn];
    [updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(bufferCell.mas_bottom).offset(AdaptedHeight(33));
        make.width.mas_equalTo(AdaptedWidth(158));
        make.height.mas_equalTo(AdaptedHeight(40));
//        make.bottom.offset(0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)cellAction:(FGCellStyleView *)cell{
    
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
