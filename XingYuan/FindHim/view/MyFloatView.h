//
//  MyFloatView.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/12.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^GoView)();

@interface MyFloatView : UIView
@property (nonatomic, copy) GoView goMyTreasureView;
@property (nonatomic, copy) GoView goMyInformationView;
@property (nonatomic, copy) GoView goMyCertificationView;
@property (nonatomic, strong) UILabel *authenticationschedule; // 我的认证完成进度
@property (nonatomic, strong) UILabel *memberinfoschedule; // 我的资料完成进度
@end
