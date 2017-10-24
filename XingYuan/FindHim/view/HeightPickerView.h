//
//  HeightPickerView.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/14.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PickerView.h"

@interface HeightPickerView : PickerView
@property (nonatomic,strong) void(^heightPickerBlock)(NSString *height);

+ (instancetype)heightPickerView;
@end
