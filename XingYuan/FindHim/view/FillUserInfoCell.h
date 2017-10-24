//
//  FillUserInfoCell.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/13.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FillUserInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightInfoLabel;

//信息为空时，右侧信息Label显示的字符串
@property (nonatomic,copy) NSString *placeHolder;

//信息为空时，右侧Label显示文字的颜色
@property (nonatomic,assign) UIColor *placeHolderColor;

//信息值
@property (nonatomic,copy) NSString *infoValue;

//显示信息值时的颜色
@property (nonatomic,assign) UIColor *infoValueColor;
/**
 设置右边Label的值
 */
@end
