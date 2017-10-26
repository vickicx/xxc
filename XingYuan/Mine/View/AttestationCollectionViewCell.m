//
//  AttestationCollectionViewCell.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/14.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "AttestationCollectionViewCell.h"

@interface AttestationCollectionViewCell ()
@end

@implementation AttestationCollectionViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(void)setNum:(int)num {
    if (_num != num) {
        _num = num;
    }
    UIView *view = [[UIView alloc] initWithFrame:_Img.frame];
    view.layer.cornerRadius = 25.0f;
    view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:0.6];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.width, view.height)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    [view addSubview:label];

    if (_num == 2) {
        [view setHidden:YES];
    }else {
        [view setHidden:NO];
        if (_num == 1) {
            label.text = @"审核中";
        }else if(_num == 3) {
            label.text = @"未通过";
        }
        [self addSubview:view];
    }
}

@end
