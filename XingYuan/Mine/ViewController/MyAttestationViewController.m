//
//  MyAttestationViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/14.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MyAttestationViewController.h"
#import "AttestationCollectionViewCell.h"
#import "CertificationViewController.h"
#import "SesameCertificationFirstViewController.h"
#import "CarCertificationViewController.h"
#import "HouseCertificationViewController.h"
#import "AttestationNextCollectionViewCell.h"
#import "FourStageScreeningController.h"
#import "ThreeStageScreeningModel.h"
#import "FinishCertificationViewController.h"
#import "FinishSesameViewController.h"

@interface MyAttestationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *attestationCollectionView;
@property (nonatomic,strong) NSMutableArray *imageName;
@property (nonatomic,strong) NSArray *imageName1;
@property (nonatomic,strong) NSArray *titleName;
@property (nonatomic,strong) ThreeStageScreeningModel *threeStageScreeningModel;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,assign) AttestationControllerType type;
@property (nonatomic,assign) int temp;
@end

@implementation MyAttestationViewController

- (instancetype)init{
    self = [super init];
    if(self){
        self.type = AttestationControllerTypeNone;
    }
    return self;
}

- (instancetype)initWithType:(AttestationControllerType)type{
    self = [self init];
    if(self){
        self.type = type;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageName = [NSMutableArray arrayWithArray:@[@"实名认证", @"手机认证", @"芝麻认证", @"购车认证", @"购房认证"]];
    self.imageName1 = @[@"实名认证1", @"手机认证1", @"芝麻认证1", @"购车认证1", @"购房认证1"];
    self.titleName = @[@"实名认证", @"手机认证", @"芝麻认证", @"购车认证", @"购房认证"];
    // Do any additional setup after loading the view from its nib.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createView];
    [self requestData];
    self.title = @"我的认证";

}

- (void)createView {
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40*FitHeight)];
    backgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:backgroundView];

    UILabel *adviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, self.view.width - 24*FitWidth, 40*FitHeight)];
    adviceLabel.text = @"当你完善此项资料，方可解锁其他用户的此项资料";
    adviceLabel.font = FONT_WITH_S(14);
    adviceLabel.textColor = RGBColor(184, 186, 189, 1);
    adviceLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:adviceLabel];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 1.设置列间距
    layout.minimumInteritemSpacing = 15;
    // 2.设置行间距
//    layout.minimumLineSpacing = 15;
    // 3.设置每个item的大小
    layout.itemSize = CGSizeMake(50*FitWidth, 50*FitHeight);
    // 5.设置布局方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 9.10.设置分区的头视图和尾视图是否始终固定在屏幕上边和下边
    layout.sectionFootersPinToVisibleBounds = YES;
    layout.sectionHeadersPinToVisibleBounds = YES;
    layout.headerReferenceSize = CGSizeMake(50, 50);
    self.attestationCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, adviceLabel.bottom, kWIDTH, kHEIGHT - adviceLabel.height) collectionViewLayout:layout];
    self.attestationCollectionView.delegate = self;
    self.attestationCollectionView.dataSource = self;
   
    [ self.attestationCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    [self.attestationCollectionView registerNib:[UINib nibWithNibName:@"AttestationCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AttestationCollectionViewCellID"];
    [self.attestationCollectionView registerNib:[UINib nibWithNibName:@"AttestationNextCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AttestationNextCollectionViewCell"];
    self.attestationCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.attestationCollectionView];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if(self.type == AttestationControllerTypeScreening){
        return 2;
    }
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section == 1){
        return 1;
    }
    if(section == 0 && self.threeStageScreeningModel == nil){
        return 0;
    }
    return 5;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        AttestationNextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AttestationNextCollectionViewCell" forIndexPath:indexPath];
        cell.nextBlock = ^(){
            FourStageScreeningController *fourStageScreeningController = [[FourStageScreeningController alloc] init];
            [self.navigationController pushViewController:fourStageScreeningController animated:true];
        };
        return cell;
    }
    AttestationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AttestationCollectionViewCellID" forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:1];   //在创建Xib的时候给了控件相应的tag值
    UILabel *label = (UILabel *)[cell viewWithTag:2];
    
    [imageView setImage:[UIImage imageNamed:self.imageName[indexPath.row]]];
    [label setText:self.titleName[indexPath.row]];

    if (indexPath.row == 3 && self.threeStageScreeningModel.buycarcertifyaudit != nil) {
    
        cell.num = self.threeStageScreeningModel.buycarcertifyaudit;
    }
    if(indexPath.row == 4){
        cell.num = self.threeStageScreeningModel.buyhousecertifyaudit;
    }
    return cell;
}

