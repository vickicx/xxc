//
//  GrowthCenterController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/19.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "GrowthCenterController.h"
#import "GrowthCenterTaskCell.h"
#import "FillUserInfoNoticeHeaderView.h"
#import  <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import <MJRefresh/MJRefresh.h>
#import "MyTaskModel.h"

@interface GrowthCenterController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic,strong) NSArray *newbieTasks; //新手任务
@property (nonatomic,strong) NSArray *dailyTasks;   //日常任务
@end

@implementation GrowthCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成长中心";
    
    self.newbieTasks = [NSArray new];
    self.dailyTasks = [NSArray new];

    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];

    [self.tableView registerNib:[UINib nibWithNibName:@"GrowthCenterTaskCell" bundle:nil] forCellReuseIdentifier:@"GrowthCenterTaskCell"];
    
    //为tableView添加头视图
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200*FitHeight)];
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图"]];
    imgV.frame = tableHeaderView.bounds;
    [tableHeaderView addSubview:imgV];
    [self.tableView setTableHeaderView:tableHeaderView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)requestData{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    [VVNetWorkTool postWithUrl:Url(Getmytask) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *baseModel = [BaseModel new];
        [baseModel setValuesForKeysWithDictionary:result];
        
        NSDictionary *data = [result valueForKey:@"data"];
        NSArray *newHandTasksDatas = [data valueForKey:@"newhand"];
        NSArray *dailyTasksDatas = [data valueForKey:@"daily"];
        
        NSMutableArray *newHandTasks = [NSMutableArray new];
        for(NSDictionary *newHandTaskData in newHandTasksDatas){
            MyTaskModel *taskModel = [MyTaskModel new];
            [taskModel setValuesForKeysWithDictionary:newHandTaskData];
            [newHandTasks addObject:taskModel];
        }
        self.newbieTasks = newHandTasks;
        
        NSMutableArray *dailyTasks = [NSMutableArray new];
        for(NSDictionary *dailyTaskData in dailyTasksDatas){
            MyTaskModel *taskModel = [MyTaskModel new];
            [taskModel setValuesForKeysWithDictionary:dailyTaskData];
            [dailyTasks addObject:taskModel];
        }
        self.dailyTasks = dailyTasks;
        self. tableView.emptyDataSetDelegate = self;
        self.tableView.emptyDataSetSource = self;
        [self.tableView reloadData];
        
        [JGProgressHUD showErrorWithModel:baseModel In:self.view];
        [self.tableView.mj_header endRefreshing];
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - DZNEmptyDataSetSource,DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"还没有新内容哦"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    UIFont *font = FONT_WITH_S(15);
    NSDictionary *attributes = @{NSFontAttributeName:font};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"没有新的任务" attributes:attributes];
    return attributedString;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //新手任务不为空、日常任务不为空
    if(self.newbieTasks.count != 0 && self.dailyTasks.count != 0){
        return 2;
    }
    //新手任务不为空、日常任务为空
    if(self.newbieTasks.count != 0 && self.dailyTasks.count == 0){
        return 1;
    }
    //新手任务为空、日常任务不为空
    if(self.newbieTasks.count == 0 && self.dailyTasks.count != 0){
        return 1;
    }
    //新手任务为空、日常任务为空
    if(self.newbieTasks.count == 0 && self.dailyTasks.count == 0){
        return 0;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        if(self.newbieTasks.count != 0){return self.newbieTasks.count;}
        if(self.newbieTasks.count == 0 && self.dailyTasks.count != 0){return self.dailyTasks.count;}
    }
    if(section == 1){
        return self.dailyTasks.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50*FitHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FillUserInfoNoticeHeaderView *noticeHeaderView = [[FillUserInfoNoticeHeaderView alloc] init];
    if(section == 0){
        if(self.newbieTasks.count != 0){noticeHeaderView.notice = @"新手任务";}
        if(self.newbieTasks.count == 0 && self.dailyTasks.count != 0){noticeHeaderView.notice = @"日常任务";}
    }
    if(section == 1){
        noticeHeaderView.notice = @"日常任务";
    }
    return noticeHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GrowthCenterTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GrowthCenterTaskCell"];
    cell.getAwardBlock = ^(MyTaskModel *model){
        //网络请求领奖
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        [parameters setValue:[Helper memberId] forKey:@"memberid"];
        [parameters setValue:model.Id forKey:@"membertaskid"];
        [JGProgressHUD showStatusWith:nil In:self.view];
        [VVNetWorkTool postWithUrl:Url(Finishaward) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
            BaseModel *baseModel = [BaseModel new];
            [baseModel setValuesForKeysWithDictionary:result];
            [self requestData];
            [JGProgressHUD showResultWithModel:baseModel In:self.view];
        } fail:^(NSError *error) {
            [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
        }];
    };
    MyTaskModel *myTaskModel;
    if(indexPath.section == 0){
        if(self.newbieTasks.count != 0){myTaskModel = self.newbieTasks[indexPath.row];}
        if(self.newbieTasks.count == 0 && self.dailyTasks.count != 0){myTaskModel = self.dailyTasks[indexPath.row];}
    }
    if(indexPath.section == 1){
        myTaskModel = self.dailyTasks[indexPath.row];
    }
    [cell configWithModel:myTaskModel];
    return cell;
}

@end
