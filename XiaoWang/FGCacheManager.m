////
////  FGCacheManager.m
////  renshangcheng
////
////  Created by Eric on 2018/3/6.
////  Copyright © 2018年 YangWeiCong. All rights reserved.
////
//
#import "FGCacheManager.h"
#import <NSObject+YYModel.h>
//
NSString *const kUserinfoName = @"kUserinfoName"; //存储用户信息的文件名
NSString *const kUserinfoKey = @"userinfoKey"; //存储用户信息key

//
@interface FGCacheManager ()
//
@property (nonatomic, strong) YYCache *cache;  ///< 磁盘存储管理
//
@end
//
//
@implementation FGCacheManager
//
@synthesize userModel = _userModel;
//@synthesize currentSchoolModel = _currentSchoolModel;
@synthesize token = _token;
//
//
+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
//
- (instancetype)init
{
    self = [super init];
    if (self) {
        _cache = [[YYCache alloc] initWithName:kUserinfoName];
    }
    return self;
}
//
//#pragma mark - set/get
//
- (void)setUserModel:(FGUserModel *)userModel
{
    _userModel = userModel;

    //把 userModel 存入磁盘
    NSDictionary *user = [userModel modelToJSONObject];
    [self.cache.diskCache setObject:user forKey:kUserinfoKey];
}

- (FGUserModel *)userModel
{
    if(!_userModel){
        id user = [self.cache.diskCache objectForKey:kUserinfoKey];
        _userModel = [FGUserModel modelWithJSON:user];
    }
    return _userModel;
}

- (void)setToken:(NSString *)token
{
    _token = token;

    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self.cache.diskCache setObject:token forKey:@"token"];
}
//
- (NSString *)token
{
    if (!_token) {
        _token = (NSString *)[self.cache.diskCache objectForKey:@"token"];
    }

    return _token;
}
//
//
@end
