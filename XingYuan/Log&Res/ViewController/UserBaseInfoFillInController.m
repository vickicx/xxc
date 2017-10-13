//
//  UserBaseInfoFillInController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/11.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "UserBaseInfoFillInController.h"
#import "TZImagePickerController.h"
#import "NickNameFillInController.h"
#import "DatePickerView.h"
#import "AddressPickerView.h"
#import "HeightPickerView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "LoginRegisterController.h"

@interface UserBaseInfoFillInController ()<TZImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UILabel *nickNameInfo;
@property (weak, nonatomic) IBOutlet UILabel *birthdayInfo;
@property (weak, nonatomic) IBOutlet UILabel *heightInfo;
@property (weak, nonatomic) IBOutlet UILabel *areaInfo;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (strong,nonnull) TZImagePickerController *imagePickerController;

@end

@implementation UserBaseInfoFillInController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"基本信息";
    self.headImg.layer.cornerRadius = 3;
    self.headImg.clipsToBounds = true;
    self.finishBtn.layer.cornerRadius = 3;
    self.finishBtn.clipsToBounds = true;
    //基础信息填充完毕需要进行IM登录操作
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//去相册选择头像
- (IBAction)dealToSelectHeadImg:(id)sender {
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
            UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"警告" message:@"该设备不支持相机" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alerVC addAction:okAction];
            [self presentViewController:alerVC animated:true completion:nil];
        }
    }];
    UIAlertAction *toAlbum = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //先检测是否得到相册授权
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        if (status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusDenied)
        {
            // 无权限
            // do something...
            UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"警告" message:@"未获得相册授权，请先设置" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alerVC addAction:okAction];
            [self presentViewController:alerVC animated:true completion:nil];
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

//昵称
- (IBAction)dealTapNickName:(id)sender {
    NickNameFillInController *nickNameFillInController = [[NickNameFillInController alloc] init];
    nickNameFillInController.nickNameBlock = ^(NSString *nickName){
        self.nickNameInfo.text = nickName;
    };
    [self presentViewController:nickNameFillInController animated:true completion:nil];
}

//生日
- (IBAction)dealTapBirthday:(id)sender {
    DatePickerView *datePickerView = [DatePickerView datePickerView];
    datePickerView.datePickerBlock = ^(NSDate *date){
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd"];//设置时间显示的格式，此处使用的formater格式要与字符串格式完全一致，否则转换失败
        NSString *dateStr = [formater stringFromDate:date];//将日期转换成字符串
        self.birthdayInfo.text = dateStr;
    };
    datePickerView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
    [[[UIApplication sharedApplication] keyWindow] addSubview:datePickerView];
}

//身高
- (IBAction)dealTapHeight:(id)sender {
    HeightPickerView *heightPickerView = [HeightPickerView heightPickerView];
    heightPickerView.heightPickerBlock = ^(NSString *height){
        self.heightInfo.text = height;
    };
    heightPickerView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
    [[[UIApplication sharedApplication] keyWindow] addSubview:heightPickerView];
}

//地区
- (IBAction)dealTapArea:(id)sender {
    AddressPickerView *addressPickerView = [AddressPickerView addressPickerView];
    addressPickerView.block = ^(NSString *province, NSString *city){
        self.areaInfo.text = [province stringByAppendingString:city];
    };
    addressPickerView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
    [[[UIApplication sharedApplication] keyWindow] addSubview:addressPickerView];
}

//完成设置
- (IBAction)dealTapFinish:(id)sender {
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
    LoginRegisterController *loginRegisterController = [[LoginRegisterController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginRegisterController];
    [[UIApplication sharedApplication] keyWindow].rootViewController = nav;
}

// MARK: - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    if (image != nil){
        self.headImg.image = image;
    }
    [picker dismissViewControllerAnimated:true completion:nil];
}
@end
