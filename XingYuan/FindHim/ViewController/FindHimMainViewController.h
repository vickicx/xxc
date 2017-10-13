//
//  FindHimMainViewController.h
//  XingYuan
//
//  Created by 陈曦 on 2017/9/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//  识TA首页

#import "ViewController.h"
#import "TYCyclePagerView.h"
#import "FindHimCollectionViewCell.h"
#import "UserHomePageViewController.h"

@interface FindHimMainViewController : ViewController<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate, jumpToDelegate>
@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) NSArray *datas;
@end
