//
//  MyPhotoViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/13.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MyPhotoViewController.h"
//#import "HXPhotoViewController.h"
//#import "HXPhotoView.h"
#import "PhotoPreviewViewController.h"
#import "PictureModel.h"
#import "FileUtils.h"
#import "TZImagePickerController.h"
#import "AddNewPhotoCollectionViewCell.h"
#import "ShowPhotoCollectionViewCell.h"
#import "PhotoDetailViewController.h"
#import "LxGridViewFlowLayout.h"

static const CGFloat kPhotoViewMargin = 12.0;

@interface MyPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *pictureModelArr;
@property (nonatomic,strong) NSMutableArray *picUrlArr;
@property (nonatomic,strong) NSMutableArray *picPostArr;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LxGridViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) NSMutableArray *cellArray;
// 传入展示界面的数组
@property (nonatomic, strong) NSArray<UIImage *> *imageArray;
@end

@implementation MyPhotoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的相册";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSource = [NSArray new];
    self.cellArray = [NSMutableArray new];
    self.automaticallyAdjustsScrollViewInsets = YES;

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 48*FitHeight)];
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UILabel *advise = [[UILabel alloc] initWithFrame:CGRectMake(kPhotoViewMargin, 5*FitHeight, kWIDTH - 80*FitWidth, 30*FitHeight)];
    advise.text = @"当你照片上传完成后，方可进行效果展示预览";
    advise.textColor = [UIColor colorWithRed:184/255.0 green:186/255.0 blue:189/255.0 alpha:1];
    advise.font = FONT_WITH_S(14);
    [self.scrollView addSubview:advise];
    
    self.flowLayout = [[LxGridViewFlowLayout alloc] init];
    self.flowLayout.itemSize = CGSizeMake((kWIDTH - 24 * FitWidth)/3 - 10, (kHEIGHT - 64 - 118*FitHeight)/4);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(12 *FitWidth,advise.bottom,kWIDTH - 24 * FitWidth,kHEIGHT - 118*FitHeight - 64) collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate  = self;
    [self.collectionView registerClass:[AddNewPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"addcell"];
    [self.collectionView registerClass:[ShowPhotoCollectionViewCell class] forCellWithReuseIdentifier:@"showcell"];
    [self.scrollView addSubview:_collectionView];
    
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dataSource.count >= 21) {
        return self.dataSource.count;
    } else {
        return 1 + self.dataSource.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AddNewPhotoCollectionViewCell *addcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addcell" forIndexPath:indexPath];
    ShowPhotoCollectionViewCell *showcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"showcell" forIndexPath:indexPath];
    __weak __typeof__(self) weakSelf = self;
    
    if (indexPath.row < self.dataSource.count) {
        PictureModel *model = self.dataSource[indexPath.row];
        showcell.picModel = model;
        showcell.DeletePicBlock = ^(UIButton *sender) {
            [weakSelf deletepicWithIds:model.ids];
        };
        return showcell;
    } else {
        return addcell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.dataSource.count) {
        TZImagePickerController *imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:21 - self.dataSource.count delegate:self];
        //是否 在相册中显示拍照按钮
        imagePickController.allowTakePicture = NO;
        //是否可以选择显示原图
        imagePickController.allowPickingOriginalPhoto = NO;
        //是否 在相册中可以选择视频
        imagePickController.allowPickingVideo = NO;
        imagePickController.maxImagesCount = 21 - self.dataSource.count;
        
        [self.navigationController presentViewController:imagePickController animated:YES completion:nil];
    } else {
        {
            NSMutableArray *mutableArray = [NSMutableArray new];
            
            for (int i = 0; i < self.dataSource.count; i++) {
                NSIndexPath *indexPaths = [NSIndexPath indexPathForRow:i inSection:0];
                ShowPhotoCollectionViewCell *cell = (ShowPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPaths];
                [mutableArray addObject:cell.imageviews.image];
            }
            self.imageArray = [NSArray arrayWithArray:mutableArray];
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
            flowLayout.minimumLineSpacing = 30;
            flowLayout.minimumInteritemSpacing = 0;
            // 设置滚动方向
            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            PhotoDetailViewController *vc = [[PhotoDetailViewController alloc] initWithCollectionViewLayout:flowLayout];
            vc.dataSource = self.imageArray;
            vc.tag = indexPath.row;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
}


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    //添加数据之前应先清空
    [self.cellArray removeAllObjects];
    [self.cellArray addObjectsFromArray:photos];
    [self savePicData];
}

- (void)lookClick {
    PhotoPreviewViewController *photoView = [[PhotoPreviewViewController alloc] init];
    [self.navigationController pushViewController:photoView animated:YES];
}

