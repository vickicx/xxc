//
//  FindHimMainViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/9/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//  

#import "FindHimMainViewController.h"
#import "OneStageScreeningController.h"
#import "TwoStageScreeningController.h"
#import "MyAttestationViewController.h"
#import "FourStageScreeningController.h"
#import "FiveStageScreeningController.h"
#import "FindHimMainModel.h"
#import "PictureModel.h"
#import "TZLocationManager.h"

@interface FindHimMainViewController ()

@property (nonatomic,copy) NSString *signature;
@property (nonatomic,strong) NSMutableArray *peopleArr;
@property (nonatomic,strong) NSMutableArray *picArr;
@property (nonatomic,strong) NSNumber *currentmatchinglevel;//当前用户匹配等级
@property (nonatomic,strong) UILabel *pipeiValueLabel;
@property (nonatomic,strong) MyAttestationViewController *attestationViewController;
@property (nonatomic,assign) int pageindex;
@end

@implementation FindHimMainViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.pageindex = 0;
    [TZLocationManager manager];
    [TZLocationManager.manager startLocation];
    [TZLocationManager.manager startLocationWithSuccessBlock:^(CLLocation *location, CLLocation *oldLocation) {
        NSLog(@"经度%f,纬度%f",location.coordinate.longitude,location.coordinate.latitude);
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        [parameters setValue:[Helper memberId] forKey:@"memberid"];
        [parameters setValue:[NSString stringWithFormat:@"%f", location.coordinate.latitude] forKey:@"lat"];
        [parameters setValue:[NSString stringWithFormat:@"%f", location.coordinate.longitude] forKey:@"lnt"];
        [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
        [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
        [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
        __weak __typeof__(self) weakSelf = self;
        [VVNetWorkTool postWithUrl:Url(Uploadmemberlocation) body:[Helper parametersWith:parameters]
                          progress:nil success:^(id result) {
                              NSString *str = [result objectForKey:@"code"];
                              if (str.intValue == 1) {
                                  NSLog(@"位置上传成功");
                              }
                              
                          } fail:^(NSError *error) {
                          }];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:254.9/255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _attestationViewController = [[MyAttestationViewController alloc] initWithType:AttestationControllerTypeScreening];
    _peopleArr = [NSMutableArray new];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50*FitWidth, 50*FitHeight);
    [rightButton setTitle:@"筛选" forState:UIControlStateNormal];
    [rightButton setTitleColor:RGBColor(246, 80, 118, 1) forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
        self.title =@"识TA";
    [self addPagerView];
    [self pipeilabel];
    
//    [self loadData];
  
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
    label.font = FONT_WITH_S(20);
    label.frame =  CGRectMake(100 * FitWidth, _pagerView.bottom + 10 * FitHeight , 120 * FitWidth, 30 *FitHeight);
    label.text = @"综合匹配值";
    
    UILabel *Numlabel = [[UILabel alloc]init];
    Numlabel.textAlignment = NSTextAlignmentCenter;
    Numlabel.textColor = [UIColor redColor];
    Numlabel.font = FONT_WITH_S(20);
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
    cell.sixImageView.frame = CGRectMake(cell.userName.right + 3*FitWidth, cell.userName.top, 20*FitWidth, 20*FitHeight);
    if (findModel.sex.intValue == 1) {
        [cell.sixImageView setImage:[UIImage imageNamed:@"six_boy"]];
    }else {
         [cell.sixImageView setImage:[UIImage imageNamed:@"six_girl"]];
    }
    cell.info.text = [NSString stringWithFormat:@"%@岁 | %@cm | %@ | %@", findModel.age, findModel.stature, findModel.constellation, findModel.work];
    UIImageView *image = [[UIImageView alloc] init];
    UIImageView *image1 = [[UIImageView alloc] init];
    UIImageView *image2 = [[UIImageView alloc] init];
    UIImageView *image3 = [[UIImageView alloc] init];
    if (_picArr.count != 0) {
        NSArray *picc = _picArr[index];
        if (picc.count != 0) {
            PictureModel *p1 = picc[0];
            PictureModel *p2 = picc[1];
            PictureModel *p3 = picc[2];
            PictureModel *p4 = picc[3];
            [image sd_setImageWithURL:(NSURL*)Url(p1.pic)];
            [image1 sd_setImageWithURL:(NSURL*)Url(p2.pic)];
            [image2 sd_setImageWithURL:(NSURL*)Url(p3.pic)];
            [image3 sd_setImageWithURL:(NSURL*)Url(p4.pic)];
        }else{
            [image setImage:[UIImage imageNamed:@"照片"]];
            [image1 setImage:[UIImage imageNamed:@"照片"]];
            [image2 setImage:[UIImage imageNamed:@"照片"]];
            [image3 setImage:[UIImage imageNamed:@"照片"]];
        }
     
    [cell.mainButton setBackgroundImage:image.image forState:UIControlStateNormal];
    [cell.leftButton setBackgroundImage:image1.image forState:UIControlStateNormal];
    [cell.middleButton setBackgroundImage:image2.image forState:UIControlStateNormal];
    [cell.righButton setBackgroundImage:image3.image forState:UIControlStateNormal];
    }
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
//    if (self.peopleArr != NULL) {
//        int i = (self.peopleArr.count / (self.pageindex + 1)) - 2;
//        if (fromIndex == i ) {
//            self.pageindex++;
//            [self requestData];
//        }
//    }
    
    
    
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
    switch (self.currentmatchinglevel.intValue) {
        case 0:
            [self.navigationController pushViewController:[OneStageScreeningController new] animated:true];
            break;
        case 1:
            [self.navigationController pushViewController:[TwoStageScreeningController new] animated:true];
            break;
        case 2:
            [self.navigationController pushViewController:self.attestationViewController animated:true];
            break;
        case 3:
            [self.navigationController pushViewController:[FourStageScreeningController new] animated:true];
            break;
        case 4:
            [self.navigationController pushViewController:[FiveStageScreeningController new] animated:true];
            break;
        default:
            [self.navigationController pushViewController:[OneStageScreeningController new] animated:true];
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)requestData {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:[NSString stringWithFormat:@"%d", self.pageindex] forKey:@"pageindex"];
    [parameters setValue:@"5" forKey:@"pagesize"];
    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
    [VVNetWorkTool postWithUrl:Url(KnowTAFirstPage) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        self.picArr = [NSMutableArray new];
        self.currentmatchinglevel = [[result objectForKey:@"data"] objectForKey:@"currentmatchinglevel"];
        NSMutableArray *arr = [[result objectForKey:@"data"] objectForKey:@"matchingmember"];
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
