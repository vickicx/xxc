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
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    CGFloat width = scrollView.frame.size.width;
    
    UILabel *advise = [[UILabel alloc] initWithFrame:CGRectMake(kPhotoViewMargin, 5, kWIDTH - 80, 30)];
    advise.text = @"当你照片上传完成后，方可进行效果展示预览";
    advise.textColor = [UIColor colorWithRed:184/255.0 green:186/255.0 blue:189/255.0 alpha:1];
    advise.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:advise];
    
    HXPhotoView *photoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(kPhotoViewMargin, kPhotoViewMargin + 20, width - kPhotoViewMargin * 2, 0) manager:self.manager];
    photoView.delegate = self;
    photoView.backgroundColor = [UIColor whiteColor];
    //    self.manager.localImageList = images;
//    [self.manager addLocalImage:images selected:YES];
//    [photoView refreshView];
    [scrollView addSubview:photoView];
    self.photoView = photoView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStylePlain target:self action:@selector(lookClick)];
    
    self.navigationItem.rightBarButtonItem.tintColor = RGBColor(240, 53, 99, 1);
    [self requestData];
    
}

- (void)lookClick {
    PhotoPreviewViewController *photoView = [[PhotoPreviewViewController alloc] init];
    [self.navigationController pushViewController:photoView animated:YES];
}

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    NSSLog(@"%@",allList);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSSLog(@"%@",NSStringFromCGRect(frame));
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);
    
}

- (void)requestData {
    
    self.pictureModelArr = [NSMutableArray new];
    
    self.picUrlArr = [NSMutableArray new];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    [parameters setValue:@"1" forKey:@"pageindex"]; //分页下标
    
    [parameters setValue:@"21" forKey:@"pagesize"]; //每页数据条数
    
    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
    
    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
    
    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
    
    __weak __typeof__(self) weakSelf = self;
    
    
    
    
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    
    
    
    
    [VVNetWorkTool postWithUrl:Url(Myphotoalbum) body:[Helper parametersWith:parameters]
     
                      progress:nil success:^(id result) {
                          
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
                          
                          
                          
                      } fail:^(NSError *error) {
                          
                          
                          
                      }];
    
}

@end
