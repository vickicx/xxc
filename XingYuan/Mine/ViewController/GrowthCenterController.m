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

@interface GrowthCenterController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@end

@implementation GrowthCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"成长中心";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图"]];
    imgV.frame = tableHeaderView.bounds;
    [tableHeaderView addSubview:imgV];
    [tableView setTableHeaderView:tableHeaderView];
    tableView.estimatedRowHeight = 100;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GrowthCenterTaskCell" bundle:nil] forCellReuseIdentifier:@"GrowthCenterTaskCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if(section == 0){
//        return 50;
//    }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FillUserInfoNoticeHeaderView *noticeHeaderView = [[FillUserInfoNoticeHeaderView alloc] init];
    if(section == 0){
        noticeHeaderView.notice = @"新手任务";
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
    cell.block = ^(void){
        DDLogInfo(@"领取奖励");
    };
    [cell configWithData:[NSNumber numberWithInteger:indexPath.row]];
    return cell;
}

@end
