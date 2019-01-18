//
//  XWAlbumModel.m
//  XiaoWang
//
//  Created by blaceman on 2019/1/18.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWAlbumModel.h"

@implementation XWAlbumModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"images":@"NSString",
             @"comment_lists":@"XWCommentListsModel"
             };
}
@end
