//
//  PictureModel.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/23.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PictureModel.h"

@implementation PictureModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ids = value;
    }
    if ([key isEqualToString:@"picture"]) {
        self.pic = value;
    }
}

@end
