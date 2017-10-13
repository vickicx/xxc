//
//  ShowInformationView.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowInformationView : UIView
/**
 高度自适应不需要指定高度,只需要指定x,y,width
 @param origin 标签控件的x,y坐标
 @param width 标签控件的宽度
 @return 标签控件实例
 */
-(instancetype)initWith:(CGPoint)origin width:(CGFloat)width;

/**
 初始化数据源
 */
@property(nonatomic,strong)NSArray<UIView *> *dataSource;

/**
 最小的列间距
 */
@property(nonatomic,assign)CGFloat minColumnSpace;

/**
 最小的行间距
 */
@property(nonatomic,assign)CGFloat minRowSpace;

/**
 标签展示区域距离控件上,下,左,右距离
 */
@property(nonatomic,assign)UIEdgeInsets minMarginSpace;

@property(nonatomic,strong)UIColor * color;
@property (nonatomic,assign) int i;


@end
