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

//表单提交
+ (void)formSubmissionWithUrl:(NSString *)url body:(id)body progress:(ProgressBlock)progress formBlock:(void (^)(id <AFMultipartFormData> formData))block success:(SuccessBlock)success fail:(FailedBlock)fail{
    //AFN3.0+基于封住HTPPSession的句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    [manager POST:url parameters:body constructingBodyWithBlock:block progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        NSLog(@"上传成功 %@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
        NSLog(@"上传失败 %@", error);
    }];
}
@end
