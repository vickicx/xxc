//
//  MyDataSelectTypeCell.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _MyDataSelectType{
    MyDataSelectTypeMyData,
    MyDataSelectTypeSuposeStandard
}MyDataSelectType;

@interface MyDataSelectTypeCell : UITableViewCell
@property (nonatomic,strong) void(^selectTypeBlock)(MyDataSelectType);
@end
