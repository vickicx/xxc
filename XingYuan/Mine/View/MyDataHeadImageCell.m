//
//  MyDataHeadImageCell.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MyDataHeadImageCell.h"

@interface MyDataHeadImageCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@end
@implementation MyDataHeadImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftLabel.font = FONT_WITH_S(16)
    self.leftLabel.textColor = RGBColor(43, 48, 52, 1);
    self.headImgV.layer.cornerRadius = 3;
    self.headImgV.clipsToBounds = true;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.headImgV setHidden:true];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
