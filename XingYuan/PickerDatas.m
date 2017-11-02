//
//  PickerDatas.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/16.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "PickerDatas.h"

@implementation PickerDatas

////兴趣爱好
//+ (NSArray *)hobbies{
//    return @[];
//}

//相貌自评
+ (NSArray *)lookEvaluates{
    return @[@"1分",@"2分",@"3分",@"4分",@"5分",@"6分",@"7分",@"8分",@"9分",@"10分"];
}

//年龄
+ (NSArray *)ages{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for(int i=18;i<40;i++){
        [dataArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    return dataArray;
}

//身高
+ (NSArray *)heights{
    NSMutableArray *dataArray = [NSMutableArray new];
    [dataArray addObject:@"0-140"];
    for (int i=140;i<=230;i++){
        [dataArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [dataArray addObject:@"230-1000"];
    return dataArray;
}

//身高范围数组
+ (NSArray *)heightsRange{
    NSMutableArray *heightRangeModels = [NSMutableArray new];
    //第一个
    HeightRangeModel *firstHeightRangeModel = [HeightRangeModel new];
    firstHeightRangeModel.littleHeight = 0;
    firstHeightRangeModel.biggerHeights = @[@140];
    [heightRangeModels addObject:firstHeightRangeModel];
    
    //中间140-230
    for(int i=140;i<230;i++){
        HeightRangeModel *heightRangeModel = [HeightRangeModel new];
        heightRangeModel.littleHeight = i;
        NSMutableArray *biggerHeights = [NSMutableArray new];
        for(int j=i+1;j<=230;j++){
            [biggerHeights addObject:[NSNumber numberWithInt:j]];
        }
        heightRangeModel.biggerHeights = biggerHeights;
        
        [heightRangeModels addObject:heightRangeModel];
    }
    
    //最后一个
    HeightRangeModel *lastHeightRangeModel = [HeightRangeModel new];
    lastHeightRangeModel.littleHeight = 230;
    lastHeightRangeModel.biggerHeights = @[@1000];
    [heightRangeModels addObject:lastHeightRangeModel];
    
    return heightRangeModels;
}

+ (NSArray *)ageRanges{
    NSMutableArray *ageRangeModels = [NSMutableArray new];
    
    //中间18-40
    for(int i=18;i<80;i++){
        AgeRangeModel *ageRangeModel = [AgeRangeModel new];
        ageRangeModel.littleAge = i;
        NSMutableArray *biggerAges = [NSMutableArray new];
        for(int j=i+1;j<=80;j++){
            [biggerAges addObject:[NSNumber numberWithInt:j]];
        }
        ageRangeModel.biggeraAges = biggerAges;
        
        [ageRangeModels addObject:ageRangeModel];
    }
    
    return ageRangeModels;
}

//体型
+ (NSArray *)bodyShaps{
    return @[@"很瘦",@"较瘦",@"苗条",@"均匀",@"高挑",@"丰满",@"健壮",@"较胖",@"胖"];
}

//星座
+ (NSArray *)constellations{
    return @[@"摩羯座",@"摩羯座",@"水瓶座",@"双鱼座",@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天秤座",@"天蝎座",@"射手座"];
}

//个人学历
+ (NSArray *)educations{
    return @[@"初中",@"中专/职高/技校",@"高中",@"大专",@"本科",@"硕士",@"博士",@"博士后"];
}

//月收入
+ (NSArray *)monthlyIncome{
    return @[@"2000以下",@"2000-3000",@"3000-4000",@"4000-5000",@"5000-7000",@"7000-10000",@"10000-15000",@"15000-20000",@"20000-25000",@"25000-30000",@"30000-50000",@">50000"];
}

//婚姻状况
+ (NSArray *)maritalStatus{
    return @[@"未婚",@"离异",@"丧偶",@"已婚"];
}

//子女情况
+ (NSArray *)childStatus{
    return @[@"无子女",@"有，和我住在一起",@"有，有时和我住一起",@"有，不和我住一起"];
}

//是否喝酒
+ (NSArray *)isDrink{
    return @[@"不喝酒",@"社交需要喝",@"兴致时小酌",@"酒不离口"];
}

//是否吸烟
+ (NSArray *)isSmoking{
    return @[@"不吸，很反感",@"不吸，但不反感",@"社交偶尔吸烟",@"烟不离手"];
}

//购房情况
+ (NSArray *)housePurchaseStatus{
    return @[@"以后再告诉你",@"与父母同住",@"租房",@"已购房（有贷款）",@"已购房（无贷款）",@"住单位房",@"需要时购置"];
}

//购车情况
+ (NSArray *)carPurchaseStatus{
    return @[@"未购车",@"已购车",@"单位用车",@"需要时购置"];
}

//生活作息
+ (NSArray *)lifeRestInfos{
    return @[@"早睡早起",@"偶尔熬夜",@"经常熬夜",@"偶尔懒散",@"没有规律"];
}

+ (NSArray *)nations{
    return @[
             @"汉族"
             ,@"回族"
             ,@"藏族"
             ,@"维吾尔族"
             ,@"苗族"
             ,@"彝族"
             ,@"壮族"
             ,@"布依族"
             ,@"朝鲜族"
             ,@"满族"
             ,@"侗族"
             ,@"瑶族"
             ,@"白族"
             ,@"土家族"
             ,@"哈尼族"
             ,@"哈萨克族"
             ,@"傣族"
             ,@"黎族"
             ,@"僳僳族"
             ,@"佤族"
             ,@"畲族"
             ,@"高山族"
             ,@"拉祜族"
             ,@"水族"
             ,@"东乡族"
             ,@"纳西族"
             ,@"景颇族"
             ,@"柯尔克孜族"
             ,@"土族"
             ,@"达斡尔族"
             ,@"仫佬族"
             ,@"羌族"
             ,@"布朗族"
             ,@"撒拉族"
             ,@"毛南族"
             ,@"仡佬族"
             ,@"锡伯族"
             ,@"阿昌族"
             ,@"普米族"
             ,@"塔吉克族"
             ,@"怒族"
             ,@"乌孜别克族"
             ,@"俄罗斯族"
             ,@"鄂温克族"
             ,@"德昂族"
             ,@"保安族"
             ,@"裕固族"
             ,@"京族"
             ,@"塔塔尔族"
             ,@"独龙族"
             ,@"鄂伦春族"
             ,@"赫哲族"
             ,@"门巴族"
             ,@"珞巴族"
             ,@"基诺族"
             ,@"蒙古族"
             ];
}

+ (NSArray *)stations{
    return @[
             @"餐饮行业"
              ,@"家政保洁/安保行业"
              ,@"美容/美发行业"
              ,@"旅游行业"
              ,@"娱乐/休闲行业"
              ,@"保健按摩行业"
              ,@"运动健身行业"
              ,@"人事/行政/后勤行业"
              ,@"司机行业"
              ,@"高级管理"
              ,@"销售行业"
              ,@"客服行业"
              ,@"贸易/采购行业"
              ,@"超时/百货/零售行业"
              ,@"淘宝职位"
              ,@"房产中介行业"
              ,@"酒店行业"
              ,@"市场/媒介/公关行业"
              ,@"广告/会展/咨询行业"
              ,@"美术/设计/创业行业"
              ,@"普工/技工行业"
              ,@"生产管理/研发行业"
              ,@"物流/仓储行业"
              ,@"服装/纺织/食品行业"
              ,@"质控/安防行业"
              ,@"汽车制造/服务行业"
              ,@"计算机/互联网/通信行业"
              ,@"电子/电器行业"
              ,@"机械/仪器仪表行业"
              ,@"法律行业"
              ,@"教育培训行业"
              ,@"翻译行业"
              ,@"编辑/出版/印刷行业"
              ,@"财务/审计/统计行业"
              ,@"金融/银行/证券/投资行业"
              ,@"保险行业"
              ,@"医院/医疗/护理行业"
              ,@"制药/生物工程行业"
              ,@"环保行业"
              ,@"建筑行业"
              ,@"物业管理行业"
              ,@"农林牧渔行业"
              ,@"其他行业"
             ];

}

+ (NSArray *)zodiacs{
    return @[@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪"];
}

+ (NSArray *)parentsSituations{
    return @[@"父母健在",@"单亲家庭",@"父亲健在",@"母亲健在",@"父母均离世"];
}

+ (NSArray *)familyRank{
    return @[@"独生子女",@"老大",@"老二",@"老三",@"老四",@"老五",@"其他"];
}

+ (NSArray *)parentsEconomics{
    return @[@"以后告诉你",@"均有退休金",@"均无退休金",@"只有父亲有退休金",@"只有母亲有退休金"];
}

+ (NSArray *)parentsMedicalInsurance{
    return @[@"以后告诉你",@"均有医疗保险",@"均无医疗保险",@"只有父亲有医疗保险",@"只有母亲有医疗保险"];
}

//结婚时间
+ (NSArray *)weddingTime{
    return @[@"及时闪婚",@"一年之内",@"两年之内",@"三年之内",@"时机成熟就结婚"];
}

//偏爱约会方式
+ (NSArray *)datingModel{
    return @[@"一起打游戏或者一起看电影",@"一起做饭",@"功夫浪漫之旅",@"牵手漫步在公园",@"彼此相依相偎"];
}

//希望对方看中
+ (NSArray *)hopeOtherImportance{
    return @[@"容貌身材",@"性格",@"心灵",@"经济实力",@"教育程度"];
}

//期待婚礼形式
+ (NSArray *)hopeWeddingForm{
    return @[@"顶级酒店，高朋满座",@"户外婚礼，温馨浪漫",@"旅游结婚，不大操大办",@"中式婚礼，宴请宾客",@"简单就好，无所谓"];
}

//愿与对方父母住否
+ (NSArray *)liveWithOtherParents{
    return @[@"愿意",@"不愿意",@"视情况而定"];
}

//是否想要孩子
+ (NSArray *)wantChildren{
    return @[@"想",@"不想",@"还没想好",@"视情况而定"];
}

//厨艺情况
+ (NSArray *)cookingSkill{
    return @[@"色香味俱全",@"能做几样可口小菜",@"不太会，但愿为心爱的人学习"];
}

//家务分工
+ (NSArray *)houseworkDivision{
    return @[@"任劳任怨",@"希望对方承担家务",@"一起分工合作",@"看各自闲忙，协商分担"];
}
@end
