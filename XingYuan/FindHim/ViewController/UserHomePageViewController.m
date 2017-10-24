//
//  UserHomePageViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/9.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "UserHomePageViewController.h"
#import "UserHomePhotoTableViewCell.h"
#import "UserAnalysisTableViewCell.h"
#import "PersonalIntroductionTableViewCell.h"
#import "BasicInformationTableViewCell.h"
#import "PersonalCircumstancesTableViewCell.h"
#import "AuthenticationInformationTableViewCell.h"
#import "familyInformationTableViewCell.h"
#import "futurePlanningTableViewCell.h"
#import "UserSpouseStandardTableViewCell.h"
#import "Masonry.h"
#import "MatchingTableViewCell.h"

@interface UserHomePageViewController ()<NavHeadTitleViewDelegate,headLineDelegate,UITableViewDataSource,UITableViewDelegate>
#define JXColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
{
    //头像
    UIImageView *_headerImg;
    //昵称
    UILabel *_nickLabel;
    NSMutableArray *_dataArray0;
    NSMutableArray *_dataArray1;
    NSMutableArray *_dataArray2;
}
@property(nonatomic,strong)UIImageView *backgroundImgV;//背景图
@property(nonatomic,assign)float backImgHeight;
@property(nonatomic,assign)float backImgWidth;
@property(nonatomic,assign)float backImgOrgy;
@property(nonatomic,strong)NavHeadTitleView *NavView;//导航栏
@property(nonatomic,strong)UserHomePagePopView *headImageView;//头视图
@property(nonatomic,strong)HeadLineView *headLineView;//
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,assign)int rowHeightP;
@property(nonatomic,assign)int rowHeightB;
@property(nonatomic,assign)int rowHeightFa;
@property(nonatomic,assign)int rowHeightFu;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) UIVisualEffectView *visualview;
@end

@implementation UserHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.delegate = self;
    //拉伸顶部图片
//    [self lashenBgView];
    //初始化数据源
    [self loadData];
    //创建TableView
    [self createTableView];
    //创建导航栏
    [self createNav];
    [self createTabBar];
    
    [self.tableView reloadData];
    
    [self requestData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellHeight:) name:@"CellHeightP" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellHeight1:) name:@"CellHeightB" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellHeight3:) name:@"CellHeightFu" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellHeight2:) name:@"CellHeightFa" object:nil];
}
#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

//创建数据源
-(void)loadData{
    _currentIndex=0;
    _dataArray0=[[NSMutableArray alloc]init];
    _dataArray1=[[NSMutableArray alloc]init];
    _dataArray2=[[NSMutableArray alloc]init];
    for (int i=0; i < 3; i++) {
        if (i == 0) {
            for (int i=0; i<10; i++) {
                NSString * string=[NSString stringWithFormat:@"第%d行",i];
                [_dataArray0 addObject:string];
            }
        }else if(i == 1){
            for (int i=1; i<8; i++) {
                NSString * string=[NSString stringWithFormat:@"%d 娃",i];
                [_dataArray1 addObject:string];
            }
        }else if (i == 2){
            for (int i=0; i<3; i++) {
                NSString * string=[NSString stringWithFormat:@"this is %d",i];
                [_dataArray2 addObject:string];
            }
        }
    }
}

//创建TableView
-(void)createTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWIDTH, kHEIGHT-64 - 49) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[UserHomePhotoTableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[UserAnalysisTableViewCell class] forCellReuseIdentifier:@"analysisCell"];
        [_tableView registerClass:[PersonalIntroductionTableViewCell class] forCellReuseIdentifier:@"introductionCell"];
        [_tableView registerClass:[BasicInformationTableViewCell class] forCellReuseIdentifier:@"informationCell"];
        [_tableView registerClass:[PersonalCircumstancesTableViewCell class] forCellReuseIdentifier:@"circumstancesCell"];
        [_tableView registerClass:[AuthenticationInformationTableViewCell class] forCellReuseIdentifier:@"AuthenticationInformationCell"];
        [_tableView registerClass:[familyInformationTableViewCell class] forCellReuseIdentifier:@"familyCell"];
        [_tableView registerClass:[futurePlanningTableViewCell class] forCellReuseIdentifier:@"futureCell"];
        [_tableView registerClass:[UserSpouseStandardTableViewCell class] forCellReuseIdentifier:@"SpouseStandardCell"];
         [_tableView registerClass:[MatchingTableViewCell class] forCellReuseIdentifier:@"MatchingTableViewCell"];
        
               [self.view addSubview:_tableView];
    }
    [_tableView setTableHeaderView:self.headImageView];
}

- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    UIView *targetview = sender.view;
    if(targetview.tag == 1) {
        return;
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (_currentIndex>1) {
            return;
        }
        _currentIndex++;
    }else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (_currentIndex<=0) {
            return;
        }
        _currentIndex--;
    }
    [_headLineView setCurrentIndex:_currentIndex];
}
-(void)refreshHeadLine:(NSInteger)currentIndex
{
    _currentIndex=currentIndex;
    [_tableView reloadData];
}

//头视图
-(UserHomePagePopView *)headImageView{
    if (!_headImageView) {
        _headImageView=[[UserHomePagePopView alloc]init];
        _headImageView.frame=CGRectMake(0, 0, kWIDTH, 223);
        _headImageView.backgroundColor=[UIColor clearColor];
    
        
       
        UIImage *image=[UIImage imageNamed:@"头像"];
        //图片的宽度设为屏幕的宽度，高度自适应
        NSLog(@"%f",image.size.height);
        _backgroundImgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 289)];
        _backgroundImgV.image=image;
        _backgroundImgV.userInteractionEnabled=YES;
        _backImgHeight=_backgroundImgV.frame.size.height;
        _backImgWidth=_backgroundImgV.frame.size.width;
        _backImgOrgy=_backgroundImgV.frame.origin.y;
         [self.view addSubview:_backgroundImgV];
        
        UIBlurEffect *effct = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self.visualview = [[UIVisualEffectView alloc] initWithEffect:effct];
        _visualview.frame = _headImageView.bounds;
        [_backgroundImgV addSubview:_visualview];

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
//        _nickLabel=[[UILabel alloc]init];
//        _nickLabel.text=@"执念12o3";
//        _nickLabel.textColor=[UIColor whiteColor];
//        _nickLabel.textAlignment=NSTextAlignmentCenter;
//        UIButton *fixBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        fixBtn.frame=CGRectMake(CGRectGetMaxX(_nickLabel.frame)+5, 114, 22, 22);
//        [fixBtn setImage:[UIImage imageNamed:@"pencil-light-shadow"] forState:UIControlStateNormal];
//        [fixBtn addTarget:self action:@selector(fixClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_headImageView addSubview:fixBtn];
//        [self.view addSubview:_nickLabel];
//        [_nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view).with.offset(64);
//            make.centerX.equalTo(self.view);
//            
//        }];
    }
    return _headImageView;
}
//头像点击事件
-(void)tapClick:(UITapGestureRecognizer *)recognizer{
    NSLog(@"你打到我的头了");
}
//修改昵称
-(void)fixClick:(UIButton *)btn{
    NSLog(@"修改昵称");
}
-(void)createNav{
    self.NavView=[[NavHeadTitleView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 64)];
    self.NavView.color=[UIColor whiteColor];
    self.NavView.backTitleImage=@"back";
    self.NavView.rightTitleImage=@"分享";
    self.NavView.delegate=self;
    [self.view addSubview:self.NavView];
}
//左按钮
-(void)NavHeadback{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"点击了左按钮");
}
//右按钮回调
-(void)NavHeadToRight{
    NSLog(@"点击了右按钮");
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles:@"拉黑", nil];
    // actionSheet样式
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    //显示
    [sheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"点击举报");
    }else if(buttonIndex == 1){
        NSLog(@"点击拉黑");

    }
}

