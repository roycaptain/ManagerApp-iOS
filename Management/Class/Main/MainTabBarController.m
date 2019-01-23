//
//  MainTabBarController.m
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置TabBar背景颜色
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [GeneralSize getMainScreenWidth], 49)];
    backView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
    // 选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#3399FF"],NSForegroundColorAttributeName,nil]forState:UIControlStateSelected];
    
    // 添加TabBar控件按钮和控制器
    [self initTabBar];
}

// 添加TabBar控件按钮和控制器
-(void)initTabBar
{
    // 首页
    UIImage *homeNormal = [[UIImage imageNamed:@"tabbar_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *homeSelect = [[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIStoryboard *homeSB = [UIStoryboard storyboardWithName:@"Home" bundle:[NSBundle mainBundle]];
    MainNavigationController *homeNav = [[MainNavigationController alloc] initWithRootViewController:[homeSB instantiateViewControllerWithIdentifier:@"HomeController"]];
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:homeNormal selectedImage:homeSelect];
    
    // 设备监控
    UIImage *deviceNormal = [[UIImage imageNamed:@"tabbar_device_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *deviceSelect = [[UIImage imageNamed:@"tabbar_device_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIStoryboard *deviceSB = [UIStoryboard storyboardWithName:@"Device" bundle:[NSBundle mainBundle]];
    MainNavigationController *deviceNav = [[MainNavigationController alloc] initWithRootViewController:[deviceSB instantiateViewControllerWithIdentifier:@"DeviceController"]];
    deviceNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设备监控" image:deviceNormal selectedImage:deviceSelect];
    
    // 我的
    UIImage *mineNormal = [[UIImage imageNamed:@"tabbar_mine_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *mineSelect = [[UIImage imageNamed:@"tabbar_mine_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    MainNavigationController *mineNav = [[MainNavigationController alloc] initWithRootViewController:[mineSB instantiateViewControllerWithIdentifier:@"MineController"]];
    mineNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:mineNormal selectedImage:mineSelect];
    
    self.viewControllers = @[homeNav,deviceNav,mineNav];
    
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
