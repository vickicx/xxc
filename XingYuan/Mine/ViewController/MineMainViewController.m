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
#import "MyAttestationViewController.h"
#import "MyDataController.h"
#import "GeneralSettingsViewController.h"
#import "LikeMeViewController.h"
#import "GrowthCenterController.h"
#import "AboutMeModel.h"
#import "MyFollowersController.h"
#import "IFollowsController.h"
#import "MyIMFriendsController.h"
#import "SystemMessageListController.h"
#import <AssetsLibrary/AssetsLibrary.h>


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
@property (nonatomic,strong) AboutMeModel *aboutMeModel;
@property (nonatomic,strong) MyFloatView *floatView;
@property (nonatomic,strong) UILabel *ageLabel;
@property (nonatomic,strong) UILabel *statureLabel;
@property (nonatomic,strong) UILabel *constellationLabel;
@property (nonatomic,strong) UILabel *educationLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *onlineLabel;
@property (nonatomic,strong) UIImageView *sexImageView;
@property (nonatomic,copy) NSString *img;


@end

@implementation MineMainViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.subviews[0].subviews[1].alpha = 0;
    self.navigationController.navigationBar.subviews[0].subviews[0].alpha = 0;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.subviews[0].subviews[1].alpha = 1;
    self.navigationController.navigationBar.subviews[0].subviews[0].alpha = 1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArr = [NSArray arrayWithObjects:@"喜欢我的", @"我喜欢的", @"关注", @"成长", nil];
    self.titleArr = [NSArray arrayWithObjects:@"关注我的", @"我关注的", @"我的好友", @"成长中心", nil];
    self.view.backgroundColor = [UIColor redColor];
    [self createTableView];
    [self createRightButton];
    [self creatLeftButton];
    self.floatView = [[MyFloatView alloc] initWithFrame:CGRectMake(12*FitWidth, 290*FitHeight, kWIDTH - 24 *FitWidth, 80*FitHeight)];
    [self.view addSubview:self.floatView];
    self.onlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(kWIDTH - 60*FitWidth, self.floatView.top - 30*FitHeight, 50*FitWidth, 20*FitHeight)];
    self.onlineLabel.textColor = [UIColor whiteColor];
    self.onlineLabel.font = FONT_WITH_S(12);
    self.onlineLabel.text = @"当前在线";
    [self.view addSubview:self.onlineLabel];
    
    self.sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.onlineLabel.left - 25*FitWidth, self.onlineLabel.top, 20*FitWidth, 20*FitHeight)];
    [self.sexImageView setImage:[UIImage imageNamed:@"six_girl"]];
    [self.view addSubview:self.sexImageView];
    
     __weak __typeof__(self) weakSelf = self;
    self.floatView.goMyTreasureView = ^{
        NSLog(@"跳转到我的财富界面");
    };
    self.floatView.goMyCertificationView = ^{
        MyAttestationViewController *attestationVC = [[MyAttestationViewController alloc] init];
        [weakSelf.navigationController pushViewController:attestationVC animated:YES];
        NSLog(@"跳转到我的认证界面");
    };
    self.floatView.goMyInformationView = ^{
        NSLog(@"跳转到我的资料界面");
        MyDataController *myDataController = [[MyDataController alloc] init];
        [weakSelf.navigationController pushViewController:myDataController animated:YES];
    };
    
    [self requestData];
}



