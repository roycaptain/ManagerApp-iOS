//
//  DistAreaMode.h
//  Management
//
//  Created by 王雷 on 2018/12/13.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DistAreaModel : NSObject

@property(nonatomic,copy)NSString *areaId;
@property(nonatomic,copy)NSString *areaLevel;
@property(nonatomic,copy)NSString *areaName;

@property(nonatomic,strong)NSArray *stationList;

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
