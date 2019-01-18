//
//  HYCellCommentView.h
//  hangyeshejiao
//
//  Created by Eric on 2018/4/4.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import "FGBaseView.h"
#import <YYLabel.h>
#import <NSAttributedString+YYText.h>
#import "XWCommentListsModel.h"
/**
 评论view
 */
@interface HYCellCommentView : FGBaseView
@property (nonatomic,copy) void (^tagLabelBlock)(id model);


- (instancetype)initWithModel:(id)model;


@end
