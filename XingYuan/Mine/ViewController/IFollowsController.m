//
//  IFollowsController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/30.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "IFollowsController.h"
#import "MemberModel.h"
#import "MemberListCell.h"
#import "UserHomePageViewController.h"
#import  <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface IFollowsController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation IFollowsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我关注的";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MemberListCell" bundle:nil] forCellReuseIdentifier:@"MemberListCell"];

    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageIndex = 1;
        [self requestData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex += 1;
        [self requestData];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.pageIndex = 1;
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)requestData{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:[NSNumber numberWithInteger:self.pageIndex] forKey:@"pageindex"];
    [parameters setValue:[NSNumber numberWithInteger:self.pageSize] forKey:@"pagesize"];
    
    [VVNetWorkTool postWithUrl:Url(Myfollowmember) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *baseModel = [BaseModel new];
        [baseModel setValuesForKeysWithDictionary:result];
        
        NSArray *datas = [result valueForKey:@"data"];
        if(self.pageIndex == 1){[self.dataArray removeAllObjects];}
        for(int i=0;i<datas.count;i++){
            MemberModel *memberModel = [MemberModel new];
            [memberModel setValuesForKeysWithDictionary:datas[i]];
            [self.dataArray addObject:memberModel];
        }
        self. tableView.emptyDataSetDelegate = self;
        self.tableView.emptyDataSetSource = self;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        [JGProgressHUD showErrorWithModel:baseModel In:self.view];
    } fail:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

#pragma mark - DZNEmptyDataSetSource,DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"还没有新内容哦"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    UIFont *font = FONT_WITH_S(15);
    NSDictionary *attributes = @{NSFontAttributeName:font};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"你还没关注任何人哦" attributes:attributes];
    return attributedString;
}

#pragma - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MemberListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemberListCell" forIndexPath:indexPath];
    MemberModel *memberModel = self.dataArray[indexPath.row];
    [cell configWithModel:memberModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell点击事件
    MemberModel *memberModel = self.dataArray[indexPath.row];
    UserHomePageViewController *userPage = [[UserHomePageViewController alloc] init];
    userPage.seememberid = [NSString stringWithFormat:@"%d",memberModel.followmemberid];
    [self.navigationController pushViewController:userPage animated:YES];
}
@end
