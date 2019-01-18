//
//  XWCommentListsModel.h
//  XiaoWang
//
//  Created by blaceman on 2019/1/18.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "FGBaseModel.h"
#import "XWReplyModel.h"

@interface XWCommentListsModel : FGBaseModel
@property (nonatomic, strong) NSNumber *photo_id;  ///< <#Description#>
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSNumber *comment_id;
@property (nonatomic, strong) NSNumber *main_id;
@property (nonatomic, strong) NSNumber *comment_uid;  ///< <#Description#>
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,strong)NSArray<XWReplyModel *> *reply;

@property (nonatomic,strong)NSString *nickname;


@end
