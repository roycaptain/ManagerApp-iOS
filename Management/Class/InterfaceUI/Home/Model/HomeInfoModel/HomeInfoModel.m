//
//  HomeInfoModel.m
//  Management
//
//  Created by 王雷 on 2018/12/18.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "HomeInfoModel.h"

@implementation HomeInfoModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    HomeInfoModel *model = [[self alloc] init];
    
    model.stationCount = [dictionary[@"stationCount"] integerValue]; // 充电桩站点总数
    model.deviceCount = [dictionary[@"deviceCount"] integerValue]; // 充电桩总数
    
    model.onlineDeviceCount = [dictionary[@"onlineDeviceCount"] integerValue];  // 在线充电桩数量
    model.offlineDeviceCount = [dictionary[@"offlineDeviceCount"] integerValue]; // 离线充电桩数量
    model.onlinePercent = (CGFloat)model.onlineDeviceCount / (model.onlineDeviceCount + model.offlineDeviceCount); // 在线百分比
    model.offlinePercent = (CGFloat)model.offlineDeviceCount / (model.onlineDeviceCount + model.offlineDeviceCount);  // 离线百分比
    
    model.chargingCount = [dictionary[@"chargingCount"] integerValue]; // 充电中数量
    model.freeCount = [dictionary[@"freeCount"] integerValue]; // 空闲中数量
    model.chargingPercent = (CGFloat)model.chargingCount / (model.chargingCount + model.freeCount); // 充电百分比
    model.freePercent = (CGFloat)model.freeCount / (model.chargingCount + model.freeCount); // 空闲百分比
    
    model.warnDeviceCount = [dictionary[@"warnDeviceCount"] integerValue];
    model.warnPercent = (CGFloat)model.warnDeviceCount / model.deviceCount;    
    
    return model;
}

@end
