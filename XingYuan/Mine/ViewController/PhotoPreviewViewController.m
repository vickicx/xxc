//
//  PhotoPreviewViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/13.
//  Copyright © 2017年 Vicki. All rights reserved.
//
// 性别选择没做，没有图

#import "PhotoPreviewViewController.h"
#import "FindHimCollectionViewCell.h"
#import "PhotoPreviewModel.h"
#import "PictureModel.h"

@interface PhotoPreviewViewController ()
@property (nonatomic,strong) UIView *showView;
@property (nonatomic,strong) UIView *shadeView;
@property (nonatomic,strong) PhotoPreviewModel *photoPreviewModel;
@property (nonatomic,strong) NSArray *PictureModelArr;
@property (nonatomic,strong) UILabel *address;
@property (nonatomic,strong) UILabel *userName;
@property (nonatomic,strong) UILabel *info;
@property (nonatomic,strong) UILabel *signature;
@property (nonatomic,strong) UIImageView *mainView;
@property (nonatomic,strong) UIImageView *leftView;
@property (nonatomic,strong) UIImageView *middleView;
@property (nonatomic,strong) UIImageView *rightView;
@property (nonatomic,strong) UIImageView *sexImageView;
@end

@implementation PhotoPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预览";
    [self createView];
    [self createLabels];
    [self requestData];
    
    // Do any additional setup after loading the view.
}

- (void)createView {
    self.showView = [[UIView alloc] initWithFrame:CGRectMake(27*FitWidth, 90*FitHeight, self.view.width - 54*FitWidth, self.view.height - 120*FitHeight)];
    self.showView.backgroundColor = RGBColor(0, 0, 0, 0.5);
    self.showView.layer.cornerRadius = 10.0f;
    [self.view addSubview: _showView];
    
    _mainView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.showView.width, 426 * FitHeight)];

    UIView *shadeView = [[UIView alloc] initWithFrame:CGRectMake(_mainView.left, _mainView.top, _mainView.width, _mainView.height)];
    shadeView.backgroundColor = RGBColor(0, 0, 0, 0.5);
    shadeView.layer.cornerRadius = 10.0f;
    self.shadeView = shadeView;
    [_mainView addSubview:_shadeView];
    
    //    UIView *shadeView1 = [[UIView alloc] initWithFrame:CGRectMake(mainView.left , self.showView.top - 40, self.showView.width, self.showView.height - 40)];
//    shadeView1.layer.cornerRadius = 10.0f;
//    shadeView1.backgroundColor = RGBColor(0, 0, 0, 0.5);
//    [self.showView addSubview:shadeView1];

    
    _leftView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * FitWidth, _mainView.bottom + 10 * FitHeight , (_mainView.width - 32*FitWidth) / 3, (_mainView.width - 32*FitWidth) / 3)];
    _leftView.backgroundColor = [UIColor whiteColor];
    
    
    _middleView = [[UIImageView alloc] initWithFrame:CGRectMake(_leftView.right + 6 *FitWidth, _leftView.top, _leftView.width, _leftView.height)];
    _middleView.backgroundColor = [UIColor whiteColor];
   
    
    _rightView = [[UIImageView alloc] initWithFrame:CGRectMake(_middleView.right + 6 *FitWidth, _middleView.top, _middleView.width, _middleView.height)];
    _rightView.backgroundColor = [UIColor whiteColor];
    
    
    _leftView.layer.cornerRadius =  _middleView.layer.cornerRadius = _rightView.layer.cornerRadius = 10.0f;
    [self.showView addSubview:_mainView];
    [self.showView addSubview:_leftView];
    [self.showView addSubview:_middleView];
    [self.showView addSubview:_rightView];
    
    
}


