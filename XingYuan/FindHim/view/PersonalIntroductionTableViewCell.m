//
//  PersonalIntroductionTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PersonalIntroductionTableViewCell.h"

@implementation PersonalIntroductionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *kong = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 10 *FitHeight)];
        kong.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
        [self addSubview:kong];
        
        UIImageView *dian = [[UIImageView alloc] init];
        dian.frame = CGRectMake(12 * FitWidth, kong.bottom + 17 * FitHeight, 5, 5);
        [dian setImage:[UIImage imageNamed:@"椭圆"]];
        [self addSubview:dian];
        
        UILabel *introduction = [[UILabel alloc] initWithFrame:CGRectMake(dian.right + 10 * FitWidth, 15 * FitHeight, 80*FitWidth, 30*FitHeight)];
        introduction.text = @"个人介绍";
        introduction.font = [UIFont systemFontOfSize:16];
        [self addSubview:introduction];
        
        UILabel *kong1 = [[UILabel alloc] initWithFrame:CGRectMake(12, introduction.bottom + 10 * FitHeight, kWIDTH - 24 * FitWidth, 1 *FitHeight)];
        kong1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        [self addSubview:kong1];
        
        _summary = [[UILabel alloc] initWithFrame:CGRectMake(30, kong1.bottom + 15 * FitHeight, kWIDTH - 24 * FitWidth, 1 *FitHeight)];
        _summary.font = [UIFont systemFontOfSize:14];
        _summary.textColor = RGBColor(141, 146, 149, 1);
        _summary.numberOfLines = 0;
    
        [self addSubview:_summary];
        
    }
    return self;
}


@end
