//
//  PhotoPreviewViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/13.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PhotoPreviewViewController.h"
#import "FindHimCollectionViewCell.h"

@interface PhotoPreviewViewController ()
@property (nonatomic,strong) UIView *showView;
@property (nonatomic,strong) UIView *shadeView;
@end

@implementation PhotoPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预览";
    [self createView];
    [self createLabels];
    
    // Do any additional setup after loading the view.
}

- (void)createView {
    self.showView = [[UIView alloc] initWithFrame:CGRectMake(27, 90, self.view.width - 54, self.view.height - 120)];
    self.showView.backgroundColor = RGBColor(0, 0, 0, 0.5);
    self.showView.layer.cornerRadius = 10.0f;
    [self.view addSubview: _showView];
    
    UIImageView *mainView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.showView.width, 426 * FitHeight)];
    [mainView setImage:[UIImage imageNamed:@"照片"]];

    UIView *shadeView = [[UIView alloc] initWithFrame:CGRectMake(mainView.left, mainView.top, mainView.width, mainView.height)];
    shadeView.backgroundColor = RGBColor(0, 0, 0, 0.5);
    shadeView.layer.cornerRadius = 10.0f;
    self.shadeView = shadeView;
    [mainView addSubview:_shadeView];
    
    //    UIView *shadeView1 = [[UIView alloc] initWithFrame:CGRectMake(mainView.left , self.showView.top - 40, self.showView.width, self.showView.height - 40)];
//    shadeView1.layer.cornerRadius = 10.0f;
//    shadeView1.backgroundColor = RGBColor(0, 0, 0, 0.5);
//    [self.showView addSubview:shadeView1];

    
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * FitWidth, mainView.bottom + 10 * FitHeight , (mainView.width - 32) / 3, (mainView.width - 32) / 3)];
    leftView.backgroundColor = [UIColor whiteColor];
    [leftView setImage:[UIImage imageNamed:@"照片"]];
    
    UIImageView *middleView = [[UIImageView alloc] initWithFrame:CGRectMake(leftView.right + 6 *FitWidth, leftView.top, leftView.width, leftView.height)];
    middleView.backgroundColor = [UIColor whiteColor];
    [middleView setImage:[UIImage imageNamed:@"照片"]];
    
    UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(middleView.right + 6 *FitWidth, middleView.top, middleView.width, middleView.height)];
    rightView.backgroundColor = [UIColor whiteColor];
    [rightView setImage:[UIImage imageNamed:@"照片"]];
    
    leftView.layer.cornerRadius =  middleView.layer.cornerRadius = rightView.layer.cornerRadius = 10.0f;
    [self.showView addSubview:mainView];
    [self.showView addSubview:leftView];
    [self.showView addSubview:middleView];
    [self.showView addSubview:rightView];
    
    
}


- (void)createLabels {
    UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(self.showView.width - 80, 10, 60, 20)];
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(15, self.shadeView.height - 100, 100, 20)];
    UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(15, userName.bottom + 10, self.shadeView.width - 24, 20)];
    UILabel *signature = [[UILabel alloc] initWithFrame:CGRectMake(15, info.bottom + 10, self.shadeView.width - 24, 40)];
    
    address.text = @"成都(3km)";
    address.textAlignment = NSTextAlignmentRight;
    address.font = [UIFont systemFontOfSize:12];
    
    userName.text = @"dwefewfwe";
    userName.font = [UIFont systemFontOfSize:15];
    CGSize userNameSize = [userName.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:userName.font,NSFontAttributeName,nil]];
    userName.width = userNameSize.width;
    userName.height = userNameSize.height;
    
    UIImageView *sixImageView = [[UIImageView alloc] initWithFrame:CGRectMake(userName.right + 3, userName.top, 20, 20)];
    [sixImageView setImage:[UIImage imageNamed:@"six_girl"]];
    
    info.text = @"24岁 | 166cm | 射手座 | 服装设计";
    info.font = [UIFont systemFontOfSize:12];
    CGSize infoSize = [info.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:info.font,NSFontAttributeName,nil]];
    info.width = infoSize.width;
    info.height = infoSize.height;
    
    signature.text = @"这里是交友的一个签名什么的~";
    signature.font = [UIFont systemFontOfSize:12];
    signature.numberOfLines = 0;
    CGSize signatureSize = [signature.text boundingRectWithSize:CGSizeMake(self.shadeView.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    signature.width = signatureSize.width;
    signature.height = signatureSize.height;
    
    address.textColor = userName.textColor = info.textColor = signature.textColor = [UIColor whiteColor];
    
    [self.shadeView addSubview:address];
    [self.shadeView addSubview:sixImageView];
    [self.shadeView addSubview:userName];
    [self.shadeView addSubview:info];
    [self.shadeView addSubview:signature];
    
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
