//
//  XWLabelsModel.h
//  XiaoWang
//
//  Created by blaceman on 2019/1/18.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "FGBaseModel.h"
@class XWLableListModel;
@interface XWLabelsModel : FGBaseModel
@property (nonatomic, strong) NSArray<XWLableListModel *> *labels;  ///< <#Description#>
@property (nonatomic, strong) NSArray<XWLableListModel *> *selected;  ///< <#Description#>

@end