- (void)savePhoto {
    [self selectsort];
}


//- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
//    NSSLog(@"%@",NSStringFromCGRect(frame));
//    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);
//}
- (void)deletepicWithIds:(NSString *)ids {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    NSMutableArray *arr = [NSMutableArray new];
    for (PictureModel *pic in self.pictureModelArr) {
        [arr addObject:pic.ids];
    }
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    [parameters setValue:ids forKey:@"delpicids"]; //待删除照片下标
    
    
    [VVNetWorkTool postWithUrl:Url(Deletememberpicturewall) body:[Helper parametersWith:parameters]
     
                      progress:nil success:^(id result) {
                          if ([result[@"code"] integerValue]==1) {
                              [self requestData];
                          }
                      } fail:^(NSError *error) {
                          [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
                      }];
}


- (void)savePicData{
    JGProgressHUD *hud = [[JGProgressHUD alloc] initWithStyle:0];
    
    hud.textLabel.text = @"上传中";
    
    [hud showInView:self.view];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
   
    dispatch_group_t upLoadGroup = dispatch_group_create();
    
    for (int i = 0; i < self.cellArray.count; i++) {
        dispatch_group_enter(upLoadGroup);
        [VVNetWorkTool formSubmissionWithUrl:Url(Uploadmemberpicturewall) body:[Helper parametersWith:    parameters] progress:^(NSProgress *progress) {
            NSLog(@"%f",1.0*progress.completedUnitCount/progress.totalUnitCount);
        } formBlock:^(id<AFMultipartFormData> formData) {
            NSData *data = UIImageJPEGRepresentation(self.cellArray[i], 0.5);
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
        } success:^(id result) {
            dispatch_group_leave(upLoadGroup);
            
        } fail:^(NSError *error) {
            
        }];
    }
    dispatch_group_notify(upLoadGroup, dispatch_get_main_queue(), ^{
        [hud dismissAnimated:YES];
        [self requestData];
    });
    
}

- (void)requestData {
    JGProgressHUD *hud = [[JGProgressHUD alloc] initWithStyle:0];
    
    hud.textLabel.text = @"加载中";
    
    [hud showInView:self.view];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    NSMutableArray *mutableArr = [NSMutableArray new];
    
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    [parameters setValue:@"1" forKey:@"pageindex"]; //分页下标
    
    [parameters setValue:@"21" forKey:@"pagesize"]; //每页数据条数
    
    
    [VVNetWorkTool postWithUrl:Url(Myphotoalbum) body:[Helper parametersWith:parameters]
     
                      progress:nil success:^(id result) {
                          
                          
                          NSArray *arr = [result objectForKey:@"data"];
                          
                          for (NSDictionary *dic in arr) {
                              
                              PictureModel *pic = [[PictureModel alloc] initWithDictionary:dic];
                              
                              [mutableArr addObject:pic];
                              
                          }
                          self.dataSource = [NSArray arrayWithArray:mutableArr];
                          
                          [self.collectionView reloadData];
                          
                          [hud dismissAnimated:YES];
                          
                      } fail:^(NSError *error) {
                          [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
                          
                      }];
    
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.dataSource];
    [array removeObjectAtIndex:sourceIndexPath.row];
    [array insertObject:self.dataSource[sourceIndexPath.row] atIndex:destinationIndexPath.row];
    self.dataSource = [NSArray arrayWithArray:array];
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    
}

- (void)selectsort {
    JGProgressHUD *hud = [[JGProgressHUD alloc] initWithStyle:0];
    
    hud.textLabel.text = @"保存中";
    
    [hud showInView:self.view];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    [parameters setValue:@"1" forKey:@"pageindex"]; //分页下标
    
    [parameters setValue:@"21" forKey:@"pagesize"]; //每页数据条数
    
    __block  NSMutableString *sortStr = [NSMutableString new];
    [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PictureModel *model = obj;
        NSLog(@"%@  %@",model.ids,model.sort);
        if (idx == 0) {
            [sortStr appendString:[NSString stringWithFormat:@"%@|%lu",model.ids,(unsigned long)idx]];
        } else {
            [sortStr appendString:[NSString stringWithFormat:@",%@|%lu",model.ids,idx]];
        }
    }];
    [parameters setValue:sortStr forKey:@"picturesort"];
    
    [VVNetWorkTool postWithUrl:Url(Setphotoalbumsort) body:[Helper parametersWith:parameters] progress:^(NSProgress *progress) {
    } success:^(id result) {
        [hud dismissAnimated:YES];
        [JGProgressHUD showSuccessWith:@"保存成功！" In:self.view];
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}


@end

