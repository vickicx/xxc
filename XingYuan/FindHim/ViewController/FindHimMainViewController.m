//
//  FindHimMainViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/9/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//  

#import "FindHimMainViewController.h"

@interface FindHimMainViewController ()
@property (nonatomic,copy) NSString *PipeiNum;
@end

@implementation FindHimMainViewController

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
    self.PipeiNum = @"20";
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
    Numlabel.text = [NSString stringWithFormat:@"%@%%",self.PipeiNum];
    
    [self.view addSubview:label];
    [self.view addSubview:Numlabel];
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
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    FindHimCollectionViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    cell.backgroundColor = _datas[index];
    cell.layer.cornerRadius = 10;
    [cell.layer setMasksToBounds:YES];
    cell.label.text = [NSString stringWithFormat:@"index->%ld",index];
    cell.jumpDelegate = self;
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
    UserHomePageViewController *userPage = [[UserHomePageViewController alloc] init];
    [self.navigationController pushViewController:userPage animated:YES];

}

#pragma mark - 点开小图展示大图


- (void)jumpToBigImg:(NSString *)image {
    
}

#pragma mark - 跳转到筛选界面


- (void) rightButton:(UIButton *)button {
    
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
