//
//  XWAreaModel.m
//  XiaoWang
//
//  Created by blaceman on 2019/2/2.
//  Copyright © 2019年 new4545. All rights reserved.
//

#import "XWAreaModel.h"

@implementation XWAreaModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"child":@"XWAreaModel"
             };
}

+(NSString *)city_idWithCityName:(NSString *)city_name{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fg_areaXW.json" ofType:nil];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSArray<XWAreaModel *> *addressArr = [NSArray modelArrayWithClass:[XWAreaModel class] json:jsonData];
  __block NSString *city_id;
    [addressArr jk_each:^(XWAreaModel *object) {
        NSArray<XWAreaModel *> *cityArr = object.child;
        for (XWAreaModel *city in cityArr) {
            if ([city.region_name isEqualToString:city_name]) {
                city_id = city.ID;
                return ;
            }
        }
    }];
    return city_id;
}

+(NSString *)cityNameWithCityID:(NSString *)city_id{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fg_areaXW.json" ofType:nil];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSArray<XWAreaModel *> *addressArr = [NSArray modelArrayWithClass:[XWAreaModel class] json:jsonData];
    __block NSString *city_name;
    [addressArr jk_each:^(XWAreaModel *object) {
        NSArray<XWAreaModel *> *cityArr = object.child;
        for (XWAreaModel *city in cityArr) {
            if ([city.ID isEqualToString:city_id]) {
                city_name = city.region_name;
                return ;
            }
        }
       
    }];
    return city_name;
}

+(NSString *)province_NameWithProvince_id:(NSString *)province_id{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"fg_areaXW.json" ofType:nil];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSArray<XWAreaModel *> *addressArr = [NSArray modelArrayWithClass:[XWAreaModel class] json:jsonData];
    __block NSString *province_Name;
    [addressArr jk_each:^(XWAreaModel *object) {
        if ([object.ID isEqualToString:province_id]) {
            province_Name = object.region_name;
            return ;
        }
    }];
    return province_Name;
}

@end
