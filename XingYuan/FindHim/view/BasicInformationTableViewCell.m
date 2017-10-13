//
//  BasicInformationTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BasicInformationTableViewCell.h"
#import "ShowInformationView.h"

@interface BasicInformationTableViewCell()
@property (nonatomic,copy) NSString *userId;
@end

@implementation BasicInformationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *kong = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 10 *FitHeight)];
        kong.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
        [self addSubview:kong];
        
        UIImageView *dian = [[UIImageView alloc] init];
        dian.frame = CGRectMake(12 * FitWidth, kong.bottom + 17 * FitHeight, 5, 5);
        [dian setImage:[UIImage imageNamed:@"椭圆"]];
        [self addSubview:dian];
        
        UILabel *information = [[UILabel alloc] initWithFrame:CGRectMake(dian.right + 10 * FitWidth, 15 * FitHeight, 70, 30)];
        information.text = @"基本资料";
        information.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:information];
        if (self.userId == nil) {
            self.userId = @"123044429";
        }
        UILabel *userid = [[UILabel alloc] initWithFrame:CGRectMake(information.right, 15 * FitHeight, 170, 30)];
        userid.text = [NSString stringWithFormat:@"(%@)",self.userId];
        userid.font = [UIFont systemFontOfSize:14];
        userid.textColor = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
        [self addSubview:userid];
        
        
        UILabel *kong1 = [[UILabel alloc] initWithFrame:CGRectMake(12, information.bottom + 10 * FitHeight, kWIDTH - 24 * FitWidth, 1 *FitHeight)];
        kong1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        [self addSubview:kong1];
        
        
        ShowInformationView *showView = [[ShowInformationView alloc] initWith:CGPointMake(0, kong1.bottom + 2) width:kWIDTH];
        showView.color = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
        NSArray *arr = [NSArray arrayWithObjects:@"111111",@"222",@"3111",@"222444",@"11551111",@"22",@"1111555555511",@"226662",@"111111",@"222", nil];
        NSMutableArray *menuArr = [NSMutableArray array];
        for (int index = 0; index < [arr count]; index ++ ) {
            
            UILabel *menuLabel = [UILabel new];
            menuLabel.textAlignment = NSTextAlignmentCenter;
            menuLabel.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:241/255.0 alpha:1];
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
        
        NSNotification *notification =[NSNotification notificationWithName:@"CellHeightB" object:nil userInfo:dict];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        
        
    }
    return self;
}



@end
