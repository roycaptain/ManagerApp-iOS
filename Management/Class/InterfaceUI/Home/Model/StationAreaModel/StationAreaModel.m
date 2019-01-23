//
//  StationAreaModel.m
//  Management
//
//  Created by 王雷 on 2018/12/13.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "StationAreaModel.h"

@implementation StationAreaModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    StationAreaModel *model = [[self alloc] init];
    model.areaId = dictionary[@"stationId"];
    model.areaName = dictionary[@"stationName"];
    model.areaLevel = @"";
    return model;
}

@end
