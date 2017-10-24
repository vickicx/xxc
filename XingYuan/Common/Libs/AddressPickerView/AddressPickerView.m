//
//  AddressPickerView.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/12.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "AddressPickerView.h"

@interface AddressPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *aboveView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,assign) NSInteger firstCommponentRow;
@property (nonatomic,assign) NSInteger secondCommponentRow;
@end
@implementation AddressPickerView

+ (instancetype)addressPickerView{
    return [[NSBundle mainBundle] loadNibNamed:@"AddressPickerView" owner:nil options:nil].firstObject;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dealTapAboveView)];
    [self.aboveView addGestureRecognizer:tapG];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    //获取plist中的数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ProvinceCityList" ofType:@"plist"];
    self.dataArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
}

- (IBAction)dealTapCancel:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)dealTapOK:(id)sender {
    [self dealTapAboveView];
}


- (void)dealTapAboveView{
    NSString *province = self.dataArray[[self.pickerView selectedRowInComponent:0]][@"state"];
    NSArray *cities = self.dataArray[[self.pickerView selectedRowInComponent:0]][@"cities"];
    NSString *city = cities[[self.pickerView selectedRowInComponent:1]];
    self.block(province, city);
    [self removeFromSuperview];
}

- (void)toShow{
    self.frame = SCREEN_RECT;
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

// MARK: - UIPickerViewDelegate、UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger section = [pickerView selectedRowInComponent:0];
    NSArray *cities = self.dataArray[section][@"cities"];
    return cities.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0){
        return self.dataArray[row][@"state"];
    }
    if (component == 1){
        NSInteger section = [pickerView selectedRowInComponent:0];
        NSArray *cities = self.dataArray[section][@"cities"];
        return cities[row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [pickerView reloadComponent:1];
}

@end



