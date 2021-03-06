//
//  XWLabelView.h
//  XiaoWang
//
//  Created by blaceman on 2019/1/4.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "FGBaseView.h"
#import "XWLabelsModel.h"

@interface XWLabelView : FGBaseView
@property (nonatomic,strong)XWLabelsModel *labelModel;
@property (nonatomic, assign) BOOL isSelected;  ///< <#Description#>
@property (nonatomic,strong)NSString *title;

@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic, copy) void (^btnBlock) (UIButton *btn);  ///< <#Description#>
@property (nonatomic,assign)BOOL ismore;

@property (nonatomic,strong)NSMutableArray *showArr;


-(instancetype)initWithDataSource:(NSArray *)dataSource title:(NSString *)title;
-(instancetype)initWithDataSource:(NSArray *)dataSource title:(NSString *)title isMore:(BOOL)ismore;

-(void)setupView;


-(void)setupAge;

-(void)setupLocation;


@end
