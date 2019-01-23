//
//  MainViewController.h
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

/*
 设置 NavigationBar 的标题
 */
-(void)setNavigationTitle:(NSString *)title;

/*
 设置 NavigationBar 标题的颜色
 */
-(void)setNavigationBarTitleFontSize:(CGFloat)fontSize andFontColor:(NSString *)color;

/*
 自定义NavigationBar 返回按钮
 */
-(void)setNavigationBarBackItem;

/*
 隐藏 NavigationBar 返回按钮
 */
-(void)setHideNavigationBarBackItem;

/*
 设置首页 NavigationBar 左标题
 */
-(void)setHomeNavigationLeftItem;

/*
 设置首页 NavigationBar 右侧按钮
 */
-(void)setHomeNavigationRightItemWithTarget:(id)target withAction:(SEL)action;

/*
 设置首页 NavigationBar 标题按钮
 */
-(void)setHomeNavigationTitleViewWithTitle:(NSString *)title withTarget:(id)target withAction:(SEL)action;

/*
 access_token 失效跳转到登录界面
 */
-(void)redirectTargetLoginController;

@end
