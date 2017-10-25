//
//  FindHimMainViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/9/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//  

#import "FindHimMainViewController.h"
#import "OneStageScreeningController.h"
#import "FindHimMainModel.h"
#import "PictureModel.h"

@interface FindHimMainViewController ()

@property (nonatomic,copy) NSString *signature;
@property (nonatomic,strong) NSMutableArray *peopleArr;
@property (nonatomic,strong) NSMutableArray *picArr;

@property (nonatomic,strong) UILabel *pipeiValueLabel;
@end

@implementation FindHimMainViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    self.tabBarController.tabBar.hidden = NO;

    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:254.9/255.0 alpha:1];
    
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 50);
    [rightButton setTitle:@"筛选" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    [rightButton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
        self.title =@"识TA";
    
    [self addPagerView];
    [self pipeilabel];
    
    [self loadData];
    
    
    // Do any additional setup after loading the view.
}



- (void)addPagerView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]init];
   
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    pagerView.frame = CGRectMake(0, 28 * FitHeight, CGRectGetWidth(self.view.frame), 470 * FitHeight);
    // registerClass or registerNib
    [pagerView registerClass:[FindHimCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.view addSubview:pagerView];
    _pagerView = pagerView;
    
}
-(void)pipeilabel {
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:20];
    label.frame =  CGRectMake(100 * FitWidth, _pagerView.bottom + 10 * FitHeight , 120 * FitWidth, 30 *FitHeight);
    label.text = @"综合匹配值";
    
    UILabel *Numlabel = [[UILabel alloc]init];
    Numlabel.textAlignment = NSTextAlignmentCenter;
    Numlabel.textColor = [UIColor redColor];
    Numlabel.font = [UIFont systemFontOfSize:20];
    Numlabel.frame =  CGRectMake(label.right, label.top, 50 * FitWidth, 30 *FitHeight);
    Numlabel.text = [NSString stringWithFormat:@"%@%%",@"20"];
    self.pipeiValueLabel = Numlabel;
    
    [self.view addSubview:label];
    [self.view addSubview:_pipeiValueLabel];
}
- (void)loadData {
    NSMutableArray *datas = [NSMutableArray array];
    for (int i = 0; i < 5; ++i) {
        if (i == 0) {
            [datas addObject:[UIColor redColor]];
            continue;
        }
        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
    }
    _datas = [datas copy];
    
    [_pagerView reloadData];
}


#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return _peopleArr.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    FindHimMainModel *findModel = self.peopleArr[index];
    
    FindHimCollectionViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    _pipeiValueLabel.text = [NSString stringWithFormat:@"%@%%",findModel.matchvalue];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.layer.cornerRadius = 10;
    [cell.layer setMasksToBounds:YES];
    cell.signature.text = findModel.summary;
    cell.jumpDelegate = self;
    cell.address.text = [NSString stringWithFormat:@"%@(%.2fkm)",findModel.address, findModel.distance.floatValue];
    cell.userName.text = findModel.nickname;
    CGSize userNameSize = [cell.userName.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:cell.userName.font,NSFontAttributeName,nil]];
    cell.userName.width = userNameSize.width ;
    cell.userName.height = userNameSize.height;
    cell.sixImageView.frame = CGRectMake(cell.userName.right + 3, cell.userName.top, 20, 20);
    if (findModel.sex.intValue == 1) {
        [cell.sixImageView setImage:[UIImage imageNamed:@"six_boy"]];
    }else {
         [cell.sixImageView setImage:[UIImage imageNamed:@"six_girl"]];
    }
    cell.info.text = [NSString stringWithFormat:@"%@岁 | %@cm | %@ | %@", findModel.age, findModel.stature, findModel.constellation, findModel.work];
    PictureModel *p1 = _picArr[index][0];
    PictureModel *p2 = _picArr[index][1];
    PictureModel *p3 = _picArr[index][2];
    PictureModel *p4 = _picArr[index][3];
    UIImageView *image = [[UIImageView alloc] init];
    [image sd_setImageWithURL:Url(p1.pic)];
    UIImageView *image1 = [[UIImageView alloc] init];
    [image1 sd_setImageWithURL:Url(p2.pic)];
    UIImageView *image2 = [[UIImageView alloc] init];
    [image2 sd_setImageWithURL:Url(p3.pic)];
    UIImageView *image3 = [[UIImageView alloc] init];
    [image3 sd_setImageWithURL:Url(p4.pic)];
    
    [cell.mainButton setBackgroundImage:image.image forState:UIControlStateNormal];
    [cell.leftButton setBackgroundImage:image1.image forState:UIControlStateNormal];
    [cell.middleButton setBackgroundImage:image2.image forState:UIControlStateNormal];
    [cell.righButton setBackgroundImage:image3.image forState:UIControlStateNormal];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(268 * FitWidth, 465 * FitHeight);
    layout.itemSpacing = 15;
    //layout.minimumAlpha = 0.3;
    layout.itemHorizontalCenter = YES;
    layout.layoutType = 2;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
        //[_pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

#pragma mark - 跳转到用户详情界面

- (void)jumpTOUserDetail:(NSInteger)index {
    FindHimMainModel *findModel = self.peopleArr[index];
    UserHomePageViewController *userPage = [[UserHomePageViewController alloc] init];
    userPage.seememberid = findModel.nId;
    [self.navigationController pushViewController:userPage animated:YES];

}

#pragma mark - 点开小图展示大图


- (void)jumpToBigImg:(NSString *)image {
    
}

#pragma mark - 跳转到筛选界面


- (void) rightButton:(UIButton *)button {
    [self.navigationController pushViewController:[OneStageScreeningController new] animated:true];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (void)getMyArtistIntroductionData {
//    NSMutableDictionary *parameters = [NSMutableDictionary new];
//    [parameters setValue:[Helper memberId] forKey:@"memberid"];
//    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
//    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
//    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
//    [VVNetWorkTool postWithUrl:Url(MyArtistIntroduction) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
//        NSDictionary *dic = result;
//        NSString *summary = [[dic objectForKey:@"data"] valueForKey:@"summary"];
//        if (summary != nil) {
//            self.signature = summary;
//        }
//        
//    } fail:^(NSError *error) {
//        
//    }];
//}

- (void)requestData {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
    [VVNetWorkTool postWithUrl:Url(KnowTAFirstPage) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        
        self.peopleArr = [NSMutableArray new];
        self.picArr = [NSMutableArray new];
        NSMutableArray *arr = [result objectForKey:@"data"];
        NSMutableArray *picArr = [NSMutableArray new];
        NSMutableArray *pic = [NSMutableArray new];
       
        for (NSDictionary *dic in arr) {
            FindHimMainModel *findHimMainModel = [[FindHimMainModel alloc] initWithDictionary:dic];
            [pic addObject:findHimMainModel.pictureArr];
            [self.peopleArr addObject:findHimMainModel];
        }
        for (int i = 0; i < pic.count; i++) {
            for (PictureModel *pp in pic[i]) {
                [picArr addObject:pp];
            }
            [self.picArr addObject:picArr];
        }
        [self.pagerView reloadData];
    } fail:^(NSError *error) {
        
    }];
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
