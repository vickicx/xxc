//
//  ScreeningController.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/19.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ViewController.h"
#import "BasiceInfoCell.h"
#import "FillUserInfoCell.h"
#import "FillUserInfoNoticeHeaderView.h"
#import "FillUserInfoNextFooterView.h"

typedef enum _ScreeningControllerType {
    ScreeningControllerTypeUpdateToServer,  //保存到服务器
    ScreeningControllerTypeUpdatelocal      //个人资料中编辑
}ScreeningControllerType;

@interface ScreeningController : ViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UIButton *finishBtn;
@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,strong) BasiceInfoCell *basiceInfoCell;
@property (nonatomic,strong) NSArray *cells;
@property (nonatomic,strong) NSArray *cellTitles;


/**
 回调block
 */
@property (nonatomic,strong) void(^block)(BaseModel *model);

/**
 初始化方法

 @param type Controller的类型
 @param cellTitle basicInfoCell的前置title
 @return ScreeningController 实例
 */
- (instancetype)initWithType:(ScreeningControllerType)type basicInfoCellPreTitle:(NSString *)cellTitle;

/**
 更新信息到服务器
 
 @param isToNext 是否跳到下一级筛选
 */
- (void)dealUploadInfo:(BOOL)isToNext;

//点击完成按钮
- (void)dealTapFinished;
@end
