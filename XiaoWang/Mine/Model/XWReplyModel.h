//
//  XWReplyModel.h
//  XiaoWang
//
//  Created by blaceman on 2019/1/18.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "FGBaseModel.h"

@interface XWReplyModel : FGBaseModel

@property (nonatomic, strong) NSString *content;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *comment_uid;  ///< <#Description#>
@property (nonatomic, strong) NSString *comment_nick;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *commented_uid;  ///< <#Description#>
@property (nonatomic, strong) NSString *commented_nick;  ///< <#Description#>

@property (nonatomic, strong) NSString *photo_id;  ///< <#Description#>



@end
