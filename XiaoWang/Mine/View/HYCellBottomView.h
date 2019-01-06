//
//  HYCellBottomView.h
//  hangyeshejiao
//
//  Created by Eric on 2018/4/4.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "FGBaseView.h"

/**
 用于cell 类型 低部控件view
 组成部分:分享,查看,点赞,踩 按钮
 */
@interface HYCellBottomView : FGBaseView

/**
 点赞或者点踩 Block YES 👍 NO 踩  是否取消点赞或点踩
 */
@property (nonatomic, copy) void (^zanBlock) (BOOL isZan ,BOOL isCancel);

@property (nonatomic, copy) void (^flowBlock) (BOOL isCancel);

@end
