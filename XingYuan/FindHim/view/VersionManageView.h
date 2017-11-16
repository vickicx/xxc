//
//  VersionManageView.h
//  XingYuan
//
//  Created by YunKuai on 2017/11/9.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VersionMessageModel.h"

@interface VersionManageView : UIView

/**
 根据model实例化版本更新弹窗

 @param model 版本信息
 */
+ (void)showWithModel:(VersionMessageModel *)model;
@end
