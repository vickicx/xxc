//
//  AddressPickerView.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/12.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressPickerView : UIView
@property (nonatomic,strong) void(^block)(NSString *province,NSString *city);

+ (instancetype)addressPickerView;
- (void)toShow;
@end
