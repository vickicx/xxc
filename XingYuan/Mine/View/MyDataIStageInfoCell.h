//
//  MyDataIStageInfoCell.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDataIStageInfoCell : UITableViewCell
@property (nonatomic,strong) void(^editBlock)();
@property (nonatomic,copy) NSString *leftLabelTitle;
- (void)configWithTitles:(NSArray *)titles color:(UIColor *)color;
@end
