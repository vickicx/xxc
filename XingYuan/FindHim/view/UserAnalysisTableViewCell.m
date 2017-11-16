//
//  UserAnalysisTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "UserAnalysisTableViewCell.h"
#import "JYRadarChart.h"
#import "HXCircleChart.h"


@interface UserAnalysisTableViewCell ()


@end


@implementation UserAnalysisTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        UILabel *kong = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 10 *FitHeight)];
        kong.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
        [self addSubview:kong];
        
        UIImageView *dian = [[UIImageView alloc] init];
        dian.frame = CGRectMake(12 * FitWidth, kong.bottom + 17 * FitHeight, 5*FitWidth, 5*FitHeight);
        [dian setImage:[UIImage imageNamed:@"椭圆"]];
        [self addSubview:dian];
        
        UILabel *analysis = [[UILabel alloc] initWithFrame:CGRectMake(dian.right + 10 * FitWidth, 15 * FitHeight, 80*FitWidth, 30*FitHeight)];
        analysis.text = @"各项分析";
        analysis.font = FONT_WITH_S(16);
        [self addSubview:analysis];
        
        UILabel *kong1 = [[UILabel alloc] initWithFrame:CGRectMake(12*FitWidth, analysis.bottom + 10 * FitHeight, kWIDTH - 24 * FitWidth, 1 *FitHeight)];
        kong1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        [self addSubview:kong1];
        
        JYRadarChart *p = [[JYRadarChart alloc] initWithFrame:CGRectMake(30, 65, 170, 150)];
        
        NSArray *a1 = @[@(81), @(97), @(87), @(60), @(65), @(77)];
        
        p.dataSeries = @[a1];
        p.steps = 4;
        p.showStepText = NO;
        p.r = 60;
        p.minValue = 20;
        p.maxValue = 120;
        p.fillArea = YES;
        p.colorOpacity = 0.7;
        p.attributes = @[@"其他", @"信用度", @"活跃度", @"魅力值", @"其他", @"其他"];
        p.showLegend = YES;
        p.backgroundLineColor = [UIColor colorWithRed:219/255.0 green:217/255.0 blue:217/255.0 alpha:1];
        [p setColors:@[[UIColor colorWithRed:231/255.0 green:245/255.0 blue:253/255.0 alpha:1]]];
        [self addSubview:p];
        
        HXCircleChart *circle = [[HXCircleChart alloc] initWithFrame:CGRectMake(p.right , p.top, 150*FitWidth, 150*FitHeight) withMaxValue:100 value:85];
        
        
        circle.valueColor = [self colorWithHexString:@"#f65076" alpha:1];
        circle.valueTitle = @"85%";
        
        circle.insideCircleColor = [self colorWithHexString:@"#d1d1d1" alpha:1];
        
        circle.colorArray = @[[self colorWithHexString:@"#f7b5c4" alpha:1],[self colorWithHexString:@"#f65076" alpha:1]];
        
        circle.locations = @[@0.15,@0.85];
        
        [self addSubview:circle];
        
    }
    return self;
}



#pragma mark 设置16进制颜色
- (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}






@end
