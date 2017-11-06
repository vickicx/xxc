//
//  LikeMeTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/18.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "LikeMeTableViewCell.h"

@implementation LikeMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.age.layer.borderColor = self.height.layer.borderColor = self.constellation.layer.borderColor = self.job.layer.borderColor = [RGBColor(253, 149, 173, 1) CGColor];
    self.age.layer.borderWidth = self.height.layer.borderWidth = self.constellation.layer.borderWidth = self.job.layer.borderWidth = 0.5f;
    self.age.layer.cornerRadius = self.height.layer.cornerRadius = self.constellation.layer.cornerRadius = self.job.layer.cornerRadius = 3;
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
