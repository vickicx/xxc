//
//  MyPhotoViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/13.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MyPhotoViewController.h"
#import "HXPhotoViewController.h"
#import "HXPhotoView.h"
#import "PhotoPreviewViewController.h"
#import "PictureModel.h"
#import "FileUtils.h"

static const CGFloat kPhotoViewMargin = 12.0;

@interface MyPhotoViewController ()<HXPhotoViewDelegate>

@property (strong, nonatomic) HXPhotoManager *manager;
@property (weak, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *pictureModelArr;
@property (nonatomic,strong) NSMutableArray *picUrlArr;
@property (nonatomic,strong) NSMutableArray *picPostArr;
@end

@implementation MyPhotoViewController
- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.openCamera = YES;
        _manager.cacheAlbum = YES;
        _manager.lookLivePhoto = YES;
        //        _manager.outerCamera = YES;
        _manager.open3DTouchPreview = YES;
        _manager.cameraType = HXPhotoManagerCameraTypeSystem;
        _manager.photoMaxNum = 21;
        _manager.videoMaxNum = 9;
        _manager.maxNum = 21;
        _manager.saveSystemAblum = NO;
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    // 加载本地图片
//    NSMutableArray *images = [NSMutableArray array];
    
//    for (int i = 0 ; i < 4; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
//        
//        [images addObject:image];
//    }
    //    [self.manager addLocalImageToAlbumWithImages:images];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 48*FitHeight)];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat width = scrollView.frame.size.width;
    
    UILabel *advise = [[UILabel alloc] initWithFrame:CGRectMake(kPhotoViewMargin, 5*FitHeight, kWIDTH - 80*FitWidth, 30*FitHeight)];
    advise.text = @"当你照片上传完成后，方可进行效果展示预览";
    advise.textColor = [UIColor colorWithRed:184/255.0 green:186/255.0 blue:189/255.0 alpha:1];
    advise.font = FONT_WITH_S(14);
    [self.scrollView addSubview:advise];
    
    HXPhotoView *photoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(kPhotoViewMargin, kPhotoViewMargin + 20*FitHeight, width - kPhotoViewMargin * 2, 0) manager:self.manager];
    photoView.delegate = self;
    photoView.backgroundColor = [UIColor whiteColor];
    //    self.manager.localImageList = images;
//    [self.manager addLocalImage:images selected:YES];
//    [photoView refreshView];
    [scrollView addSubview:photoView];
    self.photoView = photoView;
    
    UIView *previewButton = [[UIView alloc] initWithFrame:CGRectMake(0, kHEIGHT - 48 *FitHeight, kWIDTH, 48*FitHeight)];
    previewButton.backgroundColor = RGBColor(246, 80, 118, 1);
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(135*FitWidth, (previewButton.height - 22*FitHeight) / 2, 22*FitWidth, 22 *FitHeight)];
    [image setImage:[UIImage imageNamed:@"预览"]];
    [previewButton addSubview:image];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(image.right + 10*FitWidth, 0, 80*FitWidth, image.height)];
    label.text = @"效果预览";
    label.textColor = [UIColor whiteColor];
    label.font = FONT_WITH_S(18);
    label.centerY = image.centerY;
    [previewButton addSubview:label];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookClick)];
    [previewButton addGestureRecognizer:tapGesturRecognizer];
    [self.view addSubview:previewButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(savePhoto)];
    self.navigationItem.rightBarButtonItem.tintColor = RGBColor(240, 53, 99, 1);
    [self requestData];
    
}

- (void)lookClick {
    PhotoPreviewViewController *photoView = [[PhotoPreviewViewController alloc] init];
    [self.navigationController pushViewController:photoView animated:YES];
}

