//
//  FindHimCollectionViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "FindHimCollectionViewCell.h"
@interface FindHimCollectionViewCell()
@property (nonatomic,strong) UIView *shadeView;
@end

@implementation FindHimCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self createView];
        [self addLabel];
        [self createLabels];
        
    }
    return self;
}

- (void)createView {
    UIButton *mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mainButton.frame = CGRectMake(0, 0, self.width, 362 * FitHeight);
    mainButton.backgroundColor = [UIColor whiteColor];
    [mainButton setBackgroundImage:[UIImage imageNamed:@"照片"] forState:UIControlStateNormal];
    [mainButton addTarget:self action:@selector(mainButtonDidSelect:) forControlEvents:UIControlEventTouchUpInside];
    UIView *shadeView = [[UIView alloc] initWithFrame:CGRectMake(mainButton.left, mainButton.top, mainButton.width, mainButton.height)];
    shadeView.backgroundColor = RGBColor(0, 0, 0, 0.5);
    self.shadeView = shadeView;
    [mainButton addSubview:_shadeView];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(10 * FitWidth, mainButton.bottom + 10 * FitHeight , (mainButton.width - 26) / 3, (mainButton.width - 26) / 3);
    leftButton.backgroundColor = [UIColor whiteColor];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"照片"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(mainButtonDidSelect:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    middleButton.frame = CGRectMake(leftButton.right + 3 *FitWidth, leftButton.top, leftButton.width, leftButton.height);
    middleButton.backgroundColor = [UIColor whiteColor];
    [middleButton setBackgroundImage:[UIImage imageNamed:@"照片"] forState:UIControlStateNormal];
    [middleButton addTarget:self action:@selector(mainButtonDidSelect:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *righButton = [UIButton buttonWithType:UIButtonTypeCustom];
    righButton.frame = CGRectMake(middleButton.right + 3 *FitWidth, leftButton.top, leftButton.width, leftButton.height);
    righButton.backgroundColor = [UIColor whiteColor];
    [righButton setBackgroundImage:[UIImage imageNamed:@"照片"] forState:UIControlStateNormal];
    [righButton addTarget:self action:@selector(mainButtonDidSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:mainButton];
    [self addSubview:leftButton];
    [self addSubview:middleButton];
    [self addSubview:righButton];
   
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}

- (void)createLabels {
    UILabel *address = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 80, 10, 60, 20)];
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(15, self.shadeView.height - 100, 100, 20)];
    UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(15, userName.bottom + 10, self.shadeView.width - 24, 20)];
    self.signature = [[UILabel alloc] initWithFrame:CGRectMake(15, info.bottom + 10, self.shadeView.width - 24, 40)];
    
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
    
    _signature.text = @"这里是交友的一个签名什么的~";
    _signature.font = [UIFont systemFontOfSize:12];
    _signature.numberOfLines = 0;
     CGSize signatureSize = [_signature.text boundingRectWithSize:CGSizeMake(self.shadeView.width - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    _signature.width = signatureSize.width;
    _signature.height = signatureSize.height;
    
    address.textColor = userName.textColor = info.textColor = _signature.textColor = [UIColor whiteColor];
    
    [self.shadeView addSubview:address];
    [self.shadeView addSubview:sixImageView];
    [self.shadeView addSubview:userName];
    [self.shadeView addSubview:info];
    [self.shadeView addSubview:_signature];
    
}


- (void)addLabel {
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    [self addSubview:label];
    _label = label;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = self.bounds;
}


-(void)mainButtonDidSelect:(UIButton *)button {
    //跳转传值未定
    [self.jumpDelegate jumpTOUserDetail:111];
    NSLog(@"点击了中间的图片");
}

-(void)smallImageButtonDidSelect:(UIButton *)button {
    //跳转传值未定
    [self.jumpDelegate jumpToBigImg:@"跳转到大图链接"];
    NSLog(@"点击了中间的图片");
}

@end
