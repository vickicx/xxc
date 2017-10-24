//
//  GrowthCenterTaskCell.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/19.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "GrowthCenterTaskCell.h"

@interface GrowthCenterTaskCell ()
@property (weak, nonatomic) IBOutlet UIView *grayPoint;
@property (weak, nonatomic) IBOutlet UILabel *firstLevelTitle;
@property (weak, nonatomic) IBOutlet UILabel *secondLevelTitle;
@property (weak, nonatomic) IBOutlet UIButton *handleBtn;

@end
@implementation GrowthCenterTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.grayPoint.layer.cornerRadius = 3;
    self.grayPoint.clipsToBounds = true;
    [self.handleBtn addTarget:self action:@selector(dealHandle) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configWithData:(NSNumber *)data{
    UIColor *handleAbleColor = RGBColor(43, 48, 52, 1);
    UIColor *unHandleAbleColor = RGBColor(141, 146, 149, 1);
    
    self.handleBtn.layer.borderWidth = 1;
    if([data isEqual:@1]){
        [self.handleBtn setTitleColor:handleAbleColor forState:UIControlStateNormal];
        self.handleBtn.layer.borderColor = handleAbleColor.CGColor;
        [self.handleBtn setTitle:@"领取奖励" forState:UIControlStateNormal];
        [self.handleBtn setUserInteractionEnabled:true];
    }else{
        [self.handleBtn setTitleColor:unHandleAbleColor forState:UIControlStateNormal];
        self.handleBtn.layer.borderColor = unHandleAbleColor.CGColor;
        [self.handleBtn setTitle:@"1/5" forState:UIControlStateNormal];
        [self.handleBtn setUserInteractionEnabled:false];
    }
}

//点击了右侧操作按钮
- (void)dealHandle{
    if(self.block != nil){
        self.block();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
