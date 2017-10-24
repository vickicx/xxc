//
//  GrowthCenterTaskCell.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/19.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GrowthCenterTaskCell : UITableViewCell
@property (nonatomic,strong) void(^block)(void);

- (void)configWithData:(NSNumber *)data;
@end
