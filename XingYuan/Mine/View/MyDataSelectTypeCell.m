//
//  MyDataSelectTypeCell.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MyDataSelectTypeCell.h"

@interface MyDataSelectTypeCell ()
@property (weak, nonatomic) IBOutlet UIButton *mydataBtn;
@property (weak, nonatomic) IBOutlet UIButton *suposeTypeBtn;

@end

@implementation MyDataSelectTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self dealSelectMyData:self.mydataBtn];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

//选择了我的资料
- (IBAction)dealSelectMyData:(UIButton *)sender {
    [self.suposeTypeBtn setSelected:false];
    [self.mydataBtn setSelected:true];
    if(self.selectTypeBlock != nil){
        self.selectTypeBlock(MyDataSelectTypeMyData);
    }
}

//选择了择偶标准
- (IBAction)dealSelectSuposeStandard:(UIButton *)sender {
    [self.mydataBtn setSelected:false];
    [self.suposeTypeBtn setSelected:true];
    if(self.selectTypeBlock != nil){
        self.selectTypeBlock(MyDataSelectTypeSuposeStandard);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
