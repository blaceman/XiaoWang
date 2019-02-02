//
//  XWAreaModel.h
//  XiaoWang
//
//  Created by blaceman on 2019/2/2.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "FGBaseModel.h"

@interface XWAreaModel : FGBaseModel
@property (nonatomic, strong) NSString *region_name;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *parent_id;  ///< <#Description#>
@property (nonatomic, strong) NSArray<XWAreaModel *> *child;  ///< <#Description#>





+(NSString *)city_idWithCityName:(NSString *)city_name;
+(NSString *)cityNameWithCityID:(NSString *)city_id;
+(NSString *)province_NameWithProvince_id:(NSString *)province_id;

@end
