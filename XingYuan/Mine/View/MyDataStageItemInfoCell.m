//
//  MyDataStageItemInfoCell.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MyDataStageItemInfoCell.h"

@interface MyDataStageItemInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation MyDataStageItemInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.infoLabel.layer.cornerRadius = 3;
    self.infoLabel.clipsToBounds = true;
}

- (void)configWithTitle:(NSString *)title backgroundColor:(UIColor *)color{
    self.infoLabel.text = title;
    self.infoLabel.backgroundColor = color;
}

@end
