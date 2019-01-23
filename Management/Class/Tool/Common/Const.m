//
//  Const.m
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "Const.h"

NSString *const MAMapKey = @"f6b3603b113539b8a19945336d125d94"; // 高德地图key
NSString *const BuglyAppID = @"f26a6713e9"; // Bugly AppID
NSString *const JPushAppKey = @"0c31507c348cbad8bd56702f"; // 极光推送

// 友好提示用语
NSString *const NetworkingError = @"请检查您的网络"; // 请求错误提示语
NSString *const OperationFailure = @"操作失败"; // 操作失败
NSString *const OperationSuccess = @"操作成功"; // 操作成功

/*
 * 网络接口
 */
NSString *const URLInterfacePrefixion = @"http://120.78.79.129:8888/api/edos/app/"; //正式
//NSString *const URLInterfacePrefixion = @"http://120.79.23.111:8888/api/edos/app/"; // 测试
NSString *const URLInterfaceUserLogin = @"appLogin"; // 用户注册
NSString *const URLInterfaceLoginOut = @"loginOut"; // 退出登录
NSString *const URLInterfaceUserInfo = @"getUserInfo"; // 退出登录
NSString *const URLInterfaceChangePW = @"changePassWord"; // 修改密码
NSString *const URLInterfaceAreaList = @"getAreaList"; // 全部省市区站点列表
NSString *const URLInterfaceHomeInfo = @"getHomeInfo"; // 首页数据
NSString *const URLInterfaceMapInfo = @"getMapInfo"; // 地图数据
NSString *const URLInterfaceMonitor = @"getDataFlowInfo"; // 设备监控
NSString *const URLInterfaceDeviceListInfo = @"getDeviceListInfo"; // 设备列表
NSString *const URLInterfaceWarnListInfo = @"getDeviceWarnListInfo"; // 告警列表
NSString *const URLInterfaceDeviceDetailListInfo = @"getDeviceDetailListInfo"; // 设备详情
NSString *const URLInterfaceChildDetail = @"getChildDetail"; // 子设备列表
NSString *const URLInterfaceSingalChart = @"getSignalChart"; // 信号曲线

@implementation Const

@end
