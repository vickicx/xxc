//
//  LooksEvaluatePickerView.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/14.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PickerView.h"

@interface LooksEvaluatePickerView : PickerView
@property (nonatomic,strong) void(^looksEvaluateBlock)(NSString *evaluate);

/**
 easy way to get a LooksEvaluatePickerView instance
 
 @return LooksEvaluatePickerView instance
 */
+ (instancetype)looksEvaluatePickerView;
@end