- (void)savePhoto {
    [self savePicData];
}

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    NSSLog(@"%@",allList);
    [HXPhotoTools getSelectedListResultModel:allList complete:^(NSArray<HXPhotoResultModel *> *alls, NSArray<HXPhotoResultModel *> *photos, NSArray<HXPhotoResultModel *> *videos) {
        NSLog(@"111%@",photos[1].fullSizeImageURL);
        self.picPostArr = [NSMutableArray new];
        NSMutableArray *arr = [NSMutableArray new];
        for (HXPhotoModel *model in photos) {
            UIImage *image = [UIImage imageWithContentsOfFile:[[model.fullSizeImageURL absoluteString] substringFromIndex:7]];
            [arr addObject:image];
            NSLog(@"~~~~~~~%@",[[model.fullSizeImageURL absoluteString] substringFromIndex:7]);
        }
        self.picPostArr = arr;
    }];
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSSLog(@"%@",NSStringFromCGRect(frame));
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);
}
- (void)deletepic {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    NSMutableArray *arr = [NSMutableArray new];
    for (PictureModel *pic in self.pictureModelArr) {
        [arr addObject:pic.ids];
    }
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    [parameters setValue:[arr componentsJoinedByString:@","] forKey:@"delpicids"]; //待删除照片下标
    
    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
    
    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
    
    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
    
    __weak __typeof__(self) weakSelf = self;
    
    [VVNetWorkTool postWithUrl:Url(Deletememberpicturewall) body:[Helper parametersWith:parameters]
     
                      progress:nil success:^(id result) {
                          
                      } fail:^(NSError *error) {
                          
                      }];
}

- (void)savePicData{
    JGProgressHUD *hud = [[JGProgressHUD alloc] initWithStyle:0];
    
    hud.textLabel.text = @"上传中";
    
    [hud showInView:self.view];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
     for (int i = 0; i < self.picPostArr.count; i++) {
    [VVNetWorkTool formSubmissionWithUrl:Url(Uploadmemberpicturewall) body:[Helper parametersWith:    parameters] progress:^(NSProgress *progress) {
        NSLog(@"%f",1.0*progress.completedUnitCount/progress.totalUnitCount);
    } formBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(self.picPostArr[i], 0.5);
//        UIImagePNGRepresentation(self.picPostArr[i]);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
    } success:^(id result) {
        [hud dismissAnimated:YES];
    } fail:^(NSError *error) {
        NSLog(@"失败");
    }];
     }
    [self deletepic];
}

- (void)requestData {
    JGProgressHUD *hud = [[JGProgressHUD alloc] initWithStyle:0];
    
    hud.textLabel.text = @"加载中";
    
    [hud showInView:self.view];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    [parameters setValue:@"1" forKey:@"pageindex"]; //分页下标
    
    [parameters setValue:@"21" forKey:@"pagesize"]; //每页数据条数
    
    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
    
    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
    
    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
    
    __weak __typeof__(self) weakSelf = self;
    
    [VVNetWorkTool postWithUrl:Url(Myphotoalbum) body:[Helper parametersWith:parameters]
     
                      progress:nil success:^(id result) {
                          self.pictureModelArr = [NSMutableArray new];
                          
                          self.picUrlArr = [NSMutableArray new];
                          
                          NSMutableArray *arr = [result objectForKey:@"data"];
                          
                          for (NSDictionary *dic in arr) {
                              
                              PictureModel *pic = [[PictureModel alloc] initWithDictionary:dic];
                              
                              [self.pictureModelArr addObject:pic];
                             
                              NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:Url(pic.pic)]];
                              
                              UIImage *image = [UIImage imageWithData:data]; // 取得图片
                         
//                              [FileUtils creatFile:[NSString stringWithFormat:@"nnn%@",pic.sort] withData:data];
                              NSString *path_sandox = NSHomeDirectory();
                              //设置一个图片的存储路径
                              NSString *imagePath = [path_sandox stringByAppendingString:[NSString stringWithFormat:@"/nnn%@.png",pic.sort]];
                              //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
                              [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
                        
                              if ( [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES]) {
                                  NSLog(@"成功");
                              }else {
                                  NSLog(@"失败");
                              }
                          }
                          
                          NSMutableArray *images = [NSMutableArray array];
                      
                          for (PictureModel *pic in self.pictureModelArr) {
                              
                              //借助以上获取的沙盒路径读取图片
                              // 读取沙盒路径图片
                              NSString *aPath3=[NSString stringWithFormat:@"%@/nnn%@.png",NSHomeDirectory(),pic.sort];
                              // 拿到沙盒路径图片
                              UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
                              [images addObject:imgFromUrl3];
                          }
                  
                          [self.manager addLocalImage:images selected:YES];
                          
                          weakSelf.photoView.manager = self.manager;
                          [weakSelf.photoView refreshView];
                          [hud dismissAnimated:YES];
                      } fail:^(NSError *error) {
                          
                      }];
    
}

@end
