//
//  SubUnitListController.h
//  Management
//
//  Created by 王雷 on 2018/12/25.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MainViewController.h"

@interface SubUnitListController : MainViewController

@property(nonatomic,copy)NSString *deviceName; // 设备名称
@property(nonatomic,copy)NSString *parentAreaName; // 设备路径

@property(nonatomic,copy)NSString *subDeviceName; // 子部件
@property(nonatomic,copy)NSString *subDeviceId; // 子设备id
@property(nonatomic,copy)NSString *subDeviceFinalId; // 子设备分类Id

@end
