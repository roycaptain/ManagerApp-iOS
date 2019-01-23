//
//  ProvAreaModel.m
//  Management
//
//  Created by 王雷 on 2018/12/13.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ProvAreaModel.h"
#import "StationAreaModel.h"
#import "CityAreaModel.h"

@implementation ProvAreaModel

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    ProvAreaModel *model = [[self alloc] init];
    
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
        NSMutableArray *mutableCitys = [[NSMutableArray alloc] init];
        for (NSDictionary *dictionary in areaList) {
            CityAreaModel *cityModel = [CityAreaModel modelWithDictionary:dictionary];
            [mutableCitys addObject:cityModel];
        }
        model.areaList = [mutableCitys mutableCopy];
    }
    
    return model;
}

@end
