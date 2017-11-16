//
//  GrowthCenterTaskCell.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/19.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "GrowthCenterTaskCell.h"

@interface GrowthCenterTaskCell ()
@property (weak, nonatomic) IBOutlet UIView *grayPoint;
@property (weak, nonatomic) IBOutlet UILabel *firstLevelTitle;
@property (weak, nonatomic) IBOutlet UILabel *secondLevelTitle;
@property (weak, nonatomic) IBOutlet UIButton *handleBtn;

@property (nonatomic,weak) MyTaskModel *mytaskModel;
@end
@implementation GrowthCenterTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.grayPoint.layer.cornerRadius = 3;
    self.grayPoint.clipsToBounds = true;
    [self.handleBtn addTarget:self action:@selector(dealHandle) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configWithModel:(MyTaskModel *)model{
    self.mytaskModel = model;
    UIColor *handleAbleColor = RGBColor(43, 48, 52, 1);
    UIColor *unHandleAbleColor = RGBColor(141, 146, 149, 1);
    self.handleBtn.layer.borderWidth = 1;
    
    
    self.firstLevelTitle.text = model.taskname;
    NSString *secoundLevelTitleText = @"";
    if(model.taskexperience.integerValue > 0){
        secoundLevelTitleText = [secoundLevelTitleText stringByAppendingFormat:@"经验+%@ ",model.taskexperience];
    }
    if(model.taskidealmoney.integerValue > 0){
        secoundLevelTitleText = [secoundLevelTitleText stringByAppendingFormat:@"金币+%@ ",model.taskidealmoney];
    }
    self.secondLevelTitle.text = secoundLevelTitleText;
    
    //->是否完成任务
    //已完成任务
    if(model.isfinish){
        //->是否领取奖励
        //已领取
        if(model.isfinishaward){
            [self.handleBtn setTitleColor:unHandleAbleColor forState:UIControlStateNormal];
            self.handleBtn.layer.borderColor = unHandleAbleColor.CGColor;
            NSString *handleBtnTitle = @"已领取奖励";
            [self.handleBtn setTitle:handleBtnTitle forState:UIControlStateNormal];
            [self.handleBtn setUserInteractionEnabled:false];
        }
        //未领取
        if(!model.isfinishaward){
            [self.handleBtn setTitleColor:handleAbleColor forState:UIControlStateNormal];
            self.handleBtn.layer.borderColor = handleAbleColor.CGColor;
            [self.handleBtn setTitle:@"领取奖励" forState:UIControlStateNormal];
            [self.handleBtn setUserInteractionEnabled:true];
        }
    }
    //没有完成任务
    if(!model.isfinish){
        [self.handleBtn setTitleColor:unHandleAbleColor forState:UIControlStateNormal];
        self.handleBtn.layer.borderColor = unHandleAbleColor.CGColor;
        NSString *handleBtnTitle = [NSString stringWithFormat:@"%@/%@",model.finishcount,model.taskneedfinishcount];
        [self.handleBtn setTitle:handleBtnTitle forState:UIControlStateNormal];
        [self.handleBtn setUserInteractionEnabled:false];
    }
//    @property (nonatomic,assign) NSNumber *Id; //用户任务标识ID
//    @property (nonatomic,assign) NSNumber *finishcount; //当前完成次数
//    @property (nonatomic,assign) BOOL isfinish; //是否完成任务
//    @property (nonatomic,assign) BOOL isfinishaward; //是否领取奖励
//    @property (nonatomic,assign) BOOL isvalid; //
//    @property (nonatomic,copy) NSString *taskname; //任务名称
//    @property (nonatomic,assign) NSNumber *taskneedfinishcount; //任务需要完成次数
//    @property (nonatomic,assign) NSNumber *taskexperience; //任务奖励经验
//    @property (nonatomic,assign) NSNumber *taskidealmoney; //任务奖励虚拟币
//    @property (nonatomic,assign) NSString *tasktype; //任务类型，枚举
//    @property (nonatomic,assign) BOOL isnewhandletask; //是否新手任务
}

//点击了右侧操作按钮
- (void)dealHandle{
    if(self.getAwardBlock != nil){
        self.getAwardBlock(self.mytaskModel);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
