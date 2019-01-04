//
//  FGResponseModel.h
//  jingpai
//
//  Created by Eric on 2018/6/21.
//  Copyright © 2018年 figo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit.h>

/**
 网络请求响应 model
 */
@interface FGResponseModel : NSObject<YYModel>

@property (nonatomic, assign) NSInteger result;  ///< <#Description#>
@property (nonatomic, copy) NSString *msg;  ///< <#Description#>
@property (nonatomic, strong) NSNumber *code;  ///< <#Description#>
@property (nonatomic, assign) id data;  ///< <#Description#>

@property (nonatomic, strong) NSDictionary *dataDict;  ///< <#Description#>
@property (nonatomic, strong) NSArray *dataArray;  ///< <#Description#>

@end
