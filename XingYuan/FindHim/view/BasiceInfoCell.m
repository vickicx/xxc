//
//  BasiceInfoCell.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/13.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BasiceInfoCell.h"

@interface BasiceInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@end

@implementation BasiceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setTitle:(id)title{
    _title = title;
    if([title isKindOfClass:[NSAttributedString class]]){
        self.infoLabel.attributedText = title;
    }
    if([title isKindOfClass:[NSString class]]){
        self.infoLabel.text = title;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
