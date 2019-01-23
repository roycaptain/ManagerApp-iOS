//
//  GeneralSize.m
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "GeneralSize.h"

@implementation GeneralSize

// 获取屏幕的宽度
+ (CGFloat)getMainScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

// 获取屏幕的高度
+ (CGFloat)getMainScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

// 获取 statusBar 的高度
+(CGFloat)getStatusBarHeight
{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

@end
