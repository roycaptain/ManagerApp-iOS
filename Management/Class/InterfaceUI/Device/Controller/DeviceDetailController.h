//
//  DeviceDetailController.h
//  Management
//
//  Created by 王雷 on 2018/11/28.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MainViewController.h"

@interface DeviceDetailController : MainViewController

@property(nonatomic,copy)NSString *deviceName; // 设备名称
@property(nonatomic,copy)NSString *parentAreaName; // 设备路径
@property(nonatomic,copy)NSString *deviceId; // 设备编号
@property(nonatomic,copy)NSString *deviceSerialNum; // 设备序列号

@end
