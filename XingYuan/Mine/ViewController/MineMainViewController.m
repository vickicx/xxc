//
//  MineMainViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/9/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MineMainViewController.h"
#import "MineTableViewCell.h"
#import "UserHomePagePopView.h"
#import "MyFloatView.h"
#import "MyPhotoViewController.h"


@interface MineMainViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    //头像
    UIImageView *_headerImg;
    //昵称
    UILabel *_nickLabel;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *backgroundImgV;//背景图
@property(nonatomic,assign)float backImgHeight;
@property(nonatomic,assign)float backImgWidth;
@property(nonatomic,assign)float backImgOrgy;
@property (nonatomic,copy) NSArray *imageArr;
@property (nonatomic,copy) NSArray *titleArr;
@property(nonatomic,strong)UserHomePagePopView *headImageView;//头视图


@end

@implementation MineMainViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.subviews[0].subviews[1].alpha = 0;
    self.navigationController.navigationBar.subviews[0].subviews[0].alpha = 0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArr = [NSArray arrayWithObjects:@"喜欢我的", @"我喜欢的", @"关注", @"成长", nil];
    self.titleArr = [NSArray arrayWithObjects:@"喜欢我的", @"我喜欢的", @"我关注的", @"成长中心", nil];
    
    self.view.backgroundColor = [UIColor redColor];
    [self createTableView];
    [self createRightButton];
    MyFloatView *floatView = [[MyFloatView alloc] initWithFrame:CGRectMake(12, 290, 351, 80)];
    [self.view addSubview:floatView];
   
    floatView.goMyTreasureView = ^{
        NSLog(@"跳转到我的财富界面");
    };
    floatView.goMyCertificationView = ^{
        NSLog(@"跳转到我的认证界面");
    };
    floatView.goMyInformationView = ^{
        NSLog(@"跳转到我的资料界面");
        MyPhotoViewController *myPhotoVC = [[MyPhotoViewController alloc] init];
        [self.navigationController pushViewController:myPhotoVC animated:YES];
    };

    
    
    // Do any additional setup after loading the view.
}



//头视图
-(UserHomePagePopView *)headImageView{
    if (!_headImageView) {
        _headImageView=[[UserHomePagePopView alloc]init];
        _headImageView.frame=CGRectMake(0, 0, kWIDTH, 223);
        _headImageView.backgroundColor=[UIColor clearColor];
        
        UIImage *image=[UIImage imageNamed:@"头像"];
        //图片的宽度设为屏幕的宽度，高度自适应
        _backgroundImgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 223)];
        _backgroundImgV.image=image;
        _backgroundImgV.userInteractionEnabled=YES;
        _backImgHeight=_backgroundImgV.frame.size.height;
        _backImgWidth=_backgroundImgV.frame.size.width;
        _backImgOrgy=_backgroundImgV.frame.origin.y;
        [self.view addSubview:_backgroundImgV];
        
        //_headImageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"个人页背景图.png"]];
        
        _headerImg=[[UIImageView alloc]init];
        [_headerImg setImage:[UIImage imageNamed:@"头像"]];
        [_headerImg.layer setMasksToBounds:YES];
        [_headerImg.layer setCornerRadius:35];
        _headerImg.backgroundColor=[UIColor whiteColor];
        _headerImg.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [_headerImg addGestureRecognizer:tap];
        [self.view addSubview:_headerImg];
        [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_backgroundImgV);
            make.size.mas_equalTo(CGSizeMake(70, 70));
        }];
        //昵称
        _nickLabel=[[UILabel alloc]init];
        _nickLabel.text=@"执念12o3";
        _nickLabel.textColor=[UIColor whiteColor];
        _nickLabel.textAlignment=NSTextAlignmentCenter;
        UIButton *fixBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        fixBtn.frame=CGRectMake(CGRectGetMaxX(_nickLabel.frame)+5, 114, 22, 22);
        [fixBtn setImage:[UIImage imageNamed:@"pencil-light-shadow"] forState:UIControlStateNormal];
        [fixBtn addTarget:self action:@selector(fixClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headImageView addSubview:fixBtn];
        [self.view addSubview:_nickLabel];
        [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).with.offset(64);
            make.centerX.equalTo(self.view);
            
        }];
    }
    return _headImageView;
}

-(void)createRightButton{
    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=rightItem;

}

-(void)rightBtnAction{
    NSLog(@"设置");
}



//创建TableView
-(void)createTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWIDTH, kHEIGHT-64 - 49) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:@"MineCell"];
        [self.view addSubview:_tableView];
    }
    _tableView.tableHeaderView = self.headImageView;
}




#pragma mark ---- UITableViewDelegate ----
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.image setImage:[UIImage imageNamed:self.imageArr[indexPath.row]]];
    cell.title.text = self.titleArr[indexPath.row];
    if (indexPath.row != 3) {
        cell.line.backgroundColor =[UIColor groupTableViewBackgroundColor];
        //[UIColor colorWithRed:184/255.0 green:186/255.0 blue:189/255.0 alpha:1];
    }
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
