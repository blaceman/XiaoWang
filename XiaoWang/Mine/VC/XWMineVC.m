//
//  XWMineVC.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/5.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWMineVC.h"
#import "XWPairHeaderView.h"
#import "FGCellStyleView.h"
#import "XWLabelVC.h"
#import "XWPasswordVC.h"
#import "XWAlbumVC.h"
#import "XWHelpVC.h"
#import "XWSetVC.h"
#import "HYPersonSetVC.h"

@interface XWMineVC ()
@property (nonatomic, strong) XWPairHeaderView *headerView;  ///< <#Description#>
@end

@implementation XWMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationView setTitle:@"我的"];
    XWPairHeaderView *pairView = [XWPairHeaderView new];
    WeakSelf
    [[pairView.avaterBtn rac_signalForControlEvents:(UIControlEventTouchUpInside)]subscribeNext:^(__kindof UIControl * _Nullable x) {
        StrongSelf
       HYPersonSetVC *vc = [HYPersonSetVC new];
        vc.isNONewers = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    self.headerView = pairView;
    [pairView configWithModel:[FGCacheManager sharedInstance].userModel];
    [self.bgScrollView.contentView addSubview:pairView];
    [pairView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
    }];
    
    [self setItemView];
}

-(void)setItemView{
    
   
//    [self.bgScrollView.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(self.bgScrollView.mas_height).priorityMedium();
//    }];
    self.bgScrollView.alwaysBounceVertical = YES;
    NSArray *titleArr = @[@"个性标签",@"通关口令",@"我的相册",@"帮助反馈",@"设置"];
    
    NSArray *imgArr = @[@"icon_label",@"icon_lock1",@"icon_photo",@"icon_problem",@"icon_set"];
    UIView *bufferCell;
    for (int i = 0; i < titleArr.count; i++) {
        FGTextFeidViewModel *model = [FGTextFeidViewModel new];
        model.leftTitle = titleArr[i];
        model.leftImgPathMargin = AdaptedWidth(22);
        model.isNotEnable = NO;
        model.leftImgPath = imgArr[i];
        model.rightImgPath = @"icon_more";
        
        
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
                make.top.equalTo(self.headerView.mas_bottom).offset(AdaptedHeight(7));
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
    if ([cell.model.leftTitle isEqualToString:@"个性标签"]) {
        XWLabelVC *vc = [XWLabelVC new];
        vc.isMyLabel = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (([cell.model.leftTitle isEqualToString:@"通关口令"])){
        XWPasswordVC *vc = [XWPasswordVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if([cell.model.leftTitle isEqualToString:@"我的相册"]){
        XWAlbumVC *vc = [XWAlbumVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([cell.model.leftTitle isEqualToString:@"帮助反馈"]){
        XWHelpVC *vc = [XWHelpVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([cell.model.leftTitle isEqualToString:@"设置"]){
        XWSetVC *vc = [XWSetVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.headerView configWithModel:[FGCacheManager sharedInstance].userModel];
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
