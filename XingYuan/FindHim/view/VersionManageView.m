//
//  VersionManageView.m
//  XingYuan
//
//  Created by YunKuai on 2017/11/9.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "VersionManageView.h"

@interface VersionManageView()
@property (weak, nonatomic) IBOutlet UIView *containView;
//强制更新
@property (weak, nonatomic) IBOutlet UIView *foreceUpdateView;
//非强制更新
@property (weak, nonatomic) IBOutlet UIView *updateView;

@property (nonatomic,strong) VersionMessageModel *versionManageModel;
@end
@implementation VersionManageView

+ (void)showWithModel:(VersionMessageModel *)model{
    NSDictionary *appInfoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [appInfoDic valueForKey:@"CFBundleShortVersionString"];
    if(model.versionnumber == nil || [model.versionnumber length] == 0){
        return;
    }
    if([currentVersion isEqualToString:model.versionnumber]){
        return;
    }
    VersionManageView *versionManageView = [[NSBundle mainBundle] loadNibNamed:@"VersionManageView" owner:nil options:nil].lastObject;
    versionManageView.versionManageModel = model;
    versionManageView.frame = SCREEN_RECT;
    versionManageView.versionManageModel = model;
    versionManageView.containView.layer.cornerRadius = 5;
    versionManageView.containView.clipsToBounds = true;
    [versionManageView.foreceUpdateView setHidden:!model.ismustupdate];
    [versionManageView.updateView setHidden:model.ismustupdate];
    [versionManageView show];
}

- (IBAction)dealForceUpdate:(UIButton *)sender {
    [self toUpdateWith:self.versionManageModel];
}
- (IBAction)dealUpdate:(UIButton *)sender {
    [self toUpdateWith:self.versionManageModel];
}

- (IBAction)notUpdateNow:(UIButton *)sender {
    [self dismiss];
}

- (void)show{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

- (void)dismiss{
    [self removeFromSuperview];
}

- (void)toUpdateWith:(VersionMessageModel *)model{
    NSURL *url = [NSURL URLWithString:model.versionurl];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}
@end