#pragma mark ---- UITableViewDelegate ----
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 48;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentIndex == 0) {
        if (indexPath.row == 0 ) {
            return 180;
        }else if (indexPath.row == 1){
            return 221;
        }else if (indexPath.row == 3){
            if(self.rowHeightB == NULL){
                return 221;
            }
            return self.rowHeightB + 180;
            
        }else if (indexPath.row == 4){
            if(self.rowHeightP == NULL){
                return 221;
            }
            return self.rowHeightP + 180;
            
        }else if (indexPath.row == 6){
            if(self.rowHeightFa == NULL){
                return 221;
            }
            return self.rowHeightFa + 180;
            
        }else if (indexPath.row == 7){
            if(self.rowHeightFu == NULL){
                return 221;
            }
            return self.rowHeightFu + 180;
            
        }


    }else if (_currentIndex == 1){
        return 400;
    }else if (_currentIndex == 2) {
        return 1200;
    }
    return 225;
}
- (void)cellHeight:(NSNotification *)notification{
    NSLog(@"接到通知P");
    self.rowHeightP = [notification.userInfo[@"height"] intValue];
}

- (void)cellHeight1:(NSNotification *)notification{
    NSLog(@"接到通知B");
    self.rowHeightB = [notification.userInfo[@"height"] intValue];
}
- (void)cellHeight2:(NSNotification *)notification{
    NSLog(@"接到通知Fa");
    self.rowHeightFa = [notification.userInfo[@"height"] intValue];
}
- (void)cellHeight3:(NSNotification *)notification{
    NSLog(@"接到通知Fu");
    self.rowHeightFu = [notification.userInfo[@"height"] intValue];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_currentIndex==0) {
        return 8;
    }else if(_currentIndex==1){
        return 1;
    }else{
        return 1;
    }
    return 0;
}

