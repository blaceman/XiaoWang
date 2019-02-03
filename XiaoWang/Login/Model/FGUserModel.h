//
//  XWLoginModel.h
//  XiaoWang
//
//  Created by blaceman on 2019/1/18.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "FGBaseModel.h"
@class XWLableListModel;
@interface FGUserModel : FGBaseModel

@property (nonatomic, strong) NSString *avatar;  ///< <#Description#>
@property (nonatomic, strong) NSString *birthday;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *city_id;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *gender;  ///< <#Description#>

@property (nonatomic, strong) NSNumber *is_newer;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *mobile;  ///< <#Description#>
@property (nonatomic, strong) NSString *nickname;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *province_id;  ///< <#Description#>

@property (nonatomic, strong) NSNumber *state;  ///< <#Description#>
@property (nonatomic, strong) NSString *token;  ///< <#Description#>

@property (nonatomic, strong) NSString *code;  ///< <#Description#>

@property (nonatomic, strong) NSString *question;  ///< <#Description#>

@property (nonatomic, strong) NSNumber *match_id;  ///< <#Description#>
@property (nonatomic, copy) NSString *uid;  ///< Id

@property (nonatomic, strong) NSNumber *f_uid;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *b_uid;  ///< <#Description#>


@property (nonatomic, strong) NSArray<NSString *> *labels;  ///< <#Description#>


@end
