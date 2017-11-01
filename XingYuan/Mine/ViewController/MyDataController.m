//
//  MyDataController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MyDataController.h"
#import "FillUserInfoCell.h"
#import "BasiceInfoCell.h"
#import "MyDataHeadImageCell.h"
#import "MyDataSelectTypeCell.h"
#import "MyDataSelectTypeCell.h"
#import "FillUserInfoNoticeHeaderView.h"
#import "MyDataIStageInfoCell.h"
#import "DatePickerView.h"
#import "DataPickerView.h"
#import "PickerDatas.h"
#import "AddressPickerView.h"
#import "SelfIntroduceInputController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MyPhotoViewController.h"
#import "MyDataModel.h"
#import "MyMateRequireModel.h"
#import "OneStageScreeningController.h"
#import "TwoStageScreeningController.h"
#import "FourStageScreeningController.h"
#import "FiveStageScreeningController.h"
#import "NSDictionary+ScreeningValues.h"
#import "MateRequirementAuthenticationCell.h"
#import "SelectAuthenticationController.h"

@interface MyDataController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UIButton *finishBtn;
//我的头像
@property (nonatomic,strong) MyDataHeadImageCell *myDataHeadImageCell;
//我的相册
@property (nonatomic,strong) FillUserInfoCell *myalbumCell;
//个人介绍
@property (nonatomic,strong) FillUserInfoCell *selfIntroduceCell;
//选项卡
@property (nonatomic,strong) MyDataSelectTypeCell *myDataSelectTypeCell;
//我的资料Cells
@property (nonatomic,strong) NSArray  *myDataCells;
//我的资料Cell的title列表
@property (nonatomic,copy) NSArray *myDataCellTitles;
//择偶标准下择偶标准信息填写数目Cell
@property (nonatomic,strong) BasiceInfoCell *basicInfoCell;
//择偶标准Cells
@property (nonatomic,strong) NSArray *suposeStandardCells;
//择偶标准Cell的title列表
@property (nonatomic,copy) NSArray *suposeStandardCellTitles;

@property (nonatomic,assign) MyDataSelectType myDataSelectType;

@property (nonatomic,strong) SelfIntroduceInputController *introduceInputController;

//我的资料模型
@property (nonatomic,strong) MyDataModel *mydataModel;
//我的择偶要求
@property (nonatomic,strong) MyDataModel *myMateRequireModel;
@end

