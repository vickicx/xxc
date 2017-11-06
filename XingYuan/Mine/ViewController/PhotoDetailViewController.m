//
//  PhotoDetailViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/11/3.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "PhotoDetailCollectionViewCell.h"

@interface PhotoDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (assign, nonatomic) NSInteger integer;

@end

@implementation PhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置主题颜色
    UINavigationBar *navBar = self.navigationController.navigationBar;
    // 设置背景颜色
    navBar.barTintColor = [UIColor colorWithRed:(15/255.0) green:(15/255.0) blue:(19/255.0) alpha:1.0];
    // 设置背景图片(为了避免appearance背景图影响)
    [navBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    // 设置主题颜色
    navBar.tintColor = [UIColor whiteColor];
    // 设置字体颜色
    NSDictionary *attr = @{ NSForegroundColorAttributeName : [UIColor whiteColor],
                            NSFontAttributeName : [UIFont boldSystemFontOfSize:20]
                            };
    [navBar setTitleTextAttributes:attr];
    navBar.translucent = NO;
    
    
    [self createView];
}



- (void)createView {
    // 注册cell
    self.collectionView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self.collectionView registerClass:[PhotoDetailCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    // 支持分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.size = CGSizeMake(self.view.width, self.view.height);
    // 设置collectionView的width
    // 获取行间距
    CGFloat lineSpacing = ((UICollectionViewFlowLayout *)self.collectionViewLayout).minimumLineSpacing;
    self.collectionView.width += lineSpacing;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, lineSpacing);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    // 取消水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;

    self.title = [NSString stringWithFormat:@"%ld/%lu",(long)self.tag + 1,(unsigned long)self.dataSource.count];
    self.integer = self.tag;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(NSEC_PER_SEC)*2), dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.tag inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];

    });
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.images = self.dataSource[indexPath.row];
    return cell;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int a  = (int)(scrollView.contentOffset.x / (kWIDTH) +1);
    self.integer = a - 1;
    self.title = [NSString stringWithFormat:@"%d/%lu",a,(unsigned long)self.dataSource.count];
    
}


#pragma mark <UICollectionViewDelegateFlowLayout>
// 设置每个item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kWIDTH, kHEIGHT);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
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
