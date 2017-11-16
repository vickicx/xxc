//
//  ControllerWithTableView.m
//  XingYuan
//
//  Created by YunKuai on 2017/11/9.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ControllerWithTableView.h"

@interface ControllerWithTableView ()

@end

@implementation ControllerWithTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray new];
    self.pageSize = 20;
    self.pageIndex = 1;
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;

    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 200;
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    
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
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"" attributes:attributes];
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
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
@end
