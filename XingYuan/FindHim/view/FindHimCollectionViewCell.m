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
        [self createLabels];
        
    }
    return self;
}

- (void)createView {
    _mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _mainButton.frame = CGRectMake(0, 0, self.width, 362 * FitHeight);
    _mainButton.backgroundColor = [UIColor whiteColor];
    [_mainButton setBackgroundImage:[UIImage imageNamed:@"照片"] forState:UIControlStateNormal];
    [_mainButton addTarget:self action:@selector(mainButtonDidSelect:) forControlEvents:UIControlEventTouchUpInside];
    UIView *shadeView = [[UIView alloc] initWithFrame:CGRectMake(_mainButton.left, _mainButton.top, _mainButton.width, _mainButton.height)];
    shadeView.backgroundColor = RGBColor(0, 0, 0, 0.5);
    self.shadeView = shadeView;
    [_mainButton addSubview:_shadeView];

    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame = CGRectMake(10 * FitWidth, _mainButton.bottom + 10 * FitHeight , (_mainButton.width - 26*FitWidth) / 3, (_mainButton.width - 26*FitWidth) / 3);
    _leftButton.backgroundColor = [UIColor whiteColor];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"照片"] forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(LsmallImageButtonDidSelect:) forControlEvents:UIControlEventTouchUpInside];
    _middleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _middleButton.frame = CGRectMake(_leftButton.right + 3 *FitWidth, _leftButton.top, _leftButton.width, _leftButton.height);
    _middleButton.backgroundColor = [UIColor whiteColor];
    [_middleButton setBackgroundImage:[UIImage imageNamed:@"照片"] forState:UIControlStateNormal];
    [_middleButton addTarget:self action:@selector(MsmallImageButtonDidSelect:) forControlEvents:UIControlEventTouchUpInside];
    _righButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _righButton.frame = CGRectMake(_middleButton.right + 3 *FitWidth, _leftButton.top, _leftButton.width, _leftButton.height);
    _righButton.backgroundColor = [UIColor whiteColor];
    [_righButton setBackgroundImage:[UIImage imageNamed:@"照片"] forState:UIControlStateNormal];
    [_righButton addTarget:self action:@selector(RsmallImageButtonDidSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_mainButton];
    [self addSubview:_leftButton];
    [self addSubview:_middleButton];
    [self addSubview:_righButton];
   
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)createLabels {
    _address = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 200*FitWidth, 10*FitHeight, 180*FitWidth, 20*FitHeight)];
    _userName = [[UILabel alloc] initWithFrame:CGRectMake(15*FitWidth, self.shadeView.height - 100*FitHeight, 0, 20*FitHeight)];
    
    _address.text = @"成都(3km)";
    _address.textAlignment = NSTextAlignmentRight;
    _address.font = FONT_WITH_S(12);
    
//    _userName.text = @"dwefewfwe";
    _userName.font = FONT_WITH_S(15);
    CGSize userNameSize = [_userName.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_userName.font,NSFontAttributeName,nil]];
    _userName.width = userNameSize.width ;
    _userName.height = userNameSize.height;
    
    _sixImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_userName.right + 3*FitWidth, _userName.top, 20*FitWidth, 20*FitHeight)];
    [_sixImageView setImage:[UIImage imageNamed:@"six_girl"]];
    
    _info = [[UILabel alloc] initWithFrame:CGRectMake(15*FitWidth, self.shadeView.height - 70*FitHeight, self.shadeView.width - 24*FitWidth, 20*FitHeight)];
    self.signature = [[UILabel alloc] initWithFrame:CGRectMake(15*FitWidth, _info.bottom + 10*FitHeight, self.shadeView.width - 24*FitWidth, 40*FitHeight)];

    _info.text = @"24岁 | 166cm | 射手座 | 服装设计";
    _info.font = FONT_WITH_S(12);
//    CGSize infoSize = [_info.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_info.font,NSFontAttributeName,nil]];
//    _info.width = infoSize.width;
//    _info.height = infoSize.height;
    
    _signature.text = @"这里是交友的一个签名什么的~";
    _signature.font = FONT_WITH_S(12);
    _signature.numberOfLines = 0;
     CGSize signatureSize = [_signature.text boundingRectWithSize:CGSizeMake(self.shadeView.width - 20*FitWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    _signature.width = signatureSize.width;
    _signature.height = signatureSize.height;
    
    _address.textColor = _userName.textColor = _info.textColor = _signature.textColor = [UIColor whiteColor];
    
    [self.shadeView addSubview:_address];
    [self.shadeView addSubview:_sixImageView];
    [self.shadeView addSubview:_userName];
    [self.shadeView addSubview:_info];
    [self.shadeView addSubview:_signature];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(_mainButton.left, _mainButton.top, _mainButton.width, _mainButton.height)];
    view.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mainButtonDidSelect:)];
    [view addGestureRecognizer:tapGesturRecognizer];
    [self.shadeView addSubview:view];
    
}




- (void)layoutSubviews {
    [super layoutSubviews];
    
}


-(void)mainButtonDidSelect:(UIButton *)button {
    [self.jumpDelegate jumpTOUserDetail:self.index];
    NSLog(@"点击了中间的图片");
}

-(void)LsmallImageButtonDidSelect:(UIButton *)button {
    //跳转传值未定
    [self.jumpDelegate jumpToBigImg:@"2" index:self.index];
    
}
-(void)MsmallImageButtonDidSelect:(UIButton *)button {
    //跳转传值未定
    [self.jumpDelegate jumpToBigImg:@"3" index:self.index];
    
}
-(void)RsmallImageButtonDidSelect:(UIButton *)button {
    //跳转传值未定
   [self.jumpDelegate jumpToBigImg:@"4" index:self.index];
    
}

@end
