//
//  UserSpouseStandardTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "UserSpouseStandardTableViewCell.h"
#import "ShowInformationView.h"

@implementation UserSpouseStandardTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *kong = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 10 *FitHeight)];
        kong.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
        [self addSubview:kong];
        
        ShowInformationView *showView = [[ShowInformationView alloc] initWith:CGPointMake(0, kong.bottom + 2) width:kWIDTH];
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
        [self addSubview:showView];
        
        
        
    }
    return self;
}
@end
