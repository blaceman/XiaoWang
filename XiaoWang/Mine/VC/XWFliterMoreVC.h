//
//  XWFliterMoreVC.h
//  XiaoWang
//
//  Created by blaceman on 2019/1/27.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "FGBaseViewController.h"
#import "XWLabelsModel.h"
@interface XWFliterMoreVC : FGBaseViewController
@property (nonatomic, strong) NSString *moreTitle;  ///< <#Description#>
@property (nonatomic, strong) NSArray *dataSource;  ///< <#Description#>
@property (nonatomic,strong)XWLabelsModel *labelModel;
@property (nonatomic,assign)NSInteger labelTag;

@end
