//
//  futurePlanningTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "futurePlanningTableViewCell.h"
#import "ShowInformationView.h"

@implementation futurePlanningTableViewCell

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
        
        UILabel *planning = [[UILabel alloc] initWithFrame:CGRectMake(dian.right + 10 * FitWidth, 15 * FitHeight, 70, 30)];
        planning.text = @"未来规划";
        planning.font = [UIFont systemFontOfSize:16];
        [self addSubview:planning];
        
        UILabel *kong1 = [[UILabel alloc] initWithFrame:CGRectMake(12, planning.bottom + 10 * FitHeight, kWIDTH - 24 * FitWidth, 1 *FitHeight)];
        kong1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        [self addSubview:kong1];
        
        
        
        ShowInformationView *showView = [[ShowInformationView alloc] initWith:CGPointMake(0, kong1.bottom + 2) width:kWIDTH];
        //showView.color = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
        NSArray *arr = [NSArray arrayWithObjects:@"111111",@"222",@"3111",@"222444",@"11551111",@"22",@"1111555555511",@"226662",@"111111",@"222", nil];
        NSMutableArray *menuArr = [NSMutableArray array];
        for (int index = 0; index < [arr count]; index ++ ) {
            
            UILabel *menuLabel = [UILabel new];
            menuLabel.textAlignment = NSTextAlignmentCenter;
            menuLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:239/255.0 blue:243/255.0 alpha:1];
            menuLabel.text = arr[index];
            menuLabel.font = [UIFont systemFontOfSize:13];
            menuLabel.textColor = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
            CGFloat width = [menuLabel widthOfSizeToFit];
            menuLabel.frame = CGRectMake(0, 0, width + 15 + 15, 30);
            menuLabel.layer.cornerRadius = 5.0;
            menuLabel.clipsToBounds = YES;
            [menuArr addObject:menuLabel];
        }
        showView.dataSource = menuArr;
        int height1 = (showView.i + 1) * 30;
        NSString *height2 = [NSString stringWithFormat:@"%d",height1];
        
        
        [self addSubview:showView];
        NSDictionary *dict =[NSDictionary dictionaryWithObject:height2 forKey:@"height"];
        
        NSNotification *notification =[NSNotification notificationWithName:@"CellHeightFu" object:nil userInfo:dict];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        

        
    }
    return self;
}


@end
