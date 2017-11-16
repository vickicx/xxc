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
@property (nonatomic,strong) UILabel *kong1;

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
        dian.frame = CGRectMake(12 * FitWidth, kong.bottom + 17 * FitHeight, 5*FitWidth, 5*FitHeight);
        [dian setImage:[UIImage imageNamed:@"椭圆"]];
        [self addSubview:dian];
        
        UILabel *information = [[UILabel alloc] initWithFrame:CGRectMake(dian.right + 10 * FitWidth, 15 * FitHeight, 80*FitWidth, 30*FitHeight)];
        information.text = @"基本资料";
        information.font = FONT_WITH_S(16);
        
        [self addSubview:information];
        if (self.userId == nil) {
            self.userId = @"123044429";
        }
        UILabel *userid = [[UILabel alloc] initWithFrame:CGRectMake(information.right, 15 * FitHeight, 170*FitWidth, 30*FitHeight)];
        userid.text = [NSString stringWithFormat:@"(%@)",self.userId];
        userid.font = FONT_WITH_S(14);
        userid.textColor = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
        [self addSubview:userid];
        
        _kong1 = [[UILabel alloc] initWithFrame:CGRectMake(12*FitWidth, information.bottom + 10 * FitHeight, kWIDTH - 24 * FitWidth, 1 *FitHeight)];
        _kong1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        [self addSubview:_kong1];
        
        
    }
    return self;
}

-(void)setMatchingLevelOneModel:(OneStageScreeningModel *)matchingLevelOneModel {
    if (_matchingLevelOneModel != matchingLevelOneModel) {
        _matchingLevelOneModel = matchingLevelOneModel;
    }
    
    ShowInformationView *showView = [[ShowInformationView alloc] initWith:CGPointMake(0, _kong1.bottom + 2*FitHeight) width:kWIDTH];
    showView.color = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
    
    _arr = [NSMutableArray arrayWithObjects: matchingLevelOneModel.birthday,matchingLevelOneModel.stature, matchingLevelOneModel.constellation, matchingLevelOneModel.address, matchingLevelOneModel.physique, matchingLevelOneModel.facialfeatures, nil];
    _arr = [NSMutableArray arrayWithObjects: [NSString stringWithFormat:@"%@岁", matchingLevelOneModel.age],matchingLevelOneModel.stature, matchingLevelOneModel.constellation, matchingLevelOneModel.address,[NSString stringWithFormat:@"相貌自评：%@", matchingLevelOneModel.physique], matchingLevelOneModel.facialfeatures, nil];
    NSMutableArray *menuArr = [NSMutableArray array];
    if(matchingLevelOneModel.age){
        for (int index = 0; index < [_arr count]; index ++ ) {
             if (![_arr[index] isEqualToString:@""]) {
            UILabel *menuLabel = [UILabel new];
            menuLabel.textAlignment = NSTextAlignmentCenter;
            menuLabel.backgroundColor = [UIColor colorWithRed:240/255.0 green:241/255.0 blue:241/255.0 alpha:1];
            menuLabel.text = _arr[index];
            menuLabel.font = FONT_WITH_S(13);
            menuLabel.textColor = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
            CGFloat width = [menuLabel widthOfSizeToFit];
            menuLabel.frame = CGRectMake(0, 0, width + 30*FitWidth, 30*FitHeight);
            menuLabel.layer.cornerRadius = 5.0;
            menuLabel.clipsToBounds = YES;
            [menuArr addObject:menuLabel];
             }
        }
    }
    
    showView.dataSource = menuArr;
    int height1 = (showView.i + 1) * 30 * FitHeight;
    NSString *height2 = [NSString stringWithFormat:@"%d",height1];
    
    [self addSubview:showView];
    NSDictionary *dict =[NSDictionary dictionaryWithObject:height2 forKey:@"height"];
    
    NSNotification *notification =[NSNotification notificationWithName:@"CellHeightB" object:nil userInfo:dict];
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}





@end
