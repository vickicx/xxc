//
//  HeightPickerView.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/12.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeightPickerView : UIView
@property (nonatomic,strong) void(^heightPickerBlock)(NSString *height);

+ (instancetype)heightPickerView;
@end