- (void)createLabels {
    self.address = [[UILabel alloc] initWithFrame:CGRectMake(self.showView.width - 80*FitWidth, 10*FitHeight, 60*FitWidth, 20*FitHeight)];
    self.userName = [[UILabel alloc] initWithFrame:CGRectMake(15*FitWidth, self.shadeView.height - 100*FitHeight, 100, 20*FitHeight)];
    self.info = [[UILabel alloc] initWithFrame:CGRectMake(15*FitWidth, _userName.bottom + 10*FitHeight, self.shadeView.width - 24*FitWidth, 20*FitHeight)];
    self.signature = [[UILabel alloc] initWithFrame:CGRectMake(15*FitWidth, _info.bottom + 10*FitHeight, self.shadeView.width - 24*FitWidth, 40*FitHeight)];
    
    _address.text = @"成都(3km)";
    _address.textAlignment = NSTextAlignmentRight;
    _address.font = [UIFont systemFontOfSize:12];
    
    _userName.text = @"dwefewfwe";
    _userName.font = [UIFont systemFontOfSize:15];
    CGSize userNameSize = [_userName.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_userName.font,NSFontAttributeName,nil]];
    _userName.width = userNameSize.width;
    _userName.height = userNameSize.height;
    
 
    
    _info.text = @"24岁 | 166cm | 射手座 | 服装设计";
    _info.font = [UIFont systemFontOfSize:12];
    CGSize infoSize = [_info.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_info.font,NSFontAttributeName,nil]];
    _info.width = infoSize.width;
    _info.height = infoSize.height;
    
    _signature.text = @"这里是交友的一个签名什么的~";
    _signature.font = [UIFont systemFontOfSize:12];
    _signature.numberOfLines = 0;
    CGSize signatureSize = [_signature.text boundingRectWithSize:CGSizeMake(self.shadeView.width - 20*FitWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    _signature.width = signatureSize.width;
    _signature.height = signatureSize.height;
    
    _address.textColor = _userName.textColor = _info.textColor = _signature.textColor = [UIColor whiteColor];
    
    [self.shadeView addSubview:_address];
    [self.shadeView addSubview:_sexImageView];
    [self.shadeView addSubview:_userName];
    [self.shadeView addSubview:_info];
    [self.shadeView addSubview:_signature];
    
}


- (void)requestData {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
    __weak __typeof__(self) weakSelf = self;
    [VVNetWorkTool postWithUrl:Url(PhotoAlbumPreview) body:[Helper parametersWith:parameters]
                      progress:nil success:^(id result) {
                          NSDictionary *dic = [result objectForKey:@"data"];
                          
                          self.photoPreviewModel = [[PhotoPreviewModel alloc] initWithDictionary:dic];
                          
                          _address.text = self.photoPreviewModel.address;
                          _userName.text = self.photoPreviewModel.nickname;
                          _signature.text = self.photoPreviewModel.summary;
                          _info.text = [NSString stringWithFormat:@"%@岁 | %@ | %@ | %@", self.photoPreviewModel.age, self.photoPreviewModel.stature, self.photoPreviewModel.constellation, self.photoPreviewModel.work];
                          for ( PictureModel *pic in self.photoPreviewModel.pictureModelArr) {
                              if (pic.sort.intValue == 1) {
                                  [_mainView sd_setImageWithURL:Url(pic.pic) placeholderImage:[UIImage imageNamed:@"照片"]];
                                  
                              }else if (pic.sort.intValue == 2){
                                   [_leftView sd_setImageWithURL:Url(pic.pic) placeholderImage:[UIImage imageNamed:@"照片"]];
                              }else if (pic.sort.intValue == 3){
                                   [_middleView sd_setImageWithURL:Url(pic.pic) placeholderImage:[UIImage imageNamed:@"照片"]];
                              }else if (pic.sort.intValue == 4){
                                   [_rightView sd_setImageWithURL:Url(pic.pic) placeholderImage:[UIImage imageNamed:@"照片"]];
                              }
                          }
                          [_userName sizeToFit];
                          _sexImageView.frame = CGRectMake(_userName.right + 3*FitWidth, _userName.top, 20*FitWidth, 20*FitHeight);
                          [_sexImageView setImage:[UIImage imageNamed:@"six_girl"]];
                          
                          
                          
                          
                          
                          
                      } fail:^(NSError *error) {
                          
                      }];
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
