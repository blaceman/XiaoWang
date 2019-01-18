//
//  FGHttpManager.m
//  jingpai
//
//  Created by qiuxiaofeng on 2018/5/30.
//  Copyright © 2018年 JP. All rights reserved.
//

#import "FGHttpManager.h"


@implementation FGHttpManager

+ (AFHTTPSessionManager *)manager
{
    static dispatch_once_t onceToken;
    static AFHTTPSessionManager * manager;
    dispatch_once(&onceToken, ^{
        
        manager = [AFHTTPSessionManager manager];
        //最大请求并发任务数
        manager.operationQueue.maxConcurrentOperationCount = 5;
        
        // 请求格式
        // AFHTTPRequestSerializer            二进制格式
        // AFJSONRequestSerializer            JSON
        // AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
        
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
        manager.requestSerializer.timeoutInterval = 30.0f;

        // 返回格式
        // AFHTTPResponseSerializer           二进制格式
        // AFJSONResponseSerializer           JSON
        // AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
        // AFXMLDocumentResponseSerializer (Mac OS X)
        // AFPropertyListResponseSerializer   PList
        // AFImageResponseSerializer          Image
        // AFCompoundResponseSerializer       组合
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        // 设置接收的Content-Type
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json",@"text/html",@"text/plain",@"text/javascript", nil];
        
        //开启网络监听
//        [self networkStatus];
        
        //开启https
//        manager.securityPolicy = [self customSecurityPolicy];
        
    });
    
//    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//    if (token.length > 0) {
//        [manager.requestSerializer setValue:token forHTTPHeaderField:@"authorization"];
//    }
    return manager;
}

+ (AFSecurityPolicy *)customSecurityPolicy
{
    //Https CA证书地址
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"cer"];
    //获取CA证书数据
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    //创建AFSecurityPolicy对象
    AFSecurityPolicy *security = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    //设置是否允许不信任的证书（证书无效、证书时间过期）通过验证 ，默认为NO.
    security.allowInvalidCertificates = YES;
    //是否验证域名证书的CN(common name)字段。默认值为YES。
    security.validatesDomainName = NO;
    //根据验证模式来返回用于验证服务器的证书
    security.pinnedCertificates = [NSSet setWithObject:cerData];
    return security;
}

//创建网络监测者
+ (void)networkStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
                
            default:
                break;
        }
        
    }] ;
    
    [manager startMonitoring];
}

+ (void)getWithPath:(NSString *)path
         parameters:(NSDictionary *)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSString *error))failure
{
    //AFN管理者调用get请求方法
    [[self manager] GET:[BaseApi stringByAppendingPathComponent:path] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        //返回请求返回进度
        NSLog(@"downloadProgress-->%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功返回数据 根据responseSerializer 返回不同的数据格式
//        NSLog(@"responseObject-->%@",responseObject);
        FGResponseModel *obj = [FGResponseModel modelWithJSON:responseObject];
        if (obj.result > 0) {
            success(obj.data);
        }else{
            //未登陆 或者 cookie 过期 时
            if (obj.result == -2) {
            }
            failure(obj.msg);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"error-->%@",error);
        if (failure) {
            failure(error.description);
        }
        [self handleStatusCode:task];
    }];
}

+ (void)postWithPath:(NSString *)path
          parameters:(NSDictionary *)parameters
             success:(void (^)(id responseObject))success
             failure:(void (^)(NSString *error))failure
{
    //AFN管理者调用get请求方法
    [[self manager] POST:[BaseApi stringByAppendingPathComponent:path] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        //返回请求返回进度
        //        NSLog(@"downloadProgress-->%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功返回数据 根据responseSerializer 返回不同的数据格式
        NSLog(@"responseObject-->%@",responseObject);
        FGResponseModel *obj = [FGResponseModel modelWithJSON:responseObject];
        if (obj.status == 0) {
            success(obj.data);
        }else{
            failure(obj.msg);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"error-->%@",error);
        if (failure) {
            failure(error.description);
        }
        
        [self handleStatusCode:task];
    }];
}

+ (void)handleStatusCode:(NSURLSessionDataTask *)task
{
    NSURLResponse *response = [task response];
    if ([response.URL.path hasSuffix:@"login"]) {
        return;
    }
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if([httpResponse statusCode] == 403)
    {
        //重新登录
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"id"];
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSucceedNotification object:self userInfo:nil];
    }
}

/*
//处理文件上传
+ (void)doUploadRequest
{
    // 创建URL资源地址
    NSString *url = BaseApi;
    // 参数
    NSDictionary *parameters=@{};
    [[self manager] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];
        NSString* fileName = [NSString stringWithFormat:@"file_%0.f.txt", a];
        
        // 获取数据转换成data
        NSString *filePath;// =[FileUtils getFilePath:fileName];
        // 拼接数据到请求题中
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"headUrl" fileName:fileName mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}

//处理文件下载
+ (void)doDownLoadRequest
{
    NSString *urlStr =@"testurl";
    // 设置请求的URL地址
    NSURL *url = [NSURL URLWithString:urlStr];
    // 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 下载任务
    NSURLSessionDownloadTask *task = [[self manager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 下载进度
        NSLog(@"当前下载进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 下载地址
        NSLog(@"默认下载地址%@",targetPath);
        //这里模拟一个路径 真实场景可以根据url计算出一个md5值 作为fileKey
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];
        NSString* fileKey = [NSString stringWithFormat:@"/file_%0.f.txt", a];
        // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
        NSString *filePath;// = [FileUtils getFilePath:fileKey];
        return [NSURL fileURLWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test.zip"]]; // 返回的是文件存放在本地沙盒的地址
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 下载完成调用的方法
        NSLog(@"filePath---%@", filePath);
        //        NSData *data=[NSData dataWithContentsOfURL:filePath];
        //        UIImage *image=[UIImage imageWithData:data];
        // 刷新界面...
        
    }];
    //启动下载任务
    [task resume];
}
*/

@end