@implementation MyDataController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"我的资料";
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"我的资料";
    label.font = FONT_WITH_S(18);
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:label1];
    self.navigationItem.rightBarButtonItem = itme;
    self.navigationItem.titleView = label;
    
    self.myDataCellTitles = @[@"基本资料",@"个人情况",@"家庭情况",@"未来规划"];
    self.suposeStandardCellTitles = @[@"年龄",@"身高",@"月收入",@"学历",@"婚姻状况",@"体型",@"工作地区",@"是否想要孩子",@"是否抽烟",@"是否喝酒",@"购房情况",@"购车情况"];
    
    NSMutableArray *suposeStandardCells = [[NSMutableArray alloc] init];
    for(int i=0;i<_suposeStandardCellTitles.count;i++){
        FillUserInfoCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"FillUserInfoCell" owner:nil options:nil] lastObject];
        cell.leftLabel.text = self.suposeStandardCellTitles[i];
        cell.placeHolderColor = [UIColor redColor];
        cell.placeHolder = @"请填写";
        [suposeStandardCells addObject:cell];
    }
    self.suposeStandardCells = suposeStandardCells;
    
    self.myDataHeadImageCell = [[[NSBundle mainBundle] loadNibNamed:@"MyDataHeadImageCell" owner:nil options:nil] lastObject];
    
    self.myalbumCell = [[[NSBundle mainBundle] loadNibNamed:@"FillUserInfoCell" owner:nil options:nil] lastObject];
    self.myalbumCell.leftLabel.text = @"我的相册";
    
    self.selfIntroduceCell = [[[NSBundle mainBundle] loadNibNamed:@"FillUserInfoCell" owner:nil options:nil] lastObject];
    self.selfIntroduceCell.leftLabel.text = @"个人介绍";
    self.selfIntroduceCell.placeHolderColor = [UIColor redColor];
    
     __weak __typeof(self)weakSelf = self;
    self.introduceInputController = [[SelfIntroduceInputController alloc] init];
    self.introduceInputController.callBackBlock = ^(NSString *introduce){
        weakSelf.mydataModel.summary = introduce;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    self.myDataSelectTypeCell = [[[NSBundle mainBundle] loadNibNamed:@"MyDataSelectTypeCell" owner:nil options:nil] lastObject];
    self.myDataSelectTypeCell.selectTypeBlock = ^(MyDataSelectType selectType){
        [weakSelf dealSelectType:selectType];
    };
    
    self.basicInfoCell = [[[NSBundle mainBundle] loadNibNamed:@"BasiceInfoCell" owner:nil options:nil] lastObject];
    self.basicInfoCell.title = @"择偶标准";

    [self.tableView registerNib:[UINib nibWithNibName:@"MyDataIStageInfoCell" bundle:nil] forCellReuseIdentifier:@"MyDataIStageInfoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MateRequirementAuthenticationCell" bundle:nil] forCellReuseIdentifier:@"MateRequirementAuthenticationCell"];
    self.myDataSelectType = MyDataSelectTypeMyData;
    [self requestMyData];
    [self requestMyMateRequireMent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - misc

- (void)dealSelectType:(MyDataSelectType)selectType{
    self.myDataSelectType = selectType;
    [self.tableView reloadData];
}

//向服务器请求资料信息
- (void)requestMyData{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    [VVNetWorkTool postWithUrl:Url(MyInfo) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        MyDataModel *mydataModel = [MyDataModel new];
        [mydataModel setValuesForKeysWithDictionary:result];
        [mydataModel setValuesForKeysWithDictionary:[result valueForKey:@"data"]];
        self.mydataModel = mydataModel;
        [self.tableView reloadData];
        [JGProgressHUD showErrorWithModel:mydataModel In:self.view];
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

//获取我的择偶要求
- (void)requestMyMateRequireMent{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    //type     1:简单，2：标准
    [parameters setValue:@2 forKey:@"type"];
    
    [VVNetWorkTool postWithUrl:Url(MateSelectionRequire) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        MyDataModel *myMateRequireModel = [MyDataModel new];
        [myMateRequireModel setValuesForKeysWithDictionary:result];
        [myMateRequireModel setValuesForKeysWithDictionary:[result valueForKey:@"data"]];
        self.myMateRequireModel = myMateRequireModel;
        [self.tableView reloadData];
        [JGProgressHUD showErrorWithModel:myMateRequireModel In:self.view];
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (void)refreshWithMyMateRequireModel:(MyMateRequireModel *)model{
    FillUserInfoCell *cell;
    //年龄
    cell = self.suposeStandardCells[0];
    cell.infoValue = model.age;
    
    //身高
    cell = self.suposeStandardCells[1];
    cell.infoValue = model.stature;
    
    //月收入
    cell = self.suposeStandardCells[2];
    cell.infoValue = model.monthlyincome;
    
    //学历
    cell = self.suposeStandardCells[3];
    cell.infoValue = model.educational;
    
    //婚姻状况
    cell = self.suposeStandardCells[4];
    cell.infoValue = model.maritalstatus;
    
    //体型
    cell = self.suposeStandardCells[5];
    cell.infoValue = model.physique;
    
    //工作地区
    cell = self.suposeStandardCells[6];
    cell.infoValue = model.nowaddress;
    
    //是否想要孩子
    cell = self.suposeStandardCells[7];
    cell.infoValue = model.wanthavechildren;
    
    //是否抽烟
    cell = self.suposeStandardCells[8];
    cell.infoValue = model.smoking;
    
    //是否喝酒
    cell = self.suposeStandardCells[9];
    cell.infoValue = model.drink;
    
    //购房情况
    cell = self.suposeStandardCells[10];
    cell.infoValue = model.housesstatus;
    
    //购车情况
    cell = self.suposeStandardCells[11];
    cell.infoValue = model.carstatus;
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
                [self.myDataHeadImageCell.headImgV setHidden:false];
                self.myDataHeadImageCell.headImgV.image = image;
            }
        } fail:^(NSError *error) {
            [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
        }];
    }
    [picker dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 3;
    }
    if(section == 1){
        return 1;
    }
    if(section == 2){
        if(self.myDataSelectType == MyDataSelectTypeMyData){
            if(self.mydataModel == nil){return 0;}
            if(self.mydataModel != nil){
                return 4;
            }
        }
        if(self.myDataSelectType == MyDataSelectTypeSuposeStandard){
            if(self.myMateRequireModel == nil){return 0;}
            if(self.myMateRequireModel != nil){
                return 5;
            }
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            if([self.mydataModel.headimg length] <= 0){
                [self.myDataHeadImageCell.headImgV setHidden:true];
            }else{
                [self.myDataHeadImageCell.headImgV setHidden:false];
                [self.myDataHeadImageCell.headImgV sd_setImageWithURL:Url(self.mydataModel.headimg)];
            }
            return self.myDataHeadImageCell;
        }
        if(indexPath.row == 1){
            //真是日了🐶了
            if([self.mydataModel.picturecount isEqual:@0] || (self.mydataModel.picturecount == nil)){
                
            }else{
                self.myalbumCell.infoValue = [NSString stringWithFormat:@"%@",self.mydataModel.picturecount];
            }
            return self.myalbumCell;
        }
        if(indexPath.row == 2){
            if([self.mydataModel.summary length] > 0){
                self.selfIntroduceCell.infoValue = self.mydataModel.summary;
            }else{
                self.selfIntroduceCell.placeHolder = @"未填写";
                self.selfIntroduceCell.infoValue = nil;
            }
            return self.selfIntroduceCell;
        }
    }
    if(indexPath.section == 1){
        return self.myDataSelectTypeCell;
    }
    if(indexPath.section == 2){
        UIColor *lightGray = RGBColor(240, 241, 241, 1);
        UIColor *lightRed = RGBColor(255, 239, 243, 1);
        if(self.myDataSelectType == MyDataSelectTypeMyData){
            MyDataIStageInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyDataIStageInfoCell" forIndexPath:indexPath];
            if(indexPath.row == 0){
                cell.leftLabelTitle = @"基本资料";
                cell.editBlock = ^(){
                    OneStageScreeningController *oneStageScreeningController = [[OneStageScreeningController alloc] initWithType:ScreeningControllerTypeUpdatelocal basicInfoCellPreTitle:@"基本资料"];
                    oneStageScreeningController.block = ^(BaseModel *model){
                        if([model isKindOfClass:[OneStageScreeningModel class]]){
                            self.mydataModel.matchinglevelone = model;
                            [self.tableView reloadData];
                        }
                    };
                    [self.navigationController pushViewController:oneStageScreeningController animated:true];
                };
                NSArray *titles = [[self.mydataModel.matchinglevelone mj_keyValues] allScreeningValues];
                [cell configWithTitles:titles color:lightGray];
            }
            if(indexPath.row == 1){
                cell.leftLabelTitle = @"个人情况";
                cell.editBlock = ^(){
                    TwoStageScreeningController *twoStageScreeningController = [[TwoStageScreeningController alloc] initWithType:ScreeningControllerTypeUpdatelocal basicInfoCellPreTitle:@"个人情况"];
                    twoStageScreeningController.block = ^(BaseModel *model){
                        if([model isKindOfClass:[TwoStateScreeningModel class]]){
                            self.mydataModel.matchingleveltwo = model;
                            [self.tableView reloadData];
                        }
                    };
                    [self.navigationController pushViewController:twoStageScreeningController animated:true];
                };
                NSArray *titles = [[self.mydataModel.matchingleveltwo mj_keyValues] allScreeningValues];
                [cell configWithTitles:titles color:lightRed];
            }
            if(indexPath.row == 2){
                cell.leftLabelTitle = @"家庭情况";
                cell.editBlock = ^(){
                    FourStageScreeningController *fourStageScreeningController = [[FourStageScreeningController alloc] initWithType:ScreeningControllerTypeUpdatelocal basicInfoCellPreTitle:@"家庭情况"];
                    fourStageScreeningController.block = ^(BaseModel *model){
                        if([model isKindOfClass:[FourStageScreeningModel class]]){
                            self.mydataModel.matchinglevelfour = model;
                            [self.tableView reloadData];
                        }
                    };
                    [self.navigationController pushViewController:fourStageScreeningController animated:true];
                };
                NSArray *titles = [[self.mydataModel.matchinglevelfour mj_keyValues] allScreeningValues];
                [cell configWithTitles:titles color:lightGray];
            }
            if(indexPath.row == 3){
                cell.leftLabelTitle = @"未来规划";
                cell.editBlock = ^(){
                    FiveStageScreeningController *fiveStageScreeningController = [[FiveStageScreeningController alloc] initWithType:ScreeningControllerTypeUpdatelocal basicInfoCellPreTitle:@"未来规划"];
                    fiveStageScreeningController.block = ^(BaseModel *model){
                        if([model isKindOfClass:[FiveStageScreeningModel class]]){
                            self.mydataModel.matchinglevelfive = model;
                            [self.tableView reloadData];
                        }
                    };
                    [self.navigationController pushViewController:fiveStageScreeningController animated:true];
                };
                NSArray *titles = [[self.mydataModel.matchinglevelfive mj_keyValues] allScreeningValues];
                [cell configWithTitles:titles color:lightRed];
            }
            return cell;
        }
        //选中了择偶条件
        if(self.myDataSelectType == MyDataSelectTypeSuposeStandard){
            MyDataIStageInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyDataIStageInfoCell" forIndexPath:indexPath];
            if(indexPath.row == 0){
                cell.leftLabelTitle = @"基本资料";
                cell.editBlock = ^(){
                    OneStageScreeningController *oneStageScreeningController = [[OneStageScreeningController alloc] initWithType:ScreeningControllerTypeMateRequireMent basicInfoCellPreTitle:@"基本资料"];
                    oneStageScreeningController.block = ^(BaseModel *model){
                        if([model isKindOfClass:[OneStageScreeningModel class]]){
                            self.myMateRequireModel.matchinglevelone = model;
                            [self.tableView reloadData];
                        }
                    };
                    [self.navigationController pushViewController:oneStageScreeningController animated:true];
                };
                NSArray *titles = [[self.myMateRequireModel.matchinglevelone mj_keyValues] allScreeningValues];
                [cell configWithTitles:titles color:lightGray];
            }
            if(indexPath.row == 1){
                MateRequirementAuthenticationCell *mateRequirementAuthenticationCell = [tableView dequeueReusableCellWithIdentifier:@"MateRequirementAuthenticationCell" forIndexPath:indexPath];
                
                mateRequirementAuthenticationCell.editBlock = ^(){
                    SelectAuthenticationController *selectAuthenticationController = [[SelectAuthenticationController alloc] init];
                    selectAuthenticationController.callBackBlock = ^(ThreeStageScreeningModel *model){
                        self.myMateRequireModel.matchinglevelthree = model;
                        [self.tableView reloadData];
                    };
                    [self.navigationController pushViewController:selectAuthenticationController animated:true];
                };
                [mateRequirementAuthenticationCell configWithModel:self.myMateRequireModel.matchinglevelthree];
                return mateRequirementAuthenticationCell;
            }
            if(indexPath.row == 2){
                cell.leftLabelTitle = @"个人情况";
                cell.editBlock = ^(){
                    TwoStageScreeningController *twoStageScreeningController = [[TwoStageScreeningController alloc] initWithType:ScreeningControllerTypeMateRequireMent basicInfoCellPreTitle:@"个人情况"];
                    twoStageScreeningController.block = ^(BaseModel *model){
                        if([model isKindOfClass:[TwoStateScreeningModel class]]){
                            self.myMateRequireModel.matchingleveltwo = model;
                            [self.tableView reloadData];
                        }
                    };
                    [self.navigationController pushViewController:twoStageScreeningController animated:true];
                };
                NSArray *titles = [[self.myMateRequireModel.matchingleveltwo mj_keyValues] allScreeningValues];
                [cell configWithTitles:titles color:lightRed];
            }
            if(indexPath.row == 3){
                cell.leftLabelTitle = @"家庭情况";
                cell.editBlock = ^(){
                    FourStageScreeningController *fourStageScreeningController = [[FourStageScreeningController alloc] initWithType:ScreeningControllerTypeMateRequireMent basicInfoCellPreTitle:@"家庭情况"];
                    fourStageScreeningController.block = ^(BaseModel *model){
                        if([model isKindOfClass:[FourStageScreeningModel class]]){
                            self.myMateRequireModel.matchinglevelfour = model;
                            [self.tableView reloadData];
                        }
                    };
                    [self.navigationController pushViewController:fourStageScreeningController animated:true];
                };
                NSArray *titles = [[self.myMateRequireModel.matchinglevelfour mj_keyValues] allScreeningValues];
                [cell configWithTitles:titles color:lightGray];
            }
            if(indexPath.row == 4){
                cell.leftLabelTitle = @"未来规划";
                cell.editBlock = ^(){
                    FiveStageScreeningController *fiveStageScreeningController = [[FiveStageScreeningController alloc] initWithType:ScreeningControllerTypeMateRequireMent basicInfoCellPreTitle:@"未来规划"];
                    fiveStageScreeningController.block = ^(BaseModel *model){
                        if([model isKindOfClass:[FiveStageScreeningModel class]]){
                            self.myMateRequireModel.matchinglevelfive = model;
                            [self.tableView reloadData];
                        }
                    };
                    [self.navigationController pushViewController:fiveStageScreeningController animated:true];
                };
                NSArray *titles = [[self.myMateRequireModel.matchinglevelfive mj_keyValues] allScreeningValues];
                [cell configWithTitles:titles color:lightRed];
            }
            return cell;
        }
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            return 80;
        }
        if(indexPath.row == 1){
            return 40;
        }
        if(indexPath.row == 2){
            return 40;
        }
    }
    if(indexPath.section == 1){
        return 40;
    }
    if(indexPath.section == 2){
        return UITableViewAutomaticDimension;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return 40;
    }
    return 0.001;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 1){
        return 10;
    }
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 1){
        FillUserInfoNoticeHeaderView *noticeView = [[FillUserInfoNoticeHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        noticeView.notice = @"请完善一下您的个人资料";
        return  noticeView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        //去选择头像
        if(indexPath.row == 0){
            [self toChooseHeadImg];
        }
        //去我的相册
        if(indexPath.row == 1){
            MyPhotoViewController *myPhotoViewController = [[MyPhotoViewController alloc] init];
            [self.navigationController pushViewController:myPhotoViewController animated:true];
        }
        //去个人介绍填写
        if(indexPath.row == 2){
            
            [self.navigationController pushViewController:self.introduceInputController animated:true];
        }
    }
    if(indexPath.section == 1){
        
    }
    if(indexPath.section == 2 && self.myDataSelectType == MyDataSelectTypeSuposeStandard){
    }
}


@end
