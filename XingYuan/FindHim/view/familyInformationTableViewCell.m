//
//  familyInformationTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "familyInformationTableViewCell.h"
#import "ShowInformationView.h"

@interface familyInformationTableViewCell ()
@property (nonatomic,strong) UILabel *kong1;
@end

@implementation familyInformationTableViewCell

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
        
        UILabel *family = [[UILabel alloc] initWithFrame:CGRectMake(dian.right + 10 * FitWidth, 15 * FitHeight, 80*FitWidth, 30*FitHeight)];
        family.text = @"家庭情况";
        family.font = FONT_WITH_S(16);
        [self addSubview:family];
        
        _kong1 = [[UILabel alloc] initWithFrame:CGRectMake(12*FitWidth, family.bottom + 10 * FitHeight, kWIDTH - 24 * FitWidth, 1 *FitHeight)];
        _kong1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        [self addSubview:_kong1];
        
            }
    return self;
}


-(void)setMatchingLevelFourModel:(FourStageScreeningModel *)matchingLevelFourModel {
    if (_matchingLevelFourModel != matchingLevelFourModel) {
        _matchingLevelFourModel = matchingLevelFourModel;
    }
    
    ShowInformationView *showView = [[ShowInformationView alloc] initWith:CGPointMake(0, _kong1.bottom + 2*FitHeight) width:kWIDTH];
    //showView.color = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects: [NSString stringWithFormat:@"家乡:%@", _matchingLevelFourModel.hometown], [NSString stringWithFormat:@"民族:%@", _matchingLevelFourModel.nation], [NSString stringWithFormat:@"生肖:%@", _matchingLevelFourModel.sx], _matchingLevelFourModel.familyranking, _matchingLevelFourModel.parentstatus, _matchingLevelFourModel.fatherwork, _matchingLevelFourModel.motherwork, _matchingLevelFourModel.parenteconomic, _matchingLevelFourModel.parentmedicalinsurance, nil];
    NSMutableArray *menuArr = [NSMutableArray array];
    for (int index = 0; index < [arr count]; index ++ ) {
        
        UILabel *menuLabel = [UILabel new];
        menuLabel.textAlignment = NSTextAlignmentCenter;
        menuLabel.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:241/255.0 alpha:1];
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
    int height1 = (showView.i + 1) * 30;
    NSString *height2 = [NSString stringWithFormat:@"%d",height1];
    NSLog(@"~~~~~~!!!!%@",height2);
    
    [self addSubview:showView];
    NSDictionary *dict =[NSDictionary dictionaryWithObject:height2 forKey:@"height"];
    
    NSNotification *notification =[NSNotification notificationWithName:@"CellHeightFa" object:nil userInfo:dict];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

@end
