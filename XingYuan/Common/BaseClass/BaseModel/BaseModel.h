//
//  BaseModel.h
//  mingjieloan
//
//  Created by vicki on 2016/12/20.
//  Copyright © 2016年 vicki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
//服务器返回的状态码
@property (nonatomic,assign) NSNumber *code;
//结果描述信息
@property (nonatomic,copy) NSString *msg;

@property (nonatomic, copy) NSString *nId;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
/**
 *  赋值
 *
 *  @param value JSONValue
 *  @param key    JSONKey
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

- (NSArray *)propertyDescriptions;
@end
