//
//  XWAlbumModel.h
//  XiaoWang
//
//  Created by blaceman on 2019/1/18.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "FGBaseModel.h"
#import "XWCommentListsModel.h"

@interface XWAlbumModel : FGBaseModel
@property (nonatomic,strong)NSString *avatar;
@property (nonatomic,strong)NSNumber *comment;
@property (nonatomic, strong) NSArray<XWCommentListsModel *> *comment_lists;  ///< <#Description#>
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic, strong) NSNumber *enjoy;  ///< <#Description#>
@property (nonatomic,strong)NSArray<NSString *> *images;
@property (nonatomic,strong)NSNumber *photo_id;
@property (nonatomic,strong)NSNumber *is_praise;


 ///< <#Description#>
@end
