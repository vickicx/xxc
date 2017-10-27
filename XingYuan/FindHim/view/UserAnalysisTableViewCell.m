//
//  UserAnalysisTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "UserAnalysisTableViewCell.h"
#import "JYRadarChart.h"
#import "GradualColor_View.h"

@interface UserAnalysisTableViewCell ()

@property (nonatomic, weak) GradualColor_View *gradualView;

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
        analysis.font = [UIFont systemFontOfSize:16];
        [self addSubview:analysis];
        
        UILabel *kong1 = [[UILabel alloc] initWithFrame:CGRectMake(12*FitWidth, analysis.bottom + 10 * FitHeight, kWIDTH - 24 * FitWidth, 1 *FitHeight)];
        kong1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        [self addSubview:kong1];
        
        JYRadarChart *p = [[JYRadarChart alloc] initWithFrame:CGRectMake(30, 65, 150, 150)];
        
        NSArray *a1 = @[@(81), @(97), @(87), @(60), @(65), @(77)];
        
        p.dataSeries = @[a1];
        p.steps = 4;
        p.showStepText = NO;
        p.backgroundColor = [UIColor redColor];
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

        GradualColor_View *gradualView = ({
            GradualColor_View *view = [[GradualColor_View alloc] initWithFrame:(CGRectMake(p.right + 50*FitWidth, p.top, 100*FitWidth, 100*FitHeight))];
            view.backgroundColor = [UIColor whiteColor];
            [self addSubview:view];
            view;
        });

        self.gradualView = gradualView;
        UIButton *starBtn = ({
            UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
            button.frame = CGRectMake(gradualView.left,gradualView.bottom+20*FitHeight, 80*FitWidth, 40*FitHeight);
            [button setTitle:@"START" forState:(UIControlStateNormal)];
            [button addTarget:self action:@selector(animationStartAction) forControlEvents:(UIControlEventTouchUpInside)];
            button;
        });
        [self addSubview:starBtn];
        

       
        
        
        
        
    }
    return self;
}

- (void)animationStartAction {
    [self.gradualView setPercet:90 withTimer:1.8f];
}





@end
