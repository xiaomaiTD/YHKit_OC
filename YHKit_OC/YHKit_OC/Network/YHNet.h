//
//  YHNet.h
//  YHKit_OC
//
//  Created by 银河 on 2017/11/22.
//  Copyright © 2017年 银河. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN
/** Request method */
typedef NS_ENUM(NSUInteger, YHNetRequestMethod) {
    YHNetRequestMethodGET,   // GET
    YHNetRequestMethodPOST,  // POST
};
/** Request serializer type */
typedef NS_ENUM(NSUInteger, YHNetRequestSerializerType) {
    YHNetRequestSerializerTypeHTTP,   // HTTP
    YHNetRequestSerializerTypeJSON,   // JSON
};
/** Response serializer type */
typedef NS_ENUM(NSUInteger, YHNetResponseSerializerType) {
    YHNetResponseSerializerTypeHTTP,        // HTTP -- 原始数据
    YHNetResponseSerializerTypeJSON,        // JSON -- JSON格式
};
/** Network status */
typedef NS_ENUM(NSUInteger, YHNetworkStatus) {
    YHNetworkStatusUnknown,           // Unknown
    YHNetworkStatusWIFI,              // WiFi
    YHNetworkStatusWWAN,              // 3G/4G
    YHNetworkStatusNotReachable,      // NotReachable
};











/** 网络请求超时时间 */
static NSTimeInterval const kYHNetTimeOutInterval = 30.f;

@interface YHNet : NSObject
/** 网络是否可用，需要先调用：yh_startNetWorkMonitoringWithBlock： */
@property (nonatomic,assign,readonly) BOOL isNetworkReachable;
/** 所有网络请求的任务 */
@property (nonatomic,strong,readonly) NSMutableArray<NSURLSessionTask *> * tasks;



/** 是否是https */
@property (nonatomic,assign) BOOL isHttps;
/** cer证书名字，如果cerName为空，将使用cerContent；当两者都有值，优先使用cerName */
@property (nonatomic,copy) NSString * cerName;
/** cer证书内容，data->base64解码之后的内容 */
@property (nonatomic,copy) NSString * cerContent;



+ (YHNet *)sharedNet;
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;



/**
 网络请求，现在暂时只支持GET、POST
 注意：如果parameters里面有中文，要对parameters里面的值进行中文转码
 */
- (NSURLSessionTask *)yh_netRequestWithType:(YHNetRequestType)requestType
                                    withURLString:(NSString *)URLString
                             withParameters:(nullable id)parameters
                                  isShowHUD:(BOOL)isShowHUD
                                hudBaseView:(nullable UIView *)hudBaseView
                                httpHeaders:(nullable NSDictionary<NSString *,NSString *> *)httpHeaders
                      requestSerializerType:(YHNetRequestSerializerType)requestSerializerType
                     responseSerializerType:(YHNetResponseSerializerType)responseSerializerType
                               successBlock:(nullable void(^)(id responseObject))successBlock
                                 errorBlock:(nullable void(^)(NSError *error))errorBlock;

/**
 GET请求便利方法
 requestSerializerType = YHNetRequestSerializerTypeKeyValue
 responseSerializerType = YHNetResponseSerializerTypeJson
 */
- (NSURLSessionTask *)yh_getNetRequestwithURLString:(NSString *)URLString
                                     withParameters:(nullable id)parameters
                                          isShowHUD:(BOOL)isShowHUD
                                        hudBaseView:(nullable UIView *)hudBaseView
                                        httpHeaders:(nullable NSDictionary<NSString *,NSString *> *)httpHeaders
                                       successBlock:(nullable void(^)(id responseObject))successBlock
                                         errorBlock:(nullable void(^)(NSError *error))errorBlock;
/**
 POST请求便利方法
 requestSerializerType = YHNetRequestSerializerTypeKeyValue
 responseSerializerType = YHNetResponseSerializerTypeJson
 */
- (NSURLSessionTask *)yh_postNetRequestwithURLString:(NSString *)URLString
                                     withParameters:(nullable id)parameters
                                          isShowHUD:(BOOL)isShowHUD
                                        hudBaseView:(nullable UIView *)hudBaseView
                                        httpHeaders:(nullable NSDictionary<NSString *,NSString *> *)httpHeaders
                                       successBlock:(nullable void(^)(id responseObject))successBlock
                                         errorBlock:(nullable void(^)(NSError *error))errorBlock;

/** 上传单张图片---POST */
- (NSURLSessionTask *)yh_uploadImageWithUrlString:(NSString *)urlString
                                       parameters:(nullable id)parameters
                                            image:(UIImage *)image
                                       imageScale:(CGFloat)imageScale
                                             name:(NSString *)name
                                         fileName:(NSString *)fileName
                                        isShowHud:(BOOL)isShowHud
                                      hudBaseView:(nullable UIView *)hudBaseView
                                      httpHeaders:(nullable NSDictionary *)httpHeaders
                                     successBlock:(nullable void(^)(id responseObject))successBlock
                                       errorBlock:(nullable void(^)(NSError *error))errorBlock;






/** 取消所有网络请求 */
- (void)yh_cancelAllNetRequest;
/** 取消某个网络请求 */
- (void)yh_cancelRequestWithTask:(NSURLSessionTask *)task;





/** 开启网络监测，一旦网络转台发生变化，都会走block回调 */
- (void)yh_startNetWorkMonitoringWithBlock:(nullable void(^)(YHNetworkStatus status))block;



@end





@interface YHNet (YHRequestHTTP)
+ (AFHTTPRequestSerializer *)requestSerializerForHTTP;
@end


@interface YHNet (YHRequestJSON)
+ (AFJSONRequestSerializer *)requestSerializerForJSON;
@end

@interface YHNet (YHResponseHTTP)
+ (AFHTTPResponseSerializer *)responseSerializerForHTTP;
@end



@interface YHNet (YHResponseJSON)
+ (AFJSONResponseSerializer *)responseSerializerForJSON;
@end



NS_ASSUME_NONNULL_END
