//
//  DataPickerView.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/14.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PickerView.h"

@interface DataPickerView : PickerView

/**
 easy way to get a DataPickerView instance

 @param dataArray pickerView的数据源
 @param row 初始选定行
 @param block 点击确定的回调事件
 @return 返回一个DataPickerView实例
 */
+ (instancetype)pickerViewWithDataArray:(NSArray *)dataArray initialSelectRow:(NSInteger)row dataPickerBlock:(void (^)(NSString *))block;
@end
