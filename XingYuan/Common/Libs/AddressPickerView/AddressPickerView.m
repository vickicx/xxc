//
//  AddressPickerView.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/12.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "AddressPickerView.h"
#import "ProvinceModel.h"
#import "CityModel.h"

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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Province_city_area" ofType:@"plist"];
    NSArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSMutableArray *dataArray = [NSMutableArray new];
    for(int i=0;i<arr.count;i++){
        ProvinceModel *provinceModel = [ProvinceModel new];
        [provinceModel setValuesForKeysWithDictionary:arr[i]];
        [dataArray addObject:provinceModel];
    }
    self.dataArray = dataArray;
    [self.pickerView reloadAllComponents];
}

- (IBAction)dealTapCancel:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)dealTapOK:(id)sender {
    [self dealTapAboveView];
}


- (void)dealTapAboveView{
    ProvinceModel *provinceModel = self.dataArray[[self.pickerView selectedRowInComponent:0]];
    NSString *provinceName = provinceModel.name;
    CityModel *cityModel = provinceModel.city[[self.pickerView selectedRowInComponent:1]];
    NSString *cityName = cityModel.name;
//    NSString *province = self.dataArray[[self.pickerView selectedRowInComponent:0]][@"state"];
//    NSArray *cities = self.dataArray[[self.pickerView selectedRowInComponent:0]][@"cities"];
//    NSString *city = cities[[self.pickerView selectedRowInComponent:1]];
    self.block(provinceName, cityName);
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
    if(component == 0){
        return self.dataArray.count;
    }
    if(component == 1){
        ProvinceModel *provinceModel = self.dataArray[[pickerView selectedRowInComponent:0]];
        return provinceModel.city.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0){
        ProvinceModel *provinceModel = self.dataArray[row];
        return provinceModel.name;
    }
    if (component == 1){
        ProvinceModel *provinceModel = self.dataArray[[pickerView selectedRowInComponent:0]];
        CityModel *cityModel = provinceModel.city[row];
        return cityModel.name;
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [pickerView reloadComponent:1];
}

@end



