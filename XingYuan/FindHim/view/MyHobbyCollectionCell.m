//
//  MyHobbyCollectionCell.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MyHobbyCollectionCell.h"
@interface MyHobbyCollectionCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation MyHobbyCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.layer.cornerRadius = 3;
    self.titleLabel.clipsToBounds = true;
    self.titleLabel.text = @"";
    self.titleLabel.textColor = RGBColor(122, 128, 131, 1);
    self.titleLabel.backgroundColor = RGBColor(236, 238, 237, 1);
}

- (void)configWithModel:(ChildHobbyModel *)model{
    self.titleLabel.text = model.name;
    self.titleLabel.textColor = model.isselect ? [UIColor whiteColor] : RGBColor(122, 128, 131, 1);
    self.titleLabel.backgroundColor = model.isselect ? RGBColor(240, 53, 99, 1):RGBColor(236, 238, 237, 1);
}
@end
