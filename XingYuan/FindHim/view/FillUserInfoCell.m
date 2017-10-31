//
//  FillUserInfoCell.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/13.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "FillUserInfoCell.h"

NSString *FillUserInfoCellRightInfoValueChangedNotice = @"FillUserInfoCellRightInfoValueChangedNotice";
@interface FillUserInfoCell()
@end
@implementation FillUserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.rightInfoLabel.font = FONT_WITH_S(15);
    self.leftLabel.font = FONT_WITH_S(16)
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.infoValue = nil;
}

- (void)setInfoValue:(NSString *)infoValue{
    NSInteger lenght = [infoValue length];
    if(lenght){
        _infoValue = infoValue;
        self.rightInfoLabel.textColor = self.infoValueColor == nil ? [UIColor blackColor]:self.infoValueColor;
        self.rightInfoLabel.text = infoValue;
    }else{
        _infoValue = nil;
        self.rightInfoLabel.textColor = self.placeHolderColor == nil ? [UIColor grayColor]:self.placeHolderColor;
        self.rightInfoLabel.text = (self.placeHolder == nil) ? @"请选择":self.placeHolder;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:FillUserInfoCellRightInfoValueChangedNotice object:nil];
//为空值时服务器返回的"",因此不能用下面的方法判断
//    _infoValue = infoValue;
//    [[NSNotificationCenter defaultCenter] postNotificationName:FillUserInfoCellRightInfoValueChangedNotice object:nil];
//    if(infoValue == nil){
//        self.rightInfoLabel.textColor = self.placeHolderColor == nil ? [UIColor grayColor]:self.placeHolderColor;
//        self.rightInfoLabel.text = (self.placeHolder == nil) ? @"请选择":self.placeHolder;
//    }
//    if(infoValue != nil){
//        self.rightInfoLabel.textColor = self.infoValueColor == nil ? [UIColor blackColor]:self.infoValueColor;
//        self.rightInfoLabel.text = infoValue;
//    }
}

- (void)setInfoValueColor:(UIColor *)infoValueColor{
    _infoValueColor = infoValueColor;
    if(self.infoValue!=nil&&self.infoValueColor != nil){
        self.rightInfoLabel.textColor = infoValueColor;
    }
}

- (void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    if(self.infoValue == nil){
        self.rightInfoLabel.textColor = self.placeHolderColor == nil ? [UIColor grayColor] : self.placeHolderColor;
        self.rightInfoLabel.text = (placeHolder == nil) ? @"请选择":placeHolder;
    }
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    _placeHolderColor = placeHolderColor;
    if(self.infoValue == nil && placeHolderColor != nil){
        self.rightInfoLabel.textColor = placeHolderColor;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
