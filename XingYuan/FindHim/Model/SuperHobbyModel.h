//
//  SuperHobbyModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"
#import "ChildHobbyModel.h"

@interface SuperHobbyModel : BaseModel
@property (nonatomic,strong) NSArray *child;
@property (nonatomic,copy) NSNumber *Id;
@property (nonatomic,copy) NSString *name;
@end
