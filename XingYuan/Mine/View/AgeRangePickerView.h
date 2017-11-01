//
//  AgeRangePickerView.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/31.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PickerView.h"

typedef void (^AgeRangeBlock)(NSInteger,NSInteger);

@interface AgeRangePickerView : PickerView
@property (nonatomic,weak) UIPickerView *pickerView;

+ (instancetype)pickerViewWithBlock:(AgeRangeBlock)ageBlock;
@end
