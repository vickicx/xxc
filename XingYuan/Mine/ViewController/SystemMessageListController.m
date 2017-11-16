//
//  SystemMessageListController.m
//  XingYuan
//
//  Created by YunKuai on 2017/11/1.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "SystemMessageListController.h"
#import "SystemMessageCell.h"
#import "SystemMessageModel.h"
#import "SystemMessageDetailController.h"

@interface SystemMessageListController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation SystemMessageListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SystemMessageCell" bundle:nil] forCellReuseIdentifier:@"SystemMessageCell"];

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
    
    [VVNetWorkTool postWithUrl:Url(MemberInformation) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *baseModel = [BaseModel new];
        [baseModel setValuesForKeysWithDictionary:result];
        
        NSArray *datas = [result valueForKey:@"data"];
        if(self.pageIndex == 1){[self.dataArray removeAllObjects];}
        for(int i=0;i<datas.count;i++){
            SystemMessageModel *systemMessageModel = [SystemMessageModel new];
            [systemMessageModel setValuesForKeysWithDictionary:datas[i]];
            [self.dataArray addObject:systemMessageModel];
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
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"没有新的通知" attributes:attributes];
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
    SystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SystemMessageCell" forIndexPath:indexPath];
    SystemMessageModel *systemMessageModel = self.dataArray[indexPath.row];
    [cell configWithModel:systemMessageModel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell点击事件
    SystemMessageModel *model = self.dataArray[indexPath.row];
    SystemMessageDetailController *systemMessageDetailController = [[SystemMessageDetailController alloc] init];
    systemMessageDetailController.msgid = model.Id;
    [self.navigationController pushViewController:systemMessageDetailController animated:true];
}

@end
