//
//  HeightRangeModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/11/1.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeightRangeModel : NSObject
@property (nonatomic,assign) NSInteger littleHeight;   //左侧较小身高
@property (nonatomic,strong) NSArray *biggerHeights;     //左侧较小身高对应的右侧较大身高选项
@end
