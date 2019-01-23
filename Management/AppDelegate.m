//
//  AppDelegate.m
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "MainTabBarController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <Bugly/Bugly.h>
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self applicationInitMethod]; // app 启动时要初始化一些类实例
    [self loadControllers]; // 加载控制器
    
    /*---------------------- 极光推送 ------------------*/
    [self initJPushActionWithOptions:launchOptions];
    
    return YES;
}

/*
 app 启动时要初始化一些类实例
 */
-(void)applicationInitMethod
{
    //监控网络状态 初始化网络工具层
    [self monitorNetworkingStatus];
    // 高德地图 设置
    [AMapServices sharedServices].apiKey = MAMapKey;
    [AMapServices sharedServices].enableHTTPS = YES;
    
    // 筛选区域信息
    [SiteInfoManager shareInstance];
    
    // 腾讯crash日志
    [Bugly startWithAppId:BuglyAppID];
}

/*
 极光推送
 */
-(void)initJPushActionWithOptions:(NSDictionary *)launchOptions
{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        // Fallback on earlier versions
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    // 如需继续使用 pushConfig.plist 文件声明 appKey 等配置内容，请依旧使用 [JPUSHService setupWithOption:launchOptions] 方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JPushAppKey
                          channel:@"APP Store"
                 apsForProduction:YES
            advertisingIdentifier:NULL];
}

/*
 网络监控
 */
-(void)monitorNetworkingStatus
{
    [NetworkRequest shareInstance];
    [[NetworkRequest shareInstance] monitorNetworkingStatus];
}

/*
 *  加载控制器
 */
-(void)loadControllers
{
    NSLog(@"accesstoken - %@",[[UserInfoManager shareInstance] achiveUserInfoAccessToken]);
    if (![[UserInfoManager shareInstance] achieveUserInfoAccount] || ![[UserInfoManager shareInstance] achiveUserInfoAccessToken]) { // 登录界面
        UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
        LoginController *loginVC = [loginSB instantiateViewControllerWithIdentifier:@"LoginController"];
        self.window.rootViewController = loginVC;
    } else { // tabbar 界面
        MainTabBarController *mainTabBarController = [[MainTabBarController alloc] init];
        self.window.rootViewController = mainTabBarController;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark - JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(nullable UNNotification *)notification
{
    if (@available(iOS 10.0, *)) {
        if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            NSLog(@"1");
        } else {
            NSLog(@"2")
        }
    } else {
        // Fallback on earlier versions
    }
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
    
    NSLog(@"willPresentNotification");
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSLog(@"didReceiveNotificationResponse");
    
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}


@end
