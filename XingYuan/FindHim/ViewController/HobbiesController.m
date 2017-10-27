//
//  HobbiesController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "HobbiesController.h"
#import "MyHobbyCollectionCell.h"
#import "HobbiesModel.h"
#import "NSString+tool.h"
#import "HobbyListHeaderView.h"

@interface HobbiesController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) HobbiesModel *hobbiesModel;
@property (nonatomic,weak) UIButton *finishBtn;
@end

@implementation HobbiesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兴趣爱好";
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishBtn = finishBtn;
    [finishBtn setTitleColor:RGBColor(246, 80, 116, 1) forState:UIControlStateNormal];
    [finishBtn setTitle:@"保存" forState:UIControlStateNormal];
    [finishBtn sizeToFit];
    [finishBtn addTarget:self action:@selector(dealToSave) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:finishBtn]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumInteritemSpacing:10];
    [layout setMinimumLineSpacing:10];
    layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50*FitHeight);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.alwaysBounceVertical = true;
    self.collectionView.scrollEnabled = true;
    [self.collectionView registerClass:[HobbyListHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HobbyListHeaderView"]; //注册头部视图
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyHobbyCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"MyHobbyCollectionCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 36*FitHeight, 0, 15*FitHeight);
    
    self.hobbiesModel = [HobbiesModel new];
    //请求数据
    [self requestHobbies];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - misc
- (void)dealToSave{
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:[self getSelectedInterestWithModel:self.hobbiesModel] forKey:@"sids"];
    
    [JGProgressHUD showStatusWith:nil In:self.view];
    [VVNetWorkTool postWithUrl:Url(Setinterest) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [JGProgressHUD showResultWithModel:model In:self.view];
        if([model.code isEqual:@1]){
            if(self.hobbiesBlock != nil){
                self.hobbiesBlock([self getSelectedInterestWithModel:self.hobbiesModel]);
            }
            [self.navigationController popViewControllerAnimated:true];
        }
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (NSString *)getSelectedInterestWithModel:(HobbiesModel *)model{
    NSMutableString *selectedInterest = [NSMutableString stringWithString:@""];
    for(int i=0;i<model.data.count;i++){
        SuperHobbyModel *superHobbyModel = model.data[i];
        for(int j=0;j<superHobbyModel.child.count;j++){
            ChildHobbyModel *childHobbyModel = superHobbyModel.child[j];
            if(childHobbyModel.isselect){
                [selectedInterest appendFormat:@"%@,",childHobbyModel.Id];
            }
        }
        //删掉最后的 ，
        if([selectedInterest length]>=2){
            selectedInterest = [NSMutableString stringWithString:[selectedInterest substringToIndex:[selectedInterest length]-1]];
        }
        if([selectedInterest length]>=1){
            //添加分隔符 |
            [selectedInterest appendFormat:@"|"];
        }
    }
    //删掉最后的分隔符 |
    if([selectedInterest length]>=2){
        selectedInterest = [NSMutableString stringWithString:[selectedInterest substringToIndex:[selectedInterest length]-1]];
    }
    return selectedInterest;
}

/**
 判断SuperHobbyModel下的选中的ChildHobbyModel数量是否大于3

 @param model SuperHobbyModel
 */
- (BOOL)isSelecInterestLessThanThreeWithModel:(SuperHobbyModel *)model{
    NSArray *childhobbyModels = model.child;
    int selectNum = 0;
    for(int i=0;i<childhobbyModels.count;i++){
        ChildHobbyModel *childHobbyModel = model.child[i];
        if(childHobbyModel.isselect){
            selectNum += 1;
        }
    }
    return selectNum<3 ? true:false;
}

//请求已经服务器已经填写的数据
- (void)requestHobbies{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    [VVNetWorkTool postWithUrl:Url(Memberinterest) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        HobbiesModel *hobbiesModel = [HobbiesModel new];
        [hobbiesModel setValuesForKeysWithDictionary:result];
        self.hobbiesModel = hobbiesModel;
        [self.collectionView reloadData];
        [JGProgressHUD showErrorWithModel:hobbiesModel In:self.view];
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.hobbiesModel.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    SuperHobbyModel *superHobbyModel = self.hobbiesModel.data[section];
    return superHobbyModel.child.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        HobbyListHeaderView *hobbyListHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HobbyListHeaderView" forIndexPath:indexPath];
        SuperHobbyModel *superHobbyModel = self.hobbiesModel.data[indexPath.section];
        hobbyListHeaderView.title = superHobbyModel.name;
        return hobbyListHeaderView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyHobbyCollectionCell *myHobbyCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyHobbyCollectionCell" forIndexPath:indexPath];
    SuperHobbyModel *superHobbyModel = self.hobbiesModel.data[indexPath.section];
    ChildHobbyModel *childHobbyModel = superHobbyModel.child[indexPath.row];
    [myHobbyCollectionCell configWithModel:childHobbyModel];
    return myHobbyCollectionCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    SuperHobbyModel *superHobbyModel = self.hobbiesModel.data[indexPath.section];
    ChildHobbyModel *childHobbyModel = superHobbyModel.child[indexPath.row];
    NSString *title = childHobbyModel.name;
    CGRect rect = [title getRectWithFont:[UIFont systemFontOfSize:17] width:1000];
    return CGSizeMake(rect.size.width+20*FitWidth, rect.size.height+10*FitHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SuperHobbyModel *superHobbyModel = self.hobbiesModel.data[indexPath.section];
    ChildHobbyModel *childHobbyModel = superHobbyModel.child[indexPath.row];
    
    //先判断当前superHobbyModel中选中数目是否大于3
    if([self isSelecInterestLessThanThreeWithModel:superHobbyModel]){
        childHobbyModel.isselect = !childHobbyModel.isselect;
    }else{
        if(childHobbyModel.isselect){
            childHobbyModel.isselect = !childHobbyModel.isselect;
        }else{
            [Helper showAlertControllerWithMessage:@"每个兴趣类里面最多可选择3项" completion:nil];
        }
    }
    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

@end
