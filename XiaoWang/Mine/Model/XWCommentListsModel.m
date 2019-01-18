//
//  XWCommentListsModel.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/18.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWCommentListsModel.h"

@implementation XWCommentListsModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"reply":@"XWReplyModel"
             };
}
@end
