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

static const CGFloat kPhotoViewMargin = 12.0;

@interface MyPhotoViewController ()<HXPhotoViewDelegate>

@property (strong, nonatomic) HXPhotoManager *manager;
@property (weak, nonatomic) HXPhotoView *photoView;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation MyPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的相册";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
  
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UILabel *advise = [[UILabel alloc] initWithFrame:CGRectMake(kPhotoViewMargin, 5, kWIDTH - 80, 30)];
    advise.text = @"当你照片上传完成后，方可进行效果展示预览";
    advise.textColor = [UIColor colorWithRed:184/255.0 green:186/255.0 blue:189/255.0 alpha:1];
    advise.font = [UIFont systemFontOfSize:14];
    [self.scrollView addSubview:advise];
    
    CGFloat width = scrollView.frame.size.width;
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = CGRectMake(kPhotoViewMargin, 45, width - kPhotoViewMargin * 2, 0);
    photoView.delegate = self;
    photoView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:photoView];
    self.photoView = photoView;
    
    // 可以在懒加载中赋值 ,  也可以这样赋值
    self.manager.networkPhotoUrls = [NSMutableArray arrayWithObjects:@"http://oss-cn-hangzhou.aliyuncs.com/tsnrhapp/shop/photos/857980fd0acd3caf9e258e42788e38f5_0.gif",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/0034821a-6815-4d64-b0f2-09103d62630d.jpg",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/0be5118d-f550-403e-8e5c-6d0badb53648.jpg",@"http://tsnrhapp.oss-cn-hangzhou.aliyuncs.com/1466408576222.jpg", nil];
    
    photoView.manager = self.manager;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStylePlain target:self action:@selector(lookClick)];
    self.navigationItem.rightBarButtonItem.tintColor = RGBColor(240, 53, 99, 1);
}

- (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        //        _manager.openCamera = NO;
        _manager.outerCamera = YES;
        _manager.showDeleteNetworkPhotoAlert = NO;
        _manager.saveSystemAblum = YES;
        _manager.photoMaxNum = 2; // 这里需要注意 !!!  第一次传入的最大照片数 是可选最大数 减去 网络照片数量   即   photoMaxNum = maxNum - networkPhotoUrls.count  当点击删除网络照片时, photoMaxNum 内部会自动加1
        _manager.videoMaxNum = 0;  // 如果有网络图片且选择类型为HXPhotoManagerSelectedTypePhotoAndVideo 又设置了视频最大数且不为0时,
        //        那么在选择照片列表最大只能选择 photoMaxNum + videoMaxNum
        //        在外面collectionView上最大数是 photoMaxNum + networkPhotoUrls.count + videoMaxNum
        _manager.maxNum = 6;
        
    }
    return _manager;
}


- (void)lookClick {
    PhotoPreviewViewController *photoView = [[PhotoPreviewViewController alloc] init];
    [self.navigationController pushViewController:photoView animated:YES];
   }

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    
    [HXPhotoTools getImageForSelectedPhoto:photos type:HXPhotoToolsFetchHDImageType completion:^(NSArray<UIImage *> *images) {
        NSSLog(@"%@",images);
    }];
    
}

- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame
{
    NSSLog(@"%@",NSStringFromCGRect(frame));
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);
}

- (void)photoViewAllNetworkingPhotoDownloadComplete:(HXPhotoView *)photoView {
    NSSLog(@"所有网络图片下载完成");
    /*
     网络图片全部下载完成之后会的调一下这个方法
     // 代理返回 选择、移动顺序、删除之后的图片以及视频
     - (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal;
     */
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
