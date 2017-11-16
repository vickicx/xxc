//
//  LikeMeViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/18.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "LikeMeViewController.h"
#import "LikeMeTableViewCell.h"

@interface LikeMeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation LikeMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"喜欢我的";
}

//创建TableView
-(void)createTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64*FitHeight, kWIDTH, kHEIGHT-64*FitHeight - 49*FitHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.scrollEnabled = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"LikeMeTableViewCell" bundle:nil] forCellReuseIdentifier:@"LikeMeTableViewCell"];
        [self.view addSubview:_tableView];
    }
}
#pragma mark ---- UITableViewDelegate ----

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 127*FitHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LikeMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LikeMeTableViewCell"];
    
//    [cell.image setImage:[UIImage imageNamed:self.imageArr[indexPath.row]]];
//    cell.title.text = self.titleArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell被点击恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
