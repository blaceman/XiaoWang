//
//  XWLabelsModel.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/18.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWLabelsModel.h"
@implementation XWLabelsModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"labels":@"XWLableListModel",
             @"selected":@"XWLableListModel",
             };
}
@end
