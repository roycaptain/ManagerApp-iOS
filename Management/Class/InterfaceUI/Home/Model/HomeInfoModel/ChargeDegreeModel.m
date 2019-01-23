//
//  ChargeDegreeModel.m
//  Management
//
//  Created by 王雷 on 2018/12/18.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ChargeDegreeModel.h"

@implementation ChargeDegreeModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    ChargeDegreeModel *model = [[self alloc] init];
    
    model.totalCycles = [dictionary[@"total"] integerValue];
    model.categories = dictionary[@"nameList"];
    model.data = dictionary[@"dataList"];
    model.viewHeight = model.data.count * 20.0f + 41.0f;
    
    return model;
}

@end
