//
//  FGBaseModel.h
//  hangyeshejiao
//
//  Created by Eric on 2018/3/28.
//  Copyright © 2018年 YangWeiCong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit.h>
/**
 基类 model
 */
@interface FGBaseModel : NSObject<YYModel>

@property (nonatomic, copy) NSString *uid;  ///< Id
@property (nonatomic, copy) NSString *ID;  ///< Id

@end


