//
//  BodyShapPickerView.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/14.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PickerView.h"

@interface BodyShapPickerView : PickerView
@property (nonatomic,strong) void(^bodyPickerBlock)(NSString *bodyShap);


/**
 easy way to get a BodyShapPickerView instance

 @return BodyShapPickerView instance
 */
+ (instancetype)bodyShapPickerView;
@end
