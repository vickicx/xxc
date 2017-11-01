//
//  ProvinceModel.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/31.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ProvinceModel.h"

@implementation ProvinceModel
- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqual:@"city"]){
        NSArray *cities = value;
        NSMutableArray *city = [NSMutableArray new];
        for(int i=0;i<cities.count;i++){
            CityModel *cityModel = [CityModel new];
            [cityModel setValuesForKeysWithDictionary:cities[i]];
            [city addObject:cityModel];
        }
        self.city = city;
    }
}
@end