//头视图
-(UserHomePagePopView *)headImageView{
    if (!_headImageView) {
        _headImageView=[[UserHomePagePopView alloc]init];
        _headImageView.frame=CGRectMake(0, 0, kWIDTH, 310*FitHeight);
        _headImageView.backgroundColor=[UIColor clearColor];
        
        UIImage *image=[UIImage imageNamed:@"头像"];
        //图片的宽度设为屏幕的宽度，高度自适应
        _backgroundImgV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 310*FitHeight)];
        _backgroundImgV.image=image;
        _backgroundImgV.userInteractionEnabled=YES;
        _backImgHeight=_backgroundImgV.frame.size.height;
        _backImgWidth=_backgroundImgV.frame.size.width;
        _backImgOrgy=_backgroundImgV.frame.origin.y;
        //毛玻璃背景
        
        UIBlurEffect *effct = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualview = [[UIVisualEffectView alloc] initWithEffect:effct];
        visualview.frame = _backgroundImgV.bounds;
        [_backgroundImgV addSubview:visualview];
        [self.view addSubview:_backgroundImgV];
        
        UIView *view = [[UIView alloc] init];
        view.frame = _backgroundImgV.bounds;
        view.backgroundColor = RGBColor(0, 0, 0, 0.3);
        [_backgroundImgV addSubview:view];
        
        //_headImageView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"个人页背景图.png"]];
        _headerImg=[[UIImageView alloc]init];
       
        [_headerImg.layer setMasksToBounds:YES];
        [_headerImg.layer setCornerRadius:35];
        _headerImg.backgroundColor=[UIColor whiteColor];
        _headerImg.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toChooseHeadImg)];
        [_headerImg addGestureRecognizer:tap];
        [self.view addSubview:_headerImg];
        [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_backgroundImgV);
            make.size.mas_equalTo(CGSizeMake(70, 70));
        }];
        
        self.ageLabel = [[UILabel alloc] init];
        self.ageLabel.text = @"24岁";
        [self createBackgroundImg:CGRectMake(40*FitWidth, 40*FitHeight, 60*FitWidth, 60*FitHeight) label:self.ageLabel];
        
        self.statureLabel = [[UILabel alloc] init];
        self.statureLabel.text = @"身高";
        [self createBackgroundImg:CGRectMake(self.ageLabel.right + 40*FitWidth, self.ageLabel.top + 10*FitHeight, 60*FitWidth, 60*FitHeight) label:self.statureLabel];
        
        self.constellationLabel = [[UILabel alloc] init];
        self.constellationLabel.text = @"星座";
        [self createBackgroundImg:CGRectMake(30*FitWidth, 90*FitHeight, 80*FitWidth, 80*FitHeight) label:self.constellationLabel];
        
        self.educationLabel = [[UILabel alloc] init];
        self.educationLabel.text = @"工作";
        [self createBackgroundImg:CGRectMake(self.statureLabel.left, self.statureLabel.bottom - 20*FitHeight, 70*FitHeight, 70*FitHeight) label:self.educationLabel];
        
        self.addressLabel = [[UILabel alloc] init];
        self.addressLabel.text = @"地址";
        self.addressLabel.numberOfLines = 0;
        [self createBackgroundImg:CGRectMake(75*FitWidth, 100*FitHeight, 90*FitWidth, 90*FitHeight) label:self.addressLabel];
//        //昵称
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

- (void)toChooseHeadImg{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            //资源类型为相机
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            //设置选择后的图片可被编辑
            picker.allowsEditing = YES;
            [self presentModalViewController:picker animated:YES];
        }else{
            [Helper showAlertControllerWithMessage:@"该设备不支持相机" completion:nil];
        }
    }];
    UIAlertAction *toAlbum = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //先检测是否得到相册授权
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        if (status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusDenied)
        {
            // 无权限
            // do something...
            [Helper showAlertControllerWithMessage:@"未获得相册授权，请先设置" completion:nil];
        }else{
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            //资源类型为图片库
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            //设置选择后的图片可被编辑
            picker.allowsEditing = YES;
            [self presentModalViewController:picker animated:YES];
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:takePhoto];
    [alertController addAction:toAlbum];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:true completion:nil];
}

#pragma mark --UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    if (image != nil){
        //开始上传图片
        NSMutableDictionary *parameters = [NSMutableDictionary new];
        [parameters setValue:[Helper memberId] forKey:@"memberid"];
        [JGProgressHUD showStatusWith:nil In:self.view];
        [VVNetWorkTool formSubmissionWithUrl:Url(UploadHeadImg) body:[Helper parametersWith:parameters] progress:^(NSProgress *progress) {
            NSLog(@"%f",1.0*progress.completedUnitCount/progress.totalUnitCount);
        } formBlock:^(id<AFMultipartFormData> formData) {
            NSData *data = UIImagePNGRepresentation(image);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
        } success:^(id result) {
            //成功
            BaseModel *model = [BaseModel new];
            [model setValuesForKeysWithDictionary:result];
            [JGProgressHUD showErrorWithModel:model In:self.view];
            if([model.code isEqual:@1]){
                [_headerImg setHidden:false];
                _headerImg.image = image;
            }
        } fail:^(NSError *error) {
            [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
        }];
    }
    [picker dismissViewControllerAnimated:true completion:nil];
}


- (void)createBackgroundImg:(CGRect)rect label:(UILabel *)label{
    UIView * back = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:back.frame];
    [backImage setImage:[UIImage imageNamed:@"头像框"]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backImage.width - 10*FitWidth, backImage.height - 10*FitHeight)];
    view.backgroundColor = RGBColor(0, 0, 0, 0.5);
    view.layer.cornerRadius = view.width/2;
    [back addSubview:view];
    label.frame = view.frame;
    label.font = FONT_WITH_S(13);
    label.centerX = view.centerX = backImage.centerX;
    label.centerY = view.centerY = backImage.centerY;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [_backgroundImgV addSubview:back];
    [back addSubview:backImage];
    [back addSubview:label];
}

