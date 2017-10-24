//
//  ConstellationPickerView.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/14.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PickerView.h"

@interface ConstellationPickerView : PickerView
@property (nonatomic,strong) void(^constellationPickerBlock)(NSString *constellation);

/**
 easy way to get a ConstellationPickerView instance
 
 @return ConstellationPickerView instance
 */
+ (instancetype)constellationPickerView;
@end
