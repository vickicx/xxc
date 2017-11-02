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
#import <AssetsLibrary/AssetsLibrary.h>
#import "LoginRegisterController.h"
#import "DataPickerView.h"
#import "PickerDatas.h"

@interface UserBaseInfoFillInController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *noticeLabe1;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel2;

//统一设置字体
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labes;

@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UILabel *nickNameInfo;
@property (weak, nonatomic) IBOutlet UILabel *birthdayInfo;
@property (weak, nonatomic) IBOutlet UILabel *heightInfo;
@property (weak, nonatomic) IBOutlet UILabel *areaInfo;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,copy) NSString *birthDay;
@property (nonatomic,copy) NSString *height;
@property (nonatomic,copy) NSString *area;
@property (nonatomic,weak) UIImage *img;
@end

@implementation UserBaseInfoFillInController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"基本信息";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"基本信息";
    label.font = FONT_WITH_S(18);
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:label1];
    self.navigationItem.rightBarButtonItem = itme;
    self.navigationItem.titleView = label;
    
    self.noticeLabe1.font = FONT_WITH_S(17);
    self.noticeLabel2.font = FONT_WITH_S(17);
    
    self.headImg.layer.cornerRadius = 3;
    self.headImg.clipsToBounds = true;
    
    for(int i=0;i<self.labes.count;i++){
        UILabel *label = self.labes[i];
        label.font = FONT_WITH_S(17);
    }
    
    self.nickNameInfo.font = FONT_WITH_S(17);
    self.birthdayInfo.font = FONT_WITH_S(17);
    self.heightInfo.font = FONT_WITH_S(17);
    self.areaInfo.font = FONT_WITH_S(17);
    
    self.finishBtn.layer.cornerRadius = 3;
    self.finishBtn.clipsToBounds = true;
    self.finishBtn.titleLabel.font = FONT_WITH_S(18);
    
    //基础信息填充完毕需要进行IM登录操作
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --部分属性的Set方法
- (void)setNickName:(NSString *)nickName{
    _nickName = nickName;
    if (_nickName != nil){
        self.nickNameInfo.text = nickName;
    }else{
        self.nickNameInfo.text = @"请输入";
    }
}

- (void)setBirthDay:(NSString *)birthDay{
    _birthDay = birthDay;
    if (_birthDay != nil){
        self.birthdayInfo.text = birthDay;
    }else{
        self.birthdayInfo.text = @"请输入";
    }
}

- (void)setHeight:(NSString *)height{
    _height = height;
    if (_height != nil){
        self.heightInfo.text = height;
    }
    else{
        self.heightInfo.text = @"请输入";
    }
}

- (void)setArea:(NSString *)area{
    _area = area;
    if (_area != nil){
        self.areaInfo.text = area;
    }else{
        self.areaInfo.text = @"请输入";
    }
}

- (void)setImg:(UIImage *)img{
    _img = img;
    if (_img != nil){
        self.headImg.image = img;
        [self.headImg setHidden:false];
    }else{
        [self.headImg setHidden:true];
    }
}

#pragma mark --各个选项点击事件
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

//昵称
- (IBAction)dealTapNickName:(id)sender {
    NickNameFillInController *nickNameFillInController = [[NickNameFillInController alloc] init];
    nickNameFillInController.nickNameBlock = ^(NSString *nickName){
        if (nickName.length){
            self.nickName = nickName;
        }
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
        self.birthDay = dateStr;
    };
    datePickerView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
    [[[UIApplication sharedApplication] keyWindow] addSubview:datePickerView];
}

//身高
- (IBAction)dealTapHeight:(id)sender {
    DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas heights] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
        self.height = value;
    }];
    [dataPickerView toShow];
}

//地区
- (IBAction)dealTapArea:(id)sender {
    AddressPickerView *addressPickerView = [AddressPickerView addressPickerView];
    addressPickerView.block = ^(NSString *province, NSString *city){
        NSString *address = [NSString stringWithFormat:@"%@ %@",province,city];
        self.area = address;
    };
    addressPickerView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
    [[[UIApplication sharedApplication] keyWindow] addSubview:addressPickerView];
}

//完成设置
- (IBAction)dealTapFinish:(id)sender {
    //
    if(![self isParameterIntegrity]){return;}
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:self.memberId forKey:@"memberid"];
    [parameters setValue:self.nickName forKey:@"nickname"];
    [parameters setValue:self.height forKey:@"stature"];
    [parameters setValue:self.area forKey:@"address"];
    [parameters setValue:self.birthDay forKey:@"birthday"];
    
    [JGProgressHUD showStatusWith:nil In:self.view];
    [VVNetWorkTool formSubmissionWithUrl:Url(SetMemberInfo) body:[Helper parametersWith:parameters] progress:^(NSProgress *progress) {
        NSLog(@"%f",1.0*progress.completedUnitCount/progress.totalUnitCount);
    } formBlock:^(id<AFMultipartFormData> formData) {
        NSData *data = UIImagePNGRepresentation(self.img);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];

        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
    } success:^(id result) {
        //成功后直接进入主界面？
        [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
        LoginRegisterController *loginRegisterController = [[LoginRegisterController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginRegisterController];
        [[UIApplication sharedApplication] keyWindow].rootViewController = nav;
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

//检测参数完整性
- (BOOL)isParameterIntegrity{
    if (self.img == nil){
        [Helper showAlertControllerWithMessage:@"头像不能为空" completion:nil];
        return false;
    }
    if (self.nickName == nil){
        [Helper showAlertControllerWithMessage:@"昵称不能为空" completion:nil];
        return false;
    }
    if (self.birthDay == nil){
        [Helper showAlertControllerWithMessage:@"生日不能为空" completion:nil];
        return false;
    }
    if (self.height == nil){
        [Helper showAlertControllerWithMessage:@"身高不能为空" completion:nil];
        return false;
    }
    if (self.area == nil){
        [Helper showAlertControllerWithMessage:@"地区不能为空" completion:nil];
        return false;
    }
    return true;
}

#pragma mark --UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    if (image != nil){
        self.img = image;
    }
    [picker dismissViewControllerAnimated:true completion:nil];
}
@end
