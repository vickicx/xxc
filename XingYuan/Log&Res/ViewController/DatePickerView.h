//
//  DatePickerView.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/12.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerView : UIView
@property (nonatomic,strong) void(^datePickerBlock)(NSDate *date);

/**
 easy way to get a DatePickerView instance

 @return a DatePickerView instance
 */
+ (instancetype)datePickerView;
@end
