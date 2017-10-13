//
//  MineTableViewCell.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/11.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewCell : UITableViewCell
-(void)setValues:(NSString *)imageName title:(NSString *)title;
@property (nonatomic,strong) UIImageView *image;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *line;
@end
