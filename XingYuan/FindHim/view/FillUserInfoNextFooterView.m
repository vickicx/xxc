//
//  FillUserInfoNextFooterView.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/13.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "FillUserInfoNextFooterView.h"

@interface FillUserInfoNextFooterView ()
@property (nonatomic,weak) UIButton *nextBtn;
@end
@implementation FillUserInfoNextFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:nextBtn];
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [nextBtn setBackgroundColor:RGBColor(246, 80, 116, 1)];
        nextBtn.layer.cornerRadius = 3;
        nextBtn.clipsToBounds = true;
        [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(50*FitHeight);
            make.left.equalTo(self).offset(15*FitWidth);
            make.height.mas_equalTo(48);
        }];
        [nextBtn addTarget:self action:@selector(dealTap) forControlEvents:UIControlEventTouchUpInside];
        self.nextBtn = nextBtn;
    }
    return self;
}

- (void)dealTap{
    self.tapNextBlock();
}
@end
