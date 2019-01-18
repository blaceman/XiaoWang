//
//  FGCacheManager.h
//  renshangcheng
//
//  Created by Eric on 2018/3/6.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCache.h>
#import "FGUserModel.h"


#define kUserId [FGCacheManager sharedInstance].userModel.ID

/**
 管理 缓存 类
 */
@interface FGCacheManager : NSObject

+ (instancetype)sharedInstance;



//登录token
@property (nonatomic, copy) NSString *token;  ///<

//fguserModel
@property (nonatomic, copy) FGUserModel *userModel;  ///<


@end
