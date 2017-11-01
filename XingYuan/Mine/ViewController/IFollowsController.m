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

@interface IFollowsController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *dataArray;
@property (nonatomic,assign) NSNumber *pageIndex;
@property (nonatomic,assign) NSNumber *pageSize;
@end

@implementation IFollowsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我关注的";
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
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
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:self.pageIndex forKey:@"pageindex"];
    [parameters setValue:self.pageSize forKey:@"pagesize"];
    
    [VVNetWorkTool postWithUrl:Url(Myfollowmember) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
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
    //
}
@end
