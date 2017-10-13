//
//  MyFloatView.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/12.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MyFloatView.h"
@class MineMainViewController;
@implementation MyFloatView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
        self.layer.cornerRadius = 10.0f;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)createView {
    UIView *MyTreasureView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width / 3, self.height)];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goTreaure)];
    [MyTreasureView addGestureRecognizer:tapGesturRecognizer];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 15, 29, 22)];
    [imageView setImage:[UIImage imageNamed:@"我的财富"]];
    [MyTreasureView addSubview:imageView];
    
    UILabel *treasure = [[UILabel alloc] initWithFrame:CGRectMake(imageView.left - 10, imageView.bottom + 10, 100, 14)];
    treasure.font = [UIFont systemFontOfSize:13];
    treasure.textColor = [UIColor colorWithRed:43/255.0 green:48/255.0 blue:52/255.0 alpha:1];
    treasure.text = @"我的财富";
    [MyTreasureView addSubview:treasure];
    
    [self addSubview:MyTreasureView];
    
    UIView *MyCertificationView = [[UIView alloc] initWithFrame:CGRectMake(self.width / 3 , 0, self.width / 3, self.height)];
    
    UITapGestureRecognizer *tapGesturRecognizer1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goCertification)];
    [MyCertificationView addGestureRecognizer:tapGesturRecognizer1];

    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 15, 29, 22)];
    [imageView1 setImage:[UIImage imageNamed:@"认证"]];
    [MyCertificationView addSubview:imageView1];
    
    UILabel *treasure1 = [[UILabel alloc] initWithFrame:CGRectMake(imageView1.left - 10, imageView1.bottom + 10, 100, 14)];
    treasure1.font = [UIFont systemFontOfSize:13];
    treasure1.textColor = [UIColor colorWithRed:43/255.0 green:48/255.0 blue:52/255.0 alpha:1];
    treasure1.text = @"我的认证";
    [MyCertificationView addSubview:treasure1];
    
    UILabel *smallTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(imageView1.left, treasure1.bottom + 2, 50, 14)];
    smallTitle1.font = [UIFont systemFontOfSize:10];
    smallTitle1.textColor = [UIColor colorWithRed:190/255.0 green:195/255.0 blue:199/255.0 alpha:1];
    smallTitle1.text = @"(未认证)";
    
    [MyCertificationView addSubview:smallTitle1];
    
    [self addSubview:MyCertificationView];

    
    UIView *MyInformationView = [[UIView alloc] initWithFrame:CGRectMake(self.width / 3 * 2, 0, self.width / 3, self.height)];
    UITapGestureRecognizer *tapGesturRecognizer2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goInformation)];
    [MyInformationView addGestureRecognizer:tapGesturRecognizer2];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(40, 15, 29, 22)];
    [imageView2 setImage:[UIImage imageNamed:@"资料"]];
    [MyInformationView addSubview:imageView2];
    
    UILabel *treasure2 = [[UILabel alloc] initWithFrame:CGRectMake(imageView2.left - 10, imageView2.bottom + 10, 100, 14)];
    treasure2.font = [UIFont systemFontOfSize:13];
    treasure2.textColor = [UIColor colorWithRed:43/255.0 green:48/255.0 blue:52/255.0 alpha:1];
    treasure2.text = @"我的资料";
    [MyInformationView addSubview:treasure2];
    
    UILabel *smallTitle = [[UILabel alloc] initWithFrame:CGRectMake(imageView2.left - 10, treasure2.bottom + 2, 100, 14)];
    smallTitle.font = [UIFont systemFontOfSize:10];
    smallTitle.textColor = [UIColor colorWithRed:190/255.0 green:195/255.0 blue:199/255.0 alpha:1];
    smallTitle.text = @"(完成度30%)";
    [MyInformationView addSubview:smallTitle];
    
    [self addSubview:MyInformationView];
}

- (void)goTreaure{
    self.goMyTreasureView();
}
- (void)goCertification{
    self.goMyCertificationView();
}

- (void)goInformation{
    self.goMyInformationView();
}


@end