////拉伸顶部图片
//-(void)lashenBgView{
//  
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!_headLineView) {
        _headLineView=[[HeadLineView alloc]init];
        _headLineView.frame=CGRectMake(0, 0, kWIDTH, 48);
        _headLineView.delegate=self;
        [_headLineView setTitleArray:@[@"资料",@"择偶标准",@"匹配"]];
    }
    //如果headLineView需要添加图片，请到HeadLineView.m中去设置就可以了，里面有注释
    
    return _headLineView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusID=@"ID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reusID];
    if (!cell) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reusID];
            }
    if (_currentIndex==0) {
        if (indexPath.row == 0) {
            UserHomePhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            return cell;
            
        }else if (indexPath.row == 1){
            UserAnalysisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"analysisCell"];
            
            return cell;
        }else if (indexPath.row == 2){
            PersonalIntroductionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"introductionCell"];
            
            return cell;
        }else if (indexPath.row == 3){
            BasicInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"informationCell"];
            
            return cell;
            
        }else if (indexPath.row == 4){
            PersonalCircumstancesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"circumstancesCell"];
            
            return cell;
        }else if (indexPath.row == 5){
            AuthenticationInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AuthenticationInformationCell"];
           
            return cell;
            
        }else if (indexPath.row == 6){
            familyInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"familyCell"];
          
            return cell;
        }else if (indexPath.row == 7){
            futurePlanningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"futureCell"];
            
            return cell;
        }
        cell.textLabel.text=[_dataArray0 objectAtIndex:indexPath.row];
                cell.detailTextLabel.text=[_dataArray0 objectAtIndex:indexPath.row];
                [cell.imageView setImage:[UIImage imageNamed:@"23.jpg"]];
                return cell;

    }else if(_currentIndex==1){
        UserSpouseStandardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpouseStandardCell"];
        
        return cell;
            }else if(_currentIndex==2){
                MatchingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MatchingTableViewCell"];
                
                return cell;
            }

    
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell被点击恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_currentIndex==0) {
    }else if (_currentIndex==1){
    }else{
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int contentOffsety = scrollView.contentOffset.y;
    if (scrollView.contentOffset.y<=170) {
        self.NavView.headBgView.alpha=scrollView.contentOffset.y/170;
        self.NavView.backTitleImage=@"back";
        self.NavView.rightImageView=@"分享";
         self.NavView.title=@"";
        self.NavView.color=[UIColor whiteColor];
        //状态栏字体白色
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleLightContent;
    }else{
        self.NavView.headBgView.alpha=1;
        self.NavView.title=@"个人中心";
        self.NavView.backTitleImage=@"back";
        self.NavView.rightImageView=@"分享";
        self.NavView.color= JXColor(87, 173, 104, 1);
        //隐藏黑线
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        //状态栏字体黑色
        [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleDefault;
    }
    if (contentOffsety<0) {
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight-contentOffsety;
        rect.size.width = _backImgWidth* (_backImgHeight-contentOffsety)/_backImgHeight;
        rect.origin.x =  -(rect.size.width-_backImgWidth)/2;
        rect.origin.y = 0;
        _backgroundImgV.frame = rect;
        _visualview.frame = rect;
    }else{
        CGRect rect = _backgroundImgV.frame;
        rect.size.height = _backImgHeight;
        rect.size.width = _backImgWidth;
        rect.origin.x = 0;
        rect.origin.y = -contentOffsety;
        _backgroundImgV.frame = rect;
        _visualview.frame = rect;
        
    }
    
}

- (void)createTabBar {

    UIView *likebutton = [[UIView alloc] init];
    likebutton.backgroundColor = [UIColor whiteColor];
    likebutton.frame = CGRectMake(0, kHEIGHT - 49, kWIDTH / 2, 49);
    UILabel *kong1 = [[UILabel alloc] initWithFrame:CGRectMake(0,0, kWIDTH, 2 *FitHeight)];
    kong1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    [likebutton addSubview:kong1];
    UILabel *kong2 = [[UILabel alloc] initWithFrame:CGRectMake(likebutton.right - 1 *FitWidth,0, 1 * FitWidth, likebutton.height)];
    kong2.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    [likebutton addSubview:kong2];
    
    UIImageView *likeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(69 * FitWidth, likebutton.height/2 - 6, 12, 12)];
    [likeImageView setImage:[UIImage imageNamed:@"like1"]];
    [likebutton addSubview:likeImageView];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(likeImageView.right + 5 * FitWidth, likebutton.height/2 -20, 40, 40)];
    title.text = @"关注";
    title.font = [UIFont systemFontOfSize:16];
    [likebutton addSubview:title];
    [self.view addSubview:likebutton];
    
    
    
    UIView *chatbutton = [[UIView alloc] init];
    chatbutton.backgroundColor = [UIColor whiteColor];
    chatbutton.frame = CGRectMake(kWIDTH / 2, kHEIGHT - 49, kWIDTH / 2, 49);
    UILabel *kong3 = [[UILabel alloc] initWithFrame:CGRectMake(0,0, kWIDTH, 2 *FitHeight)];
    kong3.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    [chatbutton addSubview:kong3];

    UIImageView *chatImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60 * FitWidth, chatbutton.height/2 - 6, 12, 12)];
    [chatImageView setImage:[UIImage imageNamed:@"chat"]];
    [chatbutton addSubview:chatImageView];
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(chatImageView.right + 5 * FitWidth, chatbutton.height/2 -20, 60, 40)];
    title2.text = @"打招呼";
    title2.font = [UIFont systemFontOfSize:16];
    [chatbutton addSubview:title2];
    [self.view addSubview:chatbutton];
    
}

- (void)requestData {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:[Helper memberId] forKey:@"memberid"]; //seememberid  被查看人id
    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
    __weak __typeof__(self) weakSelf = self;
    [VVNetWorkTool postWithUrl:Url(MemberFirstPage) body:[Helper parametersWith:parameters]
                      progress:nil success:^(id result) {
                          NSDictionary *dic = result;
                          NSLog(@"%@", dic);
                          
                          
                      } fail:^(NSError *error) {
                          
                      }];
}






@end
