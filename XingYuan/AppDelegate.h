//
//  AppDelegate.h
//  XingYuan
//
//  Created by 陈曦 on 2017/9/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineMainViewController.h"
#import "ConversationMainViewController.h"
#import "FindHimMainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIScrollViewDelegate,UITabBarControllerDelegate>


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabbar;


@end

