//
//  GeneralSize.h
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NavigationBarHeight self.navigationController.navigationBar.frame.size.height // navigationBar 的高度
#define TabBarHeight self.tabBarController.tabBar.frame.size.height // tabBar 的高度

/*
 此类用于获取各种屏幕尺寸的类
 */
@interface GeneralSize : NSObject

// 获取屏幕的宽度
+(CGFloat)getMainScreenWidth;

// 获取屏幕的高度
+(CGFloat)getMainScreenHeight;

// 获取 statusBar 的高度
+(CGFloat)getStatusBarHeight;

@end
