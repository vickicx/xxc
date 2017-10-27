//
//  PickerView.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/14.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PickerView.h"

@interface PickerView ()
@property (nonatomic,weak) UIButton *cancelBtn;
@property (nonatomic,weak) UIButton *okBtn;
@end
@implementation PickerView

- (instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        
        UIPickerView *pickerView = [[UIPickerView alloc] init];
        pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:pickerView];
        [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(260*FitHeight);
        }];
        self.pickerView = pickerView;
        
        UIView *toolsContainView = [[UIView alloc] init];
        toolsContainView.backgroundColor = [UIColor whiteColor
                                            ];
        [self addSubview:toolsContainView];
        [toolsContainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.pickerView);
            make.right.equalTo(self.pickerView);
            make.bottom.equalTo(self.pickerView.mas_top);
            make.height.mas_equalTo(40*FitHeight);
        }];
        
        UIView *topCoverView = [[UIView alloc] init];
        topCoverView.backgroundColor = RGBColor(150, 150, 150, 0.2);
        [self addSubview:topCoverView];
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toDismiss)];
        [topCoverView addGestureRecognizer:tapG];
        [topCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(toolsContainView.mas_top);
            make.top.equalTo(self);
        }];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:RGBColor(10, 96, 254, 1) forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(dealCancel) forControlEvents:UIControlEventTouchUpInside];
        [toolsContainView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(toolsContainView);
            make.top.equalTo(toolsContainView);
            make.bottom.equalTo(toolsContainView);
            make.width.mas_equalTo(50*FitWidth);
        }];
        self.cancelBtn = cancelBtn;
        
        UIButton *okBtn = [[UIButton alloc] init];
        [okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [okBtn setTitleColor:RGBColor(10, 96, 254, 1) forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(dealOK) forControlEvents:UIControlEventTouchUpInside];
        [toolsContainView addSubview:okBtn];
        [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(toolsContainView);
            make.top.equalTo(toolsContainView);
            make.bottom.equalTo(toolsContainView);
            make.width.mas_equalTo(50*FitWidth);
        }];
        self.okBtn = okBtn;
        
        
        UIView *toolContianViewTopSeparateLine = [[UIView alloc] init];
        toolContianViewTopSeparateLine.backgroundColor = RGBColor(184, 186, 189, 1);
        [toolsContainView addSubview:toolContianViewTopSeparateLine];
        [toolContianViewTopSeparateLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(toolsContainView);
            make.left.equalTo(toolsContainView);
            make.right.equalTo(toolsContainView);
            make.height.mas_equalTo(0.5*FitHeight);
        }];
        
        UIView *toolContianViewBottomSeparateLine = [[UIView alloc] init];
        toolContianViewBottomSeparateLine.backgroundColor = RGBColor(184, 186, 189, 1);
        [toolsContainView addSubview:toolContianViewBottomSeparateLine];
        [toolContianViewBottomSeparateLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(toolsContainView);
            make.left.equalTo(toolsContainView);
            make.right.equalTo(toolsContainView);
            make.height.mas_equalTo(0.5*FitHeight);
        }];
    }
    return self;
}

- (void)dealCancel{
    NSLog(@"点击了取消");
}


- (void)dealOK{
    NSLog(@"点击了OK");
}

//展示
- (void)toShow{
    
}

//隐藏
- (void)toDismiss{
    [self removeFromSuperview];
}


@end
