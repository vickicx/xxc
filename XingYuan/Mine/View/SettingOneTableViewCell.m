//
//  SettingOneTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "SettingOneTableViewCell.h"

@implementation SettingOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.title.font = FONT_WITH_S(17);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
