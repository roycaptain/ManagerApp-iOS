//
//  MainViewController.m
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MainViewController.h"
#import "LoginController.h"
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F7FF"];
}

#pragma mark private method
/*
 设置 NavigationBar 的标题
 */
-(void)setNavigationTitle:(NSString *)title
{
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.title = title;
}

/*
 设置 NavigationBar 标题的字体颜色
 */
-(void)setNavigationBarTitleFontSize:(CGFloat)fontSize andFontColor:(NSString *)color
{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize],NSForegroundColorAttributeName:[UIColor colorWithHexString:color]}];
}

/*
 自定义NavigationBar 返回按钮
 */
-(void)setNavigationBarBackItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navbar_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popViewController)];
}

/*
 隐藏 NavigationBar 返回按钮
 */
-(void)setHideNavigationBarBackItem
{
    self.navigationItem.hidesBackButton = YES;
}

/*
 设置首页 NavigationBar 左标题
 */
-(void)setHomeNavigationLeftItem
{
    UILabel *leftTitleLaebl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 70.0f, 17.0f)];
    leftTitleLaebl.text = @"运营平台";
    leftTitleLaebl.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    leftTitleLaebl.textAlignment = NSTextAlignmentLeft;
    leftTitleLaebl.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18.0f];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftTitleLaebl];
    self.navigationItem.leftBarButtonItem = leftItem;
}

/*
 设置首页 NavigationBar 右侧按钮
 */
-(void)setHomeNavigationRightItemWithTarget:(id)target withAction:(SEL)action;
{
    UIImage *mapImage = [[UIImage imageNamed:@"nav_bar_location"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:mapImage style:UIBarButtonItemStylePlain target:target action:action];
}

/*
 设置首页 NavigationBar 标题按钮
 */
-(void)setHomeNavigationTitleViewWithTitle:(NSString *)title withTarget:(id)target withAction:(SEL)action
{
    UIButton *navTitleItem = [UIButton buttonWithType:UIButtonTypeCustom];
    navTitleItem.frame = CGRectMake(0.0f, 0.0f, 100.0f, 40.0f);
    [navTitleItem setTitle:title forState:UIControlStateNormal];
    [navTitleItem setImage:[UIImage imageNamed:@"top_area_menu"] forState:UIControlStateNormal];
    navTitleItem.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    navTitleItem.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [navTitleItem addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = navTitleItem;
}

// 返回上一级界面
-(void)popViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 access_token 失效跳转到登录界面
 */
-(void)redirectTargetLoginController
{
    // 重新登录时将之前的账户和密码清除
    [[UserInfoManager shareInstance] loginOut];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:[NSBundle mainBundle]];
    LoginController *loginVC = [loginSB instantiateViewControllerWithIdentifier:@"LoginController"];
    appDelegate.window.rootViewController = loginVC;
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