//UICollectionViewCell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        return CGSizeMake(SCREEN_WIDTH, 48*FitHeight);
    }
    return CGSizeMake(self.attestationCollectionView.width / 3 - 33*FitWidth, 110*FitHeight);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        if(self.threeStageScreeningModel.realnameauthentication){
            FinishCertificationViewController *finishCertificationVC = [[FinishCertificationViewController alloc] init];
            finishCertificationVC.title = @"实名认证";
            [self.navigationController pushViewController:finishCertificationVC animated:YES];
        }else{
            CertificationViewController *CertificationVC = [[CertificationViewController alloc] init];
            [self.navigationController pushViewController:CertificationVC animated:YES];
        }
    }else if (indexPath.row == 2) {
        if (self.threeStageScreeningModel.zmxyauthentication) {
            FinishSesameViewController *finishSesameVC = [[FinishSesameViewController alloc] init];
             [self.navigationController pushViewController:finishSesameVC animated:YES];
        } else {
            SesameCertificationFirstViewController *sesameVC = [[SesameCertificationFirstViewController alloc] init];
            [self.navigationController pushViewController:sesameVC animated:YES];
        }
    }else if (indexPath.row == 3) {
        //如果已经进行认证（进入审核完成界面或无操作）
        if(self.threeStageScreeningModel.buycarauthentication){
                FinishCertificationViewController *finishCertificationVC = [[FinishCertificationViewController alloc] init];
                finishCertificationVC.title = @"购车认证";
                [self.navigationController pushViewController:finishCertificationVC animated:YES];
        }
        //如果没进行认证（进入认证界面）
        if(!self.threeStageScreeningModel.buycarauthentication){
            //审核中则无操作
            if(self.threeStageScreeningModel.buycarcertifyaudit == 1){
                
            }
            if(self.threeStageScreeningModel.buycarcertifyaudit != 1){
                CarCertificationViewController *carVC = [[CarCertificationViewController alloc] init];
                [self.navigationController pushViewController:carVC animated:YES];
            }
        }
        
    }else if (indexPath.row == 4) {
        //如果已经进行认证（进入审核完成界面或无操作）
        if(self.threeStageScreeningModel.buyhouseauthentication){
            FinishCertificationViewController *finishCertificationVC = [[FinishCertificationViewController alloc] init];
            finishCertificationVC.title = @"购房认证";
            [self.navigationController pushViewController:finishCertificationVC animated:YES];
        }
        //如果没进行认证（进入认证界面）
        if(!self.threeStageScreeningModel.buyhouseauthentication){
            //审核中则无操作
            if(self.threeStageScreeningModel.buyhousecertifyaudit == 1){
                
            }
            if(self.threeStageScreeningModel.buyhousecertifyaudit != 1){
                HouseCertificationViewController *houseVC = [[HouseCertificationViewController alloc] init];
                [self.navigationController pushViewController:houseVC animated:YES];
            }
        }
    }
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if(section == 1){
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(15, 20*FitHeight, 0, 33*FitHeight);
}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
        headerView.frame = CGRectMake(0, 0, 0, 0);
        return headerView;
    }
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.backgroundColor =[UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12*FitWidth, 15*FitHeight, 70*FitWidth, 15*FitHeight)];
    label.text = @"认证资料";
    label.font = FONT_WITH_S(17);
    
    _label1 = [[UILabel alloc] initWithFrame:CGRectMake(label.right, label.top, label.width, label.height)];
    _label1.font = FONT_WITH_S(14);
    _label1.textColor = RGBColor(141, 146, 149, 1);
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(12*FitWidth, headerView.bottom - 2*FitHeight, self.view.width - 24*FitWidth, 1*FitHeight)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [headerView addSubview:label];
    [headerView addSubview:_label1];
    [headerView addSubview:line];
    return headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData {
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setValue:[Helper memberId] forKey:@"memberid"];

    
    [VVNetWorkTool postWithUrl:Url(ShowmatchingThree) body:[Helper parametersWith:parameters]
                      progress:nil success:^(id result) {
                          NSDictionary *dic = [result objectForKey:@"data"];
                          self.threeStageScreeningModel = [[ThreeStageScreeningModel alloc] initWithDictionary:dic];
                      } fail:^(NSError *error) {
                          [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
                      }];
    
}

-(void)setThreeStageScreeningModel:(ThreeStageScreeningModel *)threeStageScreeningModel {
    if (_threeStageScreeningModel != threeStageScreeningModel) {
        _threeStageScreeningModel = threeStageScreeningModel;
    }
    self.temp = 0;
    if (!threeStageScreeningModel.phoneauthentication) {
        self.imageName[1] = self.imageName1[1];
    }else {
        self.temp++;
    }
    if (!threeStageScreeningModel.realnameauthentication) {
        self.imageName[0] = self.imageName1[0];
    }else {
        self.temp++;
    }
    if (!threeStageScreeningModel.zmxyauthentication) {
        self.imageName[2] = self.imageName1[2];
    }else {
        self.temp++;
    }
    if (!threeStageScreeningModel.buycarauthentication) {
        self.imageName[3] = self.imageName1[3];
    }else {
        self.temp++;
    }
    if (!threeStageScreeningModel.buyhouseauthentication) {
        self.imageName[4] = self.imageName1[4];
    }else {
        self.temp++;
    }
    _label1.text = [NSString stringWithFormat:@"(%d/5)", self.temp];
    
     [_attestationCollectionView reloadData];    
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
