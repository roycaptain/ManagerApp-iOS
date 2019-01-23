//
//  DistAreaMode.m
//  Management
//
//  Created by 王雷 on 2018/12/13.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "DistAreaModel.h"
#import "StationAreaModel.h"

@implementation DistAreaModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    DistAreaModel *model = [[self alloc] init];
    
    model.areaId = dictionary[@"areaId"];
    model.areaLevel = dictionary[@"areaLevel"];
    model.areaName = dictionary[@"areaName"];
    
    NSArray *stationList = dictionary[@"stationList"];
    
    if (stationList && stationList.count > 0) {
        NSMutableArray *mutableStations = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in stationList) {
            StationAreaModel *stationModel = [StationAreaModel modelWithDictionary:dictionary];
            [mutableStations addObject:stationModel];
        }
        model.stationList = [mutableStations mutableCopy];
    }

    
    return model;
}

@end