//创建右侧设置按钮
- (void)createRightButton{
    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40*FitWidth, 30*FitHeight)];
    [rightBtn setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=rightItem;
}

//创建左侧通知消息按钮
- (void)creatLeftButton{
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40*FitWidth, 30*FitHeight)];
    [leftBtn setImage:[UIImage imageNamed:@"通知-(4)"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem=leftItem;
}

- (void)leftBtnAction{
    //进入通知中心
    SystemMessageListController *systemMessageListController = [[SystemMessageListController alloc] init];
    [self.navigationController pushViewController:systemMessageListController animated:true];
}

-(void)rightBtnAction{
    GeneralSettingsViewController *generalVC = [[GeneralSettingsViewController alloc] init];
    [self.navigationController pushViewController:generalVC animated:YES];
    NSLog(@"设置");
}



//创建TableView
-(void)createTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor groupTableViewBackgroundColor];
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
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 40;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54*FitHeight;
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
    //关注我的
    if(indexPath.row == 0){
        MyFollowersController *myFollowersController = [[MyFollowersController alloc] init];
        [self.navigationController pushViewController:myFollowersController animated:true];
    }
    //我关注的
    if(indexPath.row == 1){
        IFollowsController *ifollowsController = [[IFollowsController alloc] init];
        [self.navigationController pushViewController:ifollowsController animated:true];
    }
    //我的好友
    if(indexPath.row == 2){
        MyIMFriendsController *myIMFriendsController = [[MyIMFriendsController alloc] init];
        [self.navigationController pushViewController:myIMFriendsController animated:true];
    }
    //成长中心
    if(indexPath.row == 3){
        GrowthCenterController *grothCenterController = [[GrowthCenterController alloc] init];
        [self.navigationController pushViewController:grothCenterController animated:true];
    }
//    LikeMeViewController *likeMeVC = [[LikeMeViewController alloc] init];
//    [self.navigationController pushViewController:likeMeVC animated:YES];
}

- (void)requestData {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
    __weak __typeof__(self) weakSelf = self;
    [VVNetWorkTool postWithUrl:Url(AboutMe) body:[Helper parametersWith:parameters]
                      progress:nil success:^(id result) {
                          NSDictionary *dic = [result objectForKey:@"data"];
                          self.aboutMeModel = [[AboutMeModel alloc] initWithDictionary:dic];
                          [self.tableView reloadData];
                          
                          UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(160, 0, 120, 50)];
                          titleText.backgroundColor = [UIColor clearColor];
                          titleText.textColor=RGBColor(96, 96, 104, 1);
                          titleText.font = FONT_WITH_S(17);
                          titleText.textAlignment = NSTextAlignmentCenter;
                          [titleText setText:self.aboutMeModel.nickname];
                          self.navigationItem.titleView=titleText;
                          if (self.aboutMeModel.authenticationschedule.intValue != 0) {
                              NSString *string1 = [NSString stringWithFormat:@"(完成度%@%%)", self.aboutMeModel.authenticationschedule];
                              self.floatView.authenticationschedule.text = string1;
                          }
                          
                          if (self.aboutMeModel.memberinfoschedule.intValue == 0) {
                              self.floatView.memberinfoschedule.text = @"(未认证)";
                          } else {
                              NSString *string = [NSString stringWithFormat:@"(完成度%@%%)", self.aboutMeModel.memberinfoschedule];
                              self.floatView.memberinfoschedule.text = string;
                          }
                          
                          self.ageLabel.text = [NSString stringWithFormat:@"%@岁",self.aboutMeModel.age];
                          
                          self.statureLabel.text = [NSString stringWithFormat:@"%@",self.aboutMeModel.stature];
                          
                          self.constellationLabel.text = [NSString stringWithFormat:@"%@",self.aboutMeModel.constellation];
                          
                          self.educationLabel.text = [NSString stringWithFormat:@"%@",self.aboutMeModel.education];
                          
                          self.addressLabel.text = [NSString stringWithFormat:@"%@",self.aboutMeModel.address];
                          
                          if (self.aboutMeModel.online == YES) {
                              self.onlineLabel.text = @"当前在线";
                          } else {
                              self.onlineLabel.text = @"当前离线";
                          }
                           [_headerImg sd_setImageWithURL:Url(self.aboutMeModel.headimg) placeholderImage:[UIImage imageNamed:@"照片"]];
                          
                      } fail:^(NSError *error) {
                          
                      }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
