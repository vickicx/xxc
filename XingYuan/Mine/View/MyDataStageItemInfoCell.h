//
//  MyDataStageItemInfoCell.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDataStageItemInfoCell : UICollectionViewCell

/**
 给cell设置值

 @param title title值
 @param color 背景色
 */
- (void)configWithTitle:(NSString *)title backgroundColor:(UIColor *)color;
@end
