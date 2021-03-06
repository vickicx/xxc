//
//  VVNetWorkTool+Request.h
//  XingYuan
//
//  Created by YunKuai on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "VVNetWorkTool.h"

@interface VVNetWorkTool (Request)


/**
 *  get请求
 *
 *  @param url          网址
 *  @param body         参数
 *  @param progress     响应进度
 *  @param success      成功响应
 *  @param fail         失败响应
 */
+ (void)getWithUrl:(NSString *)url parameter:(id )body progress:(ProgressBlock)progress success:(SuccessBlock)success fail:(FailedBlock)fail;


//post请求
/**
 *  post请求
 *
 *  @param url          网址
 *  @param body         body
 *  @param bodytype     body类型
 *  @param progress     响应进度
 *  @param success      成功响应
 *  @param fail         失败响应
 */
+ (void)postWithUrl:(NSString *)url body:(id)body progress:(ProgressBlock)progress success:(SuccessBlock)success fail:(FailedBlock)fail;


/**
 表单提交

 @param url 网址
 @param body 参数
 @param progress 响应进度
 @param block 表单block
 @param success 成功响应
 @param fail 失败响应
 */
+ (void)formSubmissionWithUrl:(NSString *)url body:(id)body progress:(ProgressBlock)progress formBlock:(void (^)(id <AFMultipartFormData> formData))block success:(SuccessBlock)success fail:(FailedBlock)fail;
@end
