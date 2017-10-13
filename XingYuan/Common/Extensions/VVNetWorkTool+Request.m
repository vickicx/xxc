//
//  VVNetWorkTool+Request.m
//  XingYuan
//
//  Created by YunKuai on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "VVNetWorkTool+Request.h"

@implementation VVNetWorkTool (Request)
/**
 *  get请求
 *
 *  @param url          网址
 *  @param body         参数
 *  @param progress     响应进度
 *  @param success      成功响应
 *  @param fail         失败响应
 */
+ (void)getWithUrl:(NSString *)url parameter:(id )body progress:(ProgressBlock)progress success:(SuccessBlock)success fail:(FailedBlock)fail{
    [self getWithUrl:url parameter:body bodyType:BodyTypeDictionary httpHeader:nil responseType:ResponseTypeJSON progress:progress success:success fail:fail];
}


//post请求
/**
 *  post请求
 *
 *  @param url          网址
 *  @param body         body
 *  @param progress     响应进度
 *  @param success      成功响应
 *  @param fail         失败响应
 */
+ (void)postWithUrl:(NSString *)url body:(id)body progress:(ProgressBlock)progress success:(SuccessBlock)success fail:(FailedBlock)fail{
    [self postWithUrl:url body:body bodyType:BodyTypeDictionary httpHeader:nil responseType:ResponseTypeJSON progress:progress success:success fail:fail];
}
@end
