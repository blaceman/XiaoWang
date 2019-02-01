//
//  XWMessageModel.h
//  XiaoWang
//
//  Created by blaceman on 2019/2/1.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "FGBaseModel.h"

@interface XWMessageModel : FGBaseModel
@property (nonatomic, strong) NSNumber *type;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *uid;  ///< <#Description#>
@property (nonatomic, strong) NSString *title;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *state;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *msg_id;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *match_id;  ///< <#Description#>
@property (nonatomic, strong) NSString *content;  ///< <#Description#>
@property (nonatomic, strong) NSString *nickname;  ///< <#Description#>
@property (nonatomic, strong) NSString *avatar;  ///< <#Description#>







@end
