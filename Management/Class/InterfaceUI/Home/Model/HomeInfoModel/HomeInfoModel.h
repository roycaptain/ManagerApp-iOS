//
//  HomeInfoModel.h
//  Management
//
//  Created by 王雷 on 2018/12/18.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeInfoModel : NSObject

@property(nonatomic,assign)NSInteger stationCount; // 充电站点总数
@property(nonatomic,assign)NSInteger deviceCount; //充电桩总数

@property(nonatomic,assign)NSInteger onlineDeviceCount; // 在线桩数
@property(nonatomic,assign)NSInteger offlineDeviceCount; // 离线充电桩数
@property(nonatomic,assign)CGFloat onlinePercent; // 在线百分比
@property(nonatomic,assign)CGFloat offlinePercent; // 离线百分比

@property(nonatomic,assign)NSInteger chargingCount; // 充电中数
@property(nonatomic,assign)NSInteger freeCount; // 空闲充电桩
@property(nonatomic,assign)CGFloat chargingPercent; // 充电百分比
@property(nonatomic,assign)CGFloat freePercent; // 空闲百分比

@property(nonatomic,assign)NSInteger warnDeviceCount; // 告警充电桩数
@property(nonatomic,assign)CGFloat warnPercent; // 告警百分比

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
