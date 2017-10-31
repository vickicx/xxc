//
//  UserHomePagePopView.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/9.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "UserHomePagePopView.h"
@interface UserHomePagePopView()
@property(nonatomic,strong)UIImageView * imageView;
@property(nonatomic,strong)UILabel * NameLab;
@property(nonatomic,strong)UILabel * contentLab;
@end

@implementation UserHomePagePopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (self=[super initWithFrame:frame]) {
            self.backgroundColor=[UIColor clearColor];
            self.imageView=[[UIImageView alloc]init];
            self.imageView.frame=CGRectMake((frame.size.width-100)/2, 30*FitHeight, 70*FitWidth, 70*FitHeight);
            self.imageView.layer.masksToBounds=YES;
            self.imageView.layer.cornerRadius=35;
            [self addSubview:self.imageView];
            
            self.NameLab=[[UILabel alloc]init];
            self.NameLab.textAlignment=NSTextAlignmentCenter;
            self.NameLab.textColor=[UIColor whiteColor];
            self.NameLab.font=FONT_WITH_S(16);
            [self addSubview:self.NameLab];
            
            self.contentLab=[[UILabel alloc]init];
            self.contentLab.textAlignment=NSTextAlignmentCenter;
            self.contentLab.textColor=[UIColor whiteColor];
            self.contentLab.font=FONT_WITH_S(12);
            self.contentLab.numberOfLines=0;
            [self addSubview:self.contentLab];
        }

    }
    return self;
}


@end
