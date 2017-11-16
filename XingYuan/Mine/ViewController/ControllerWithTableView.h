//
//  ControllerWithTableView.h
//  XingYuan
//
//  Created by YunKuai on 2017/11/9.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh/MJRefresh.h>
#import  <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface ControllerWithTableView : ViewController<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end
