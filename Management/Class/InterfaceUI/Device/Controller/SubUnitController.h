//
//  SubUnitController.h
//  Management
//
//  Created by 王雷 on 2018/11/28.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MainViewController.h"

@interface SubUnitController : MainViewController

@property(nonatomic,copy)NSString *deviceName; // 设备名称
@property(nonatomic,copy)NSString *parentAreaName; // 设备路径

@property(nonatomic,copy)NSString *subUnitName; // 子部件
@property(nonatomic,copy)NSString *singalName; // 信号名
@property(nonatomic,copy)NSString *createTime; // 时间点
@property(nonatomic,copy)NSString *singalValue; // 信号值

@property(nonatomic,copy)NSString *singalCode; // 信号码
@property(nonatomic,copy)NSString *subDeviceId; // 子设备id;
@property(nonatomic,copy)NSString *deviceFinalId; // 子设备分类ID

@end
