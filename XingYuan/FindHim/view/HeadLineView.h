//
//  HeadLineView.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/9.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol headLineDelegate <NSObject>

@optional
- (void)refreshHeadLine:(NSInteger)currentIndex;

@end
@interface HeadLineView : UIView
@property(nonatomic,assign)NSInteger CurrentIndex;
@property(nonatomic,strong)NSArray * titleArray;
@property(nonatomic,assign)id<headLineDelegate>delegate;

@end
