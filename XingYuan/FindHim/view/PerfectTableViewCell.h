//
//  PerfectTableViewCell.h
//  XingYuan
//
//  Created by 陈曦 on 2017/11/6.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerfectTableViewCell : UITableViewCell
@property(nonatomic,strong)NSString * title;
@property (nonatomic,strong) void(^toBlock)(UIButton *sender);
@end
