//
//  DatePickerView.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/12.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "DatePickerView.h"

@interface DatePickerView()
@property (weak, nonatomic) IBOutlet UIView *topCoverView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UIView *datePickerContainView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *datePickerContainViewConstraint;
@end

@implementation DatePickerView
+ (instancetype)datePickerView{
    return [[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:self action:@selector(toHidden)];
    [self.topCoverView addGestureRecognizer:tapGesture];
    [self.datePicker setMinimumDate:[NSDate dateWithTimeIntervalSinceNow:-80*365*24*60*60]];
    [self.datePicker setMaximumDate:[NSDate dateWithTimeIntervalSinceNow:-18*365*24*60*60]];
}

- (IBAction)dealTapCancel:(id)sender {
    [self toHidden];
}

- (IBAction)dealTapOK:(id)sender {
    self.datePickerBlock(self.datePicker.date);
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

- (void)dealloc{
    
}
@end
