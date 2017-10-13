//
//  HeightPickerView.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/12.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "HeightPickerView.h"

@interface HeightPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *topCoverView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *heightPickerView;

@property (weak, nonatomic) IBOutlet UIView *heightPickerViewContainView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightPickerContainViewConstraint;

@property (nonatomic,strong) NSArray *dataArray;
@end
@implementation HeightPickerView

+ (instancetype)heightPickerView{
    return [[NSBundle mainBundle] loadNibNamed:@"HeightPickerView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(toHidden)];
    
    self.heightPickerView.delegate = self;
    self.heightPickerView.dataSource = self;
    
    NSMutableArray *dataArray = [NSMutableArray new];
    [dataArray addObject:@"140以下"];
    for (int i=140;i<=230;i++){
        [dataArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [dataArray addObject:@"230以上"];
    self.dataArray = dataArray;
    [self.topCoverView addGestureRecognizer:tapGesture];
    
    [self.heightPickerView selectRow:170 inComponent:0 animated:false];
}

- (IBAction)dealTapCancel:(id)sender {
    [self toHidden];
}

- (IBAction)dealTapOK:(id)sender {
    self.heightPickerBlock(self.dataArray[[self.heightPickerView selectedRowInComponent:0]]);
    [self toHidden];
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    [self toShow];
}

- (void)toHidden{
    //    [UIView animateWithDuration:1 animations:^{
    //        self.datePickerContainViewConstraint.constant = -260;
    //        for (int i=0;i<self.subviews.count;i++){
    //            [self.subviews[i] layoutIfNeeded];
    //        }
    //    } completion:^(BOOL finished) {
    [self removeFromSuperview];
    //    }];
}

- (void)toShow{
    //    [UIView animateWithDuration:1 animations:^{
    //        self.datePickerContainViewConstraint.constant = 0;
    //        for (int i=0;i<self.subviews.count;i++){
    //            [self.subviews[i] layoutIfNeeded];
    //        }
    //    }];
}

// MARK: - UIPickerViewDelegate、UIPickerViewDataSource
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

- (void)dealloc{
    
}


@end
