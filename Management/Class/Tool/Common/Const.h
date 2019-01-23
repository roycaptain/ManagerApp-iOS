//
//  Const.h
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const MAMapKey; // 高德地图key
extern NSString *const BuglyAppID; // Bugly AppID
extern NSString *const JPushAppKey; // 极光推送

// 友好提示用语
extern NSString *const NetworkingError; // 请求错误
extern NSString *const OperationFailure; // 操作失败
extern NSString *const OperationSuccess; // 操作成功

/*
 * 网络接口
 */
typedef NS_ENUM(NSInteger,RequestNetworkStatus) {
    RequestNetworkSuccess = 0, // 请求成功
    RequestAccessTokenLose = 400000, // access_token 失效
};

extern NSString *const URLInterfacePrefixion; //网络接口端口
extern NSString *const URLInterfaceUserLogin; // 用户注册
extern NSString *const URLInterfaceLoginOut; // 退出登录
extern NSString *const URLInterfaceUserInfo; // 退出登录
extern NSString *const URLInterfaceChangePW; // 修改密码
extern NSString *const URLInterfaceAreaList; // 站点区域筛选数据
extern NSString *const URLInterfaceHomeInfo; // 首页数据
extern NSString *const URLInterfaceMapInfo; // 地图数据
extern NSString *const URLInterfaceMonitor; // 设备监控
extern NSString *const URLInterfaceDeviceListInfo; // 设备列表
extern NSString *const URLInterfaceWarnListInfo; // 告警数据
extern NSString *const URLInterfaceDeviceDetailListInfo; // 设备详情
extern NSString *const URLInterfaceChildDetail; // 子设备列表
extern NSString *const URLInterfaceSingalChart; // 信号曲线

@interface Const : NSObject

@end
