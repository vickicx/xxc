//
//  futurePlanningTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "futurePlanningTableViewCell.h"
#import "ShowInformationView.h"

@interface futurePlanningTableViewCell ()

@property (nonatomic,strong) UILabel *kong1;

@end

@implementation futurePlanningTableViewCell

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
        
        UILabel *planning = [[UILabel alloc] initWithFrame:CGRectMake(dian.right + 10 * FitWidth, 15 * FitHeight, 80*FitWidth, 30*FitHeight)];
        planning.text = @"未来规划";
        planning.font = FONT_WITH_S(16);
        [self addSubview:planning];
        
        _kong1 = [[UILabel alloc] initWithFrame:CGRectMake(12, planning.bottom + 10 * FitHeight, kWIDTH - 24 * FitWidth, 1 *FitHeight)];
        _kong1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        [self addSubview:_kong1];
        
    }
    return self;
}

-(void)setMatchingLevelFiveModel:(FiveStageScreeningModel *)matchingLevelFiveModel {
    if (_matchingLevelFiveModel != matchingLevelFiveModel) {
        _matchingLevelFiveModel = matchingLevelFiveModel;
    }
    
    ShowInformationView *showView = [[ShowInformationView alloc] initWith:CGPointMake(0, _kong1.bottom + 2*FitHeight) width:kWIDTH];
    //showView.color = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
    NSArray *arr = [NSArray arrayWithObjects: matchingLevelFiveModel.getmarriedtime, matchingLevelFiveModel.datingpattern, matchingLevelFiveModel.hopeotherlike, matchingLevelFiveModel.weddingform, matchingLevelFiveModel.livingwithbothparents, matchingLevelFiveModel.wanthavechildren, matchingLevelFiveModel.cookingskill, matchingLevelFiveModel.householdduties, nil];
    NSMutableArray *menuArr = [NSMutableArray array];
    for (int index = 0; index < [arr count]; index ++ ) {
        
        UILabel *menuLabel = [UILabel new];
        menuLabel.textAlignment = NSTextAlignmentCenter;
        menuLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:239/255.0 blue:243/255.0 alpha:1];
        menuLabel.text = arr[index];
        menuLabel.font = FONT_WITH_S(13);
        menuLabel.textColor = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
        CGFloat width = [menuLabel widthOfSizeToFit];
        menuLabel.frame = CGRectMake(0, 0, width + 30*FitWidth, 30*FitHeight);
        menuLabel.layer.cornerRadius = 5.0;
        menuLabel.clipsToBounds = YES;
        [menuArr addObject:menuLabel];
    }
    showView.dataSource = menuArr;
    int height1 = (showView.i + 1) * 30 * FitHeight;
    NSString *height2 = [NSString stringWithFormat:@"%d",height1];
    
    
    [self addSubview:showView];
    NSDictionary *dict =[NSDictionary dictionaryWithObject:height2 forKey:@"height"];
    
    NSNotification *notification =[NSNotification notificationWithName:@"CellHeightFu" object:nil userInfo:dict];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    

    
}


@end
