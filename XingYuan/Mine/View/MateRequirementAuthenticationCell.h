//
//  MateRequirementAuthenticationCell.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThreeStageScreeningModel.h"

@interface MateRequirementAuthenticationCell : UITableViewCell
@property (nonatomic,strong) void(^editBlock)();
@property (nonatomic,copy) NSString *leftLabelTitle;
- (void)configWithModel:(ThreeStageScreeningModel *)model;
@end
