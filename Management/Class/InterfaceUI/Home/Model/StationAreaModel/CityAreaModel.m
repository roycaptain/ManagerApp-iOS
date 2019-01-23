//
//  CityAreaModel.m
//  Management
//
//  Created by 王雷 on 2018/12/13.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "CityAreaModel.h"
#import "StationAreaModel.h"
#import "DistAreaModel.h"

@implementation CityAreaModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    CityAreaModel *model = [[self alloc] init];
    
    model.areaId = dictionary[@"areaId"];
    model.areaLevel = dictionary[@"areaLevel"];
    model.areaName = dictionary[@"areaName"];
    
    NSArray *stationList = dictionary[@"stationList"];
    NSArray *areaList = dictionary[@"areaList"];
    
    if (stationList && stationList.count > 0) {
        NSMutableArray *mutableStations = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in stationList) {
            StationAreaModel *stationModel = [StationAreaModel modelWithDictionary:dictionary];
            [mutableStations addObject:stationModel];
        }
        model.stationList = [mutableStations mutableCopy];
    }
    if (areaList && areaList.count > 0) {
        NSMutableArray *mutableDists = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in areaList) {
            DistAreaModel *distModel = [DistAreaModel modelWithDictionary:dictionary];
            [mutableDists addObject:distModel];
        }
        model.areaList = [mutableDists mutableCopy];
    }
    
    return model;
}

@end
