//
//  YHNet.m
//  YHKit_OC
//
//  Created by 银河 on 2017/11/22.
//  Copyright © 2017年 银河. All rights reserved.
//

#import "YHNet.h"

#import "YHDebugMacro.h"
#import "NSString+YHExchange.h"
#import "YHMBHud.h"


#if __has_include(<AFNetworking/AFNetworking.h>)
    #import <AFNetworking/AFNetworking.h>
#elif __has_include("AFNetworking.h")
    #import "AFNetworking.h"
#endif

@interface YHNet ()
@property (nonatomic,assign) BOOL isNetworkReachable;
@property (nonatomic,strong) NSMutableArray<NSURLSessionTask *> * tasks;
@end


@implementation YHNet

+ (YHNet *)defaultNet{
    static YHNet *net = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        net = [[YHNet alloc] init];
        net.tasks = [NSMutableArray array];
    });
    return net;
}

/** 网络请求，现在暂时只支持GET、POST */
- (NSURLSessionTask *)yh_netRequestWithType:(YHNetRequestType)requestType
                              withURLString:(NSString *)URLString
                             withParameters:(id)parameters
                                  isShowHUD:(BOOL)isShowHUD
                                hudBaseView:(UIView *)hudBaseView
                                httpHeaders:(NSDictionary<NSString *,NSString *> *)httpHeaders
                      requestSerializerType:(YHNetRequestSerializerType)requestSerializerType
                     responseSerializerType:(YHNetResponseSerializerType)responseSerializerType
                               successBlock:(void (^)(id _Nonnull))successBlock
                                 errorBlock:(void (^)(NSError * _Nonnull))errorBlock{
    
    //当url为空时，进行处理
    if (URLString == nil || URLString.length == 0) {
        YHLog(@"url为空");
        return nil;
    }
   
    AFHTTPSessionManager *sessionManager = [self sessionManagerWithRequestSerializerType:requestSerializerType responseSerializerType:responseSerializerType];
    //当sessionManager不存在时，进行处理
    if (!sessionManager) {
        YHLog(@"sessionManager为空");
        return nil;
    }
    //设置请求头
    if (httpHeaders.allKeys.count > 0) {
        [httpHeaders enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            [sessionManager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    }
    //打印信息
    YHLog(@"\n---------------------------------------\nURL:%@\nparameters:%@\n---------------------------------------",URLString,parameters);
    
    NSURLSessionTask *task = nil;
#if __has_include(<MBProgressHUD/MBProgressHUD.h>) || __has_include("MBProgressHUD.h")
    __block MBProgressHUD *hud = nil;
    if (isShowHUD) {
        hud = [YHMBHud hudWithMessage:nil inView:hudBaseView];
#endif
    }
    
    if (requestType == YHNetRequestTypePOST) {
        task = [sessionManager POST:URLString.yh_formatURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#if __has_include(<MBProgressHUD/MBProgressHUD.h>) || __has_include("MBProgressHUD.h")
            [hud hideAnimated:YES];
#endif
            if ([self.tasks containsObject:task]) {
                [self.tasks removeObject:task];
            }
            id obj;
            if (responseSerializerType == YHNetResponseSerializerTypeOrigin) {
                obj = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            } else {
                obj = responseObject;
            }
            YHLog(@"%@",obj);
            successBlock ? successBlock(obj) : nil;
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            YHLog(@"%@",error);
            if ([self.tasks containsObject:task]) {
                [self.tasks removeObject:task];
            }
#if __has_include(<MBProgressHUD/MBProgressHUD.h>) || __has_include("MBProgressHUD.h")
            [hud hideAnimated:YES];
            [YHMBHud hudOnlyMessage:error.localizedDescription inView:hudBaseView dismissBlock:nil];
#endif
            errorBlock ? errorBlock(error) : nil;
        }];
    } else if (requestType == YHNetRequestTypeGET) {
        task = [sessionManager GET:URLString.yh_formatURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#if __has_include(<MBProgressHUD/MBProgressHUD.h>) || __has_include("MBProgressHUD.h")
            [hud hideAnimated:YES];
#endif
            if ([self.tasks containsObject:task]) {
                [self.tasks removeObject:task];
            }
            id obj;
            if (responseSerializerType == YHNetResponseSerializerTypeOrigin) {
                obj = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            } else {
                obj = responseObject;
            }
            YHLog(@"%@",obj);
            successBlock ? successBlock(obj) : nil;
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            YHLog(@"%@",error);
            if ([self.tasks containsObject:task]) {
                [self.tasks removeObject:task];
            }
#if __has_include(<MBProgressHUD/MBProgressHUD.h>) || __has_include("MBProgressHUD.h")
            [hud hideAnimated:YES];
            [YHMBHud hudOnlyMessage:error.localizedDescription inView:hudBaseView dismissBlock:nil];
#endif
            errorBlock ? errorBlock(error) : nil;
        }];
    }
    if (task) {
        [self.tasks addObject:task];
    }
    return task;
}

