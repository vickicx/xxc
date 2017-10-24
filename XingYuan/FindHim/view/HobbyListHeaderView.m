//
//  HobbyListHeaderView.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "HobbyListHeaderView.h"
@interface HobbyListHeaderView ()
@property (nonatomic,weak) UIView *redPoint;
@property (nonatomic,weak) UILabel *titleLabel;
@end
@implementation HobbyListHeaderView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title{
    self = [self initWithFrame:frame];
    if(self){
        self.titleLabel.text = title;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        UIView *readPoint = [[UIView alloc] init];
        [self addSubview:readPoint];
        self.redPoint = readPoint;
        self.redPoint.backgroundColor = RGBColor(240, 53, 99, 1);
        self.redPoint.layer.cornerRadius = 3;
        self.redPoint.clipsToBounds = true;
        [self.redPoint mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(6);
            make.width.mas_equalTo(6);
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(-21);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.redPoint.mas_right).offset(15);
        }];
        
        UIView *seprateLine = [[UIView alloc] init];
        seprateLine.backgroundColor = RGBColor(231, 231, 231, 1);
        [self addSubview:seprateLine];
        [seprateLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(@0.5);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}
@end
