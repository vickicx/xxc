//
//  MyIMFriendsController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/30.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MyIMFriendsController.h"
#import "MemberModel.h"
#import "MemberListCell.h"
#import "UserHomePageViewController.h"
#import  <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface MyIMFriendsController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (weak,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *dataArray;
@property (nonatomic,assign) NSNumber *pageIndex;
@property (nonatomic,assign) NSNumber *pageSize;
@end

@implementation MyIMFriendsController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"我的好友";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"我的好友";
    label.font = FONT_WITH_S(18);
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:label1];
    self.navigationItem.rightBarButtonItem = itme;
    self.navigationItem.titleView = label;

    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.emptyDataSetDelegate = self;
    tableView.emptyDataSetSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"MemberListCell" bundle:nil] forCellReuseIdentifier:@"MemberListCell"];
    tableView.estimatedRowHeight = 200;
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    
    self.pageIndex = @1;
    self.pageSize = @20;
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)requestData{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[[[NIMSDK sharedSDK] loginManager] currentAccount] forKey:@"imaccid"];
    [parameters setValue:self.pageIndex forKey:@"pageindex"];
    [parameters setValue:self.pageSize forKey:@"pagesize"];
    
    [VVNetWorkTool postWithUrl:Url(IMFriend) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *baseModel = [BaseModel new];
        [baseModel setValuesForKeysWithDictionary:result];
        
        NSMutableArray *dataArray = [NSMutableArray new];
        NSArray *datas = [result valueForKey:@"data"];
        for(int i=0;i<datas.count;i++){
            MemberModel *memberModel = [MemberModel new];
            [memberModel setValuesForKeysWithDictionary:datas[i]];
            [dataArray addObject:memberModel];
        }
        self.dataArray = dataArray;
        [self.tableView reloadData];

        [JGProgressHUD showErrorWithModel:baseModel In:self.view];
    } fail:^(NSError *error) {
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
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"你暂时没有好友哦" attributes:attributes];
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
    userPage.seememberid = [NSString stringWithFormat:@"%d",memberModel.Id];
    [self.navigationController pushViewController:userPage animated:YES];
}
@end
