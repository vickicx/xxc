//
//  PerfectTableViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/11/6.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PerfectTableViewCell.h"


@interface PerfectTableViewCell()
@property(nonatomic,strong)UILabel *information;
//@property(nonatomic,strong)UILabel * NameLab;
//@property(nonatomic,strong)UILabel * contentLab;
@end

@implementation PerfectTableViewCell


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
        
        _information = [[UILabel alloc] initWithFrame:CGRectMake(dian.right + 10 * FitWidth, 15 * FitHeight, 80*FitWidth, 30*FitHeight)];
        _information.font = FONT_WITH_S(16);
        
        [self addSubview:_information];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12 *FitWidth, 55 * FitHeight, kWIDTH- 24 *FitWidth, 50*FitHeight)];
        label.text = @"尊敬的用户：由于您未完善该项资料，所以无法查看更多，完善后将解锁Ta人此项资料";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT_WITH_S(13);
        label.numberOfLines = 0;
        label.textColor = [UIColor colorWithRed:141/255.0 green:146/255.0 blue:149/255.0 alpha:1];
        // 创建Attributed
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
        // 需要改变的最后一个文字的位置
        NSUInteger secondLoc = [[noteStr string] rangeOfString:@"由"].location;
        // 需要改变的区间
        NSRange range = NSMakeRange(0, secondLoc);
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value: RGBColor(246, 80, 118, 1) range:range];
         [noteStr addAttribute:NSForegroundColorAttributeName value:RGBColor(246, 80, 118, 1) range:NSMakeRange(26, 6)];
        
        // 为label添加Attributed
        [label setAttributedText:noteStr];
        
        [self addSubview:label];
        
        UILabel *kong1 = [[UILabel alloc] initWithFrame:CGRectMake(12*FitWidth, _information.bottom + 10 * FitHeight, kWIDTH - 24 * FitWidth, 1 *FitHeight)];
        kong1.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
        [self addSubview:kong1];
        
        UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        finishBtn.frame = CGRectMake(12 * FitWidth, label.bottom + 20 *FitHeight, kWIDTH - 24 * FitWidth, 40);
        
        [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        finishBtn.backgroundColor = RGBColor(246, 80, 116, 1);
        [finishBtn setTitle:@"完善资料" forState:UIControlStateNormal];
        finishBtn.layer.cornerRadius = 3;
        [finishBtn addTarget:self action:@selector(dealTapFinished:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:finishBtn];
        
        
    }
    return self;
}

- (void)dealTapFinished:(UIButton *)button {
  self.toBlock(button);
}

-(void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
    }
    _information.text = title;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
