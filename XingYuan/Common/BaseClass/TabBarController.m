//
//  TabBarController.m
//  XingYuan
//
//  Created by YunKuai on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "TabBarController.h"

#import "MineMainViewController.h"
#import "NTESSessionListViewController.h"
#import "ConversationMainViewController.h"
#import "FindHimMainViewController.h"
#import "NavigationController.h"
#import "NTESCustomNotificationDB.h"

#define TabbarVC    @"vc"
#define TabbarTitle @"title"
#define TabbarImage @"image"
#define TabbarSelectedImage @"selectedImage"
#define TabbarItemBadgeValue @"badgeValue"
#define TabBarCount 3

typedef NS_ENUM(NSInteger,TabType) {
    TabTypeFindHim,    //识TA
    TabTypeConversation,        //会话
    TabTypeMine   //我的
};


@interface TabBarController ()<UITabBarControllerDelegate,NIMSystemNotificationManagerDelegate,NIMConversationManagerDelegate>

@property (nonatomic,assign) NSInteger conversationUnreadCount;

@property (nonatomic,assign) NSInteger systemUnreadCount;

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
    [[NIMSDK sharedSDK].conversationManager addDelegate:self];
    extern NSString *NTESCustomNotificationCountChanged;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCustomNotifyChanged:) name:NTESCustomNotificationCountChanged object:nil];
}

- (void)dealloc{
    [[NIMSDK sharedSDK].systemNotificationManager removeDelegate:self];
    [[NIMSDK sharedSDK].conversationManager removeDelegate:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - NIMConversationManagerDelegate
- (void)didAddRecentSession:(NIMRecentSession *)recentSession
           totalUnreadCount:(NSInteger)totalUnreadCount{
    self.conversationUnreadCount = totalUnreadCount;
    [self refreshMyMessageBadge];
}


- (void)didUpdateRecentSession:(NIMRecentSession *)recentSession
              totalUnreadCount:(NSInteger)totalUnreadCount{
    self.conversationUnreadCount = totalUnreadCount;
    [self refreshMyMessageBadge];
}


- (void)didRemoveRecentSession:(NIMRecentSession *)recentSession totalUnreadCount:(NSInteger)totalUnreadCount{
    self.conversationUnreadCount = totalUnreadCount;
    [self refreshMyMessageBadge];
}

- (void)messagesDeletedInSession:(NIMSession *)session{
    self.conversationUnreadCount = [NIMSDK sharedSDK].conversationManager.allUnreadCount;
    [self refreshMyMessageBadge];
}

- (void)allMessagesDeleted{
    self.conversationUnreadCount = 0;
    [self refreshMyMessageBadge];
}

#pragma mark - NIMSystemNotificationManagerDelegate
- (void)onSystemNotificationCountChanged:(NSInteger)unreadCount
{
    self.systemUnreadCount = unreadCount;
    [self refreshMyMessageBadge];
}

#pragma mark - Notification
- (void)onCustomNotifyChanged:(NSNotification *)notification
{
    NTESCustomNotificationDB *db = [NTESCustomNotificationDB sharedInstance];
    self.systemUnreadCount = db.unreadCount;
    [self refreshMyMessageBadge];
}

- (void)refreshMyMessageBadge{
    UINavigationController *nav = self.viewControllers[TabTypeConversation];
    int sessionListUnreadCount = self.conversationUnreadCount ? @(self.conversationUnreadCount).intValue : 0;
    int systemNotificationUnreadCount = self.systemUnreadCount ? @(self.systemUnreadCount).intValue : 0;
    NSNumber *totalUnreadCount = [NSNumber numberWithInt:sessionListUnreadCount+systemNotificationUnreadCount];
    nav.tabBarItem.badgeValue = [totalUnreadCount isEqual:@0] ? nil:totalUnreadCount.stringValue;

}

- (void)refreshConversationBadge{
    UINavigationController *nav = self.viewControllers[TabTypeConversation];
    nav.tabBarItem.badgeValue = self.conversationUnreadCount ? @(self.conversationUnreadCount).stringValue : nil;
}

//- (void)refreshMineBadge{
//    UINavigationController *nav = self.viewControllers[TabTypeMine];
//    NSInteger badge = self.systemUnreadCount;
//    nav.tabBarItem.badgeValue = badge ? @(badge).stringValue : nil;
//}

- (instancetype)init{
    if ([super init]){
        [self loadChildControllers];
    }
    return self;
}


- (void)loadChildControllers{
    //创建各个子Controller
    FindHimMainViewController *findVC = [[FindHimMainViewController alloc] init];
    NavigationController *findNav = [self getChildNavControllerWith:findVC Title:@"识TA" TabBarItemImg:@"识TA" TabBarItemSelectImg:@"识TA-"];
    
    ConversationMainViewController *conversationVC = [[ConversationMainViewController alloc] init];
    NavigationController *conversationNav = [self getChildNavControllerWith:conversationVC Title:@"我的消息" TabBarItemImg:@"xx" TabBarItemSelectImg:@"xx-"];
    
    MineMainViewController *myVC = [[MineMainViewController alloc] init];
    NavigationController *myNav = [self getChildNavControllerWith:myVC Title:@"我的账户" TabBarItemImg:@"wd" TabBarItemSelectImg:@"W-"];
    

    self.viewControllers = @[findNav,conversationNav,myNav];
    self.selectedIndex = 0;
    self.tabBar.tintColor = RGBColor(246, 80, 118, 1);
    [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(10, -5)];
}

//获取对应的navigationController并进行配置
- (NavigationController *)getChildNavControllerWith:(ViewController *)controller Title:(NSString *)title TabBarItemImg:(NSString *)tabBarItemImg TabBarItemSelectImg:(NSString *)tabBarItemSelectImg{
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:controller];
    nav.tabBarItem.image = [[UIImage imageNamed:tabBarItemImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:tabBarItemSelectImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    controller.title = title;
    return nav;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
