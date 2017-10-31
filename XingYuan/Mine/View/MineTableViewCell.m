//
//  MineTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/11.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MineTableViewCell.h"
@interface MineTableViewCell()



@end
@implementation MineTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self createView];

    }
    return self;
}

-(void)createView {
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(12*FitWidth, 0, kWIDTH - 24*FitWidth, 54*FitHeight)];
    background.layer.cornerRadius = 10.0f;
    background.backgroundColor = [UIColor whiteColor];
    [self addSubview:background];
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(30 * FitWidth, 20 * FitHeight, 10*FitWidth, 10*FitHeight)];
    
    [background addSubview:_image];
    
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(self.image.right + 10*FitWidth,0, 100*FitWidth, 54*FitHeight)];
    self.title.font = FONT_WITH_S(16);
    self.title.textColor = [UIColor colorWithRed:43/255.0 green:48/255.0 blue:52/255.0 alpha:1];
    [background addSubview:_title];
    
    UIImageView *goOn = [[UIImageView alloc] initWithFrame:CGRectMake(kWIDTH - 40*FitWidth, self.image.top, 10*FitWidth, 10*FitHeight)];
    [goOn setImage:[UIImage imageNamed:@"更多内容"]];
    [background addSubview:goOn];
    
    self.line = [[UILabel alloc] initWithFrame:CGRectMake(self.title.left, background.bottom - 1*FitHeight, background.width - self.title.left - 10*FitWidth, 1*FitHeight)];
    [background addSubview:self.line];
    
    
    



}



@end
