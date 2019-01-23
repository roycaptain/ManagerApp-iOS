//
//  DeviceModel.m
//  Management
//
//  Created by 王雷 on 2018/12/19.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "DeviceModel.h"

@implementation DeviceModel

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    DeviceModel *model = [[self alloc] init];
    model.stationName = dictionary[@"stationInfo"][@"stationName"] ? dictionary[@"stationInfo"][@"stationName"] : @"--";
    model.parentAreaName = dictionary[@"parentAreaName"];
    model.homeTitle = dictionary[@"companyInfo"][@"homeTitle"] ? dictionary[@"companyInfo"][@"homeTitle"] : @"--";
    model.companyName = dictionary[@"companyInfo"][@"companyName"] ? dictionary[@"companyInfo"][@"companyName"] : @"--";
    model.mobile = dictionary[@"companyInfo"][@"mobile"] ? dictionary[@"companyInfo"][@"mobile"] : @"--";
    
    model.filed = [NSString stringWithFormat:@"%@",dictionary[@"field"]];
    model.filedName = [dictionary[@"field"] isEqualToString:@"ELECTRIC_BICYCLE"] ? @"累计充电时长(h)" : @"累计充电量(kW/h)";
    model.chargeEnergyTotal = [dictionary[@"chargeEnergyTotal"] floatValue] / 1000.0f;
    model.totalChargeSeconds = [dictionary[@"totalChargeSeconds"] integerValue] / 3600.0f;
    model.elecFeeTotal = [dictionary[@"totalCostAll"] floatValue] / 100.0f;
    model.totalChargeTime = [dictionary[@"totalChargeTime"] integerValue];
    
    model.warnCount = [dictionary[@"warnCount"] integerValue];
    model.warnLevels = dictionary[@"warnLevels"];
    model.warnInfo = dictionary[@"warnInfo"];
    
    return model;
}

@end