/** 初始化sessionManager，里面采用了单例，目的是为了降低了内存 */
- (AFHTTPSessionManager *)sessionManagerWithRequestSerializerType:(YHNetRequestSerializerType)requestSerializerType
                                           responseSerializerType:(YHNetResponseSerializerType)responseSerializerType{
    /*
     1、请求类型为键值对，返回类型为json
     2、请求类型为json，返回类型为json
     3、请求类型为键值对，返回类型为原始数据
     4、请求类型为json，返回类型为原始数据
     这儿这么做的原因是因为在我的项目开发经历中，遇到过个别请求为键值对，也有的请求是json；而返回格式也遇到过直接返回原始数据的
     */
    if (requestSerializerType == YHNetRequestSerializerTypeKeyValue && responseSerializerType == YHNetResponseSerializerTypeJson) {
        static AFHTTPSessionManager *sessionManager = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sessionManager = [AFHTTPSessionManager manager];
            //request
            AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
            sessionManager.requestSerializer.timeoutInterval = kYHNetTimeOutInterval;
            sessionManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
            sessionManager.requestSerializer = request;
            //response
            AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
            response.acceptableContentTypes = [NSSet setWithObjects:
                                               @"application/json",
                                               @"text/json",
                                               @"text/javascript",
                                               @"text/html",
                                               @"text/css",
                                               @"text/xml",
                                               @"text/plain",
                                               @"application/javascript",
                                               @"image/*",
                                               nil];
            sessionManager.responseSerializer = response;
        });
        return sessionManager;
    } else if (requestSerializerType == YHNetRequestSerializerTypeJson && responseSerializerType == YHNetResponseSerializerTypeJson) {
        static AFHTTPSessionManager *sessionManager = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sessionManager = [AFHTTPSessionManager manager];
            //request
            AFJSONRequestSerializer *request = [AFJSONRequestSerializer serializer];
            sessionManager.requestSerializer.timeoutInterval = kYHNetTimeOutInterval;
            sessionManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
            [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            sessionManager.requestSerializer = request;
            //response
            AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
            response.acceptableContentTypes = [NSSet setWithObjects:
                                               @"application/json",
                                               @"text/json",
                                               @"text/javascript",
                                               @"text/html",
                                               @"text/css",
                                               @"text/xml",
                                               @"text/plain",
                                               @"application/javascript",
                                               @"image/*",
                                               nil];
            sessionManager.responseSerializer = response;
        });
        return sessionManager;
    } else if (requestSerializerType == YHNetRequestSerializerTypeKeyValue && responseSerializerType == YHNetResponseSerializerTypeOrigin) {
        static AFHTTPSessionManager *sessionManager = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sessionManager = [AFHTTPSessionManager manager];
            //request
            AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
            sessionManager.requestSerializer.timeoutInterval = kYHNetTimeOutInterval;
            sessionManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
            sessionManager.requestSerializer = request;
            //response
            AFHTTPResponseSerializer *response = [AFHTTPResponseSerializer serializer];
            response.acceptableContentTypes = [NSSet setWithObjects:
                                               @"application/json",
                                               @"text/json",
                                               @"text/javascript",
                                               @"text/html",
                                               @"text/css",
                                               @"text/xml",
                                               @"text/plain",
                                               @"application/javascript",
                                               @"image/*",
                                               nil];
            sessionManager.responseSerializer = response;
        });
        return sessionManager;
    } else if (requestSerializerType == YHNetRequestSerializerTypeJson && responseSerializerType == YHNetResponseSerializerTypeOrigin) {
        static AFHTTPSessionManager *sessionManager = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sessionManager = [AFHTTPSessionManager manager];
            //request
            AFJSONRequestSerializer *request = [AFJSONRequestSerializer serializer];
            sessionManager.requestSerializer.timeoutInterval = kYHNetTimeOutInterval;
            sessionManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
            [sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            sessionManager.requestSerializer = request;
            //response
            AFHTTPResponseSerializer *response = [AFHTTPResponseSerializer serializer];
            response.acceptableContentTypes = [NSSet setWithObjects:
                                               @"application/json",
                                               @"text/json",
                                               @"text/javascript",
                                               @"text/html",
                                               @"text/css",
                                               @"text/xml",
                                               @"text/plain",
                                               @"application/javascript",
                                               @"image/*",
                                               nil];
            sessionManager.responseSerializer = response;
        });
        return sessionManager;
    }
    return nil;
}

/** 取消所有网络请求 */
- (void)yh_cancelAllNetRequest{
    @synchronized(self){//锁操作
        [self.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.state == NSURLSessionTaskStateRunning || obj.state == NSURLSessionTaskStateSuspended) {
                [obj cancel];
            }
        }];
        [self.tasks removeAllObjects];
    }
}
/** 取消某个网络请求 */
- (void)yh_cancelRequestWithTask:(NSURLSessionTask *)task{
    @synchronized(self){//锁操作
        if (task.state == NSURLSessionTaskStateRunning || task.state == NSURLSessionTaskStateSuspended) {
            [task cancel];
        }
        if ([self.tasks containsObject:task]) {
            [self.tasks removeObject:task];
        }
    }
}

/** 开启网络监测，一旦网络转台发生变化，都会走block回调 */
- (void)yh_startNetWorkMonitoringWithBlock:(void (^)(YHNetworkStatus))block{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager manager];
    [mgr startMonitoring];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                YHLog(@"Network Unknown");
                self.isNetworkReachable = NO;
                block ? block(YHNetworkStatusUnknown) : nil;
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            {
                YHLog(@"Network NotReachable");
                self.isNetworkReachable = NO;
                block ? block(YHNetworkStatusNotReachable) : nil;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                YHLog(@"Network is WiFi");
                self.isNetworkReachable = YES;
                block ? block(YHNetworkStatusWIFI) : nil;
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                YHLog(@"Network is 3G/4G");
                self.isNetworkReachable = YES;
                block ? block(YHNetworkStatusWWAN) : nil;
            }
                break;
            default:
                break;
        }
    }];
}


@end




















