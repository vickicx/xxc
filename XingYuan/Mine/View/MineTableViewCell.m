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
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(12, 0, kWIDTH - 24, 54)];
    background.layer.cornerRadius = 10.0f;
    background.backgroundColor = [UIColor whiteColor];
    [self addSubview:background];
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(30 * FitWidth, 20 * FitHeight, 10, 10)];
    
    [background addSubview:_image];
    
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(self.image.right + 10,0, 100, 54)];
    self.title.font = [UIFont systemFontOfSize:16];
    self.title.textColor = [UIColor colorWithRed:43/255.0 green:48/255.0 blue:52/255.0 alpha:1];
    [background addSubview:_title];
    
    UIImageView *goOn = [[UIImageView alloc] initWithFrame:CGRectMake(kWIDTH - 40, self.image.top, 10, 10)];
    [goOn setImage:[UIImage imageNamed:@"更多内容"]];
    [background addSubview:goOn];
    
    self.line = [[UILabel alloc] initWithFrame:CGRectMake(self.title.left, background.bottom - 1, background.width - self.title.left - 10, 1)];
    [background addSubview:self.line];
    
    
    



}



@end
