//
//  PersonalCircumstancesTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PersonalCircumstancesTableViewCell.h"
#import "ShowInformationView.h"

@interface PersonalCircumstancesTableViewCell()
@property (nonatomic,strong) ShowInformationView *showView;
@property (nonatomic,strong) UILabel *kong1;

@end

@implementation PersonalCircumstancesTableViewCell


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
        
        UILabel *introduction = [[UILabel alloc] initWithFrame:CGRectMake(dian.right + 10 * FitWidth, 15 * FitHeight, 70, 30)];
        introduction.text = @"个人情况";
        introduction.font = [UIFont systemFontOfSize:16];
        [self addSubview:introduction];
        
        _kong1 = [[UILabel alloc] initWithFrame:CGRectMake(12, introduction.bottom + 10 * FitHeight, kWIDTH - 24 * FitWidth, 1 *FitHeight)];
        _kong1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        [self addSubview:_kong1];
        
       
       // showView.color = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
       
        

        
    }
    return self;
}

-(void)setMatchingLevelTwoModel:(TwoStateScreeningModel *)matchingLevelTwoModel {
    if (_matchingLevelTwoModel != matchingLevelTwoModel) {
        _matchingLevelTwoModel = matchingLevelTwoModel;
    }
    ShowInformationView *showView = [[ShowInformationView alloc] initWith:CGPointMake(0, _kong1.bottom + 2) width:kWIDTH];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects: _matchingLevelTwoModel.operatingpost, _matchingLevelTwoModel.maritalstatus, _matchingLevelTwoModel.drink, _matchingLevelTwoModel.smoking, _matchingLevelTwoModel.monthlyincome, _matchingLevelTwoModel.educational, _matchingLevelTwoModel.workandrest, _matchingLevelTwoModel.housesstatus, _matchingLevelTwoModel.carstatus, _matchingLevelTwoModel.children, nil];
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
    
    NSLog(@"yuiyiuyiuyiuyuiyiu%d",showView.i);
    int height1 = (showView.i + 1) * 40;
    NSString *height2 = [NSString stringWithFormat:@"%d",height1];
    
    
    [self addSubview:showView];
    NSDictionary *dict =[NSDictionary dictionaryWithObject:height2 forKey:@"height"];
    
    NSNotification *notification =[NSNotification notificationWithName:@"CellHeightP" object:nil userInfo:dict];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
}




@end
