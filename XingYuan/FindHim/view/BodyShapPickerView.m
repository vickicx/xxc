//
//  BodyShapPickerView.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/14.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BodyShapPickerView.h"

@interface BodyShapPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation BodyShapPickerView

+ (instancetype)bodyShapPickerView{
    BodyShapPickerView *bodyPickerView = [[BodyShapPickerView alloc] initWithFrame:SCREEN_RECT];
    return bodyPickerView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        self.dataArray = @[@"很瘦",@"较瘦",@"苗条",@"均匀",@"高挑",@"丰满",@"健壮",@"较胖",@"胖"];
        self.pickerView.delegate = self;
    }
    return self;
}

- (void)dealCancel{
    [super dealCancel];
    [self toDismiss];
}

- (void)dealOK{
    [super dealOK];
    if(self.bodyPickerBlock != nil){
        self.bodyPickerBlock(self.dataArray[[self.pickerView selectedRowInComponent:0]]);
    }
    [self toDismiss];
}

- (void)toDismiss{
    [self removeFromSuperview];
}

- (void)toShow{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

#pragma mark --UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}
@end
