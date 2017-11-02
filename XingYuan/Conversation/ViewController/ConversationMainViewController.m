//
//  ConversationMainViewController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/11.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ConversationMainViewController.h"
#import "NTESSessionListViewController.h"
#import "NTESSystemNotificationViewController.h"
#import "NTESCustomSysNotificationViewController.h"
@interface ConversationMainViewController ()
@property (nonatomic,weak) UISegmentedControl *segmentedControl;
@property (nonatomic,strong) UIViewController *conversasionVC;
@property (nonatomic,strong) NTESSystemNotificationViewController *systemNotoficationController;
@end

@implementation ConversationMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"我的消息";
    label.font = FONT_WITH_S(18);
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:label1];
    self.navigationItem.rightBarButtonItem = itme;
    self.navigationItem.titleView = label;
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"私信",@"通知"]];
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = RGBColor(240, 53, 99, 1);
    [segmentedControl addTarget:self action:@selector(didClickSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    self.segmentedControl = segmentedControl;
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15+64);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(35);
    }];
    
    NTESCustomSysNotificationViewController *systemNotificationController = [[NTESCustomSysNotificationViewController alloc] init];
    systemNotificationController.view.backgroundColor = [UIColor redColor];
    self.systemNotoficationController = systemNotificationController;
    [self addChildViewController:systemNotificationController];
    [self.view addSubview:systemNotificationController.view];
    [systemNotificationController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.segmentedControl.mas_bottom).offset(15);
        make.bottom.equalTo(self.view).offset(-49);
    }];
    
    NTESSessionListViewController *conversationVC = [[NTESSessionListViewController alloc] init];
    conversationVC.view.backgroundColor = [UIColor redColor];
    self.conversasionVC = conversationVC;
    [self addChildViewController:conversationVC];
    [self.view addSubview:conversationVC.view];
    [conversationVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.segmentedControl.mas_bottom).offset(15);
        make.bottom.equalTo(self.view).offset(-49);
    }];
    
}

- (void)didClickSegmentedControl:(UISegmentedControl *)segmentedControl{
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            [self.view bringSubviewToFront:self.conversasionVC.view];
            break;
        case 1:
//            [self.view bringSubviewToFront:self.systemNotoficationController.view];
            {
                NTESSystemNotificationViewController *systemNotificationController = [[NTESSystemNotificationViewController alloc] init];
                systemNotificationController.view.backgroundColor = [UIColor redColor];
                self.systemNotoficationController = systemNotificationController;
                [self addChildViewController:systemNotificationController];
                [self.view addSubview:systemNotificationController.view];
                [systemNotificationController.view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.view);
                    make.right.equalTo(self.view);
                    make.top.equalTo(self.segmentedControl.mas_bottom).offset(15);
                    make.bottom.equalTo(self.view).offset(-49);
                }];
                [[[NIMSDK sharedSDK] systemNotificationManager] markAllNotificationsAsRead];
            }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
