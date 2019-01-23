//
//  DeviceListModel.h
//  Management
//
//  Created by 王雷 on 2018/12/20.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceListModel : NSObject

@property(nonatomic,copy)NSString *deviceName; // 设备名称
@property(nonatomic,copy)NSAttributedString *deviceStatus; // 设备状态
@property(nonatomic,copy)NSString *deviceId; // 设备编号
@property(nonatomic,copy)NSString *warn; // 是否警告
@property(nonatomic,copy)NSString *warnLevel; // 告警级别
@property(nonatomic,copy)NSString *warnColor; // 告警颜色
@property(nonatomic,copy)NSString *deviceSerialNum; // 设备序列号

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end

