//
//  VVNetWorkTool.h
//  GiftToYou
//
//  Created by vicki on 15/12/1.
//  Copyright © 2015年 vicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//请求进度
typedef void(^ProgressBlock)(NSProgress *progress);
//请求成功的block类型
typedef void(^SuccessBlock)(id result);
//请求失败的block类型
typedef void(^FailedBlock)(NSError *error);

/**
 *  返回值类型
 */
typedef NS_ENUM(NSUInteger, ResponseType) {
    /**
     *  JSON类型
     */
    ResponseTypeJSON,
    /**
     *  XML类型
     */
    ResponseTypeXML,
    /**
     *  DATA类型
     */
    ResponseTypeDATA,
};

/**
 *  body类型
 */
typedef NS_ENUM(NSUInteger, BodyType) {
    /**
     *  字符串类型
     */
    BodyTypeString,
    /**
     *  字典类型
     */
    BodyTypeDictionary,
};






@interface VVNetWorkTool : NSObject

/**
 *  get请求
 *
 *  @param url          网址
 *  @param body         参数
 *  @param header       请求头
 *  @param responseType 返回值类型
 *  @param progress     响应进度
 *  @param success      成功响应
 *  @param fail         失败响应
 */
+ (void)getWithUrl:(NSString *)url parameter:(id )body bodyType:(BodyType)bodytype httpHeader:(NSDictionary *)header responseType:(ResponseType)responseType progress:(ProgressBlock)progress success:(SuccessBlock)success fail:(FailedBlock)fail;


//post请求
/**
 *  post请求
 *
 *  @param url          网址
 *  @param body         body
 *  @param bodytype     body类型
 *  @param header       请求头
 *  @param responseType 返回值类型
 *  @param progress     响应进度
 *  @param success      成功响应
 *  @param fail         失败响应
 */
+ (void)postWithUrl:(NSString *)url body:(id)body bodyType:(BodyType)bodytype httpHeader:(NSDictionary *)header responseType:(ResponseType)responseType progress:(ProgressBlock)progress success:(SuccessBlock)success fail:(FailedBlock)fail;






@end
