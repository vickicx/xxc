//
//  PhotoPreviewModel.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/23.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PhotoPreviewModel.h"

@implementation PhotoPreviewModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"picture"]) {
        NSArray *array = [NSArray arrayWithArray:value];
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:0];
        for (NSDictionary *dic in array) {
            PictureModel *pictures = [[PictureModel alloc] initWithDictionary:dic];
            [mutableArray addObject:pictures];
            
        }
        self.pictureModelArr = [NSMutableArray arrayWithArray:mutableArray];
    }
    
}
@end
