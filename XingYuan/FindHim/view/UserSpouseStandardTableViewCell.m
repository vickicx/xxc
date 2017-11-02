//
//  UserSpouseStandardTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "UserSpouseStandardTableViewCell.h"
#import "ShowInformationView.h"

@interface UserSpouseStandardTableViewCell()
@property (nonatomic,strong) UILabel *kong;
@end

@implementation UserSpouseStandardTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _kong = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 10 *FitHeight)];
        _kong.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
        [self addSubview:_kong];
        
    }
    return self;
}

-(void)setArr:(NSMutableArray *)arr {
    if (_arr != arr) {
        _arr = arr;
    }
    
    ShowInformationView *showView = [[ShowInformationView alloc] initWith:CGPointMake(0, _kong.bottom + 2*FitHeight) width:kWIDTH];
    //showView.color = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
    NSMutableArray *menuArr = [NSMutableArray array];
    for (int index = 0; index < [arr count]; index ++ ) {
        if (![arr[index] isEqualToString:@""]) {
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

    }
    showView.dataSource = menuArr;
    [self addSubview:showView];
    
    

}

@end
