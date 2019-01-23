//
//  TurnOverModel.m
//  Management
//
//  Created by 王雷 on 2018/12/18.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "TurnOverModel.h"

@implementation TurnOverModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    TurnOverModel *model = [[self alloc] init];
    
    model.totalTurnOver = [dictionary[@"total"] floatValue];
    model.categories = dictionary[@"nameList"];
    model.data = dictionary[@"dataList"];
    model.viewHeight = model.data.count * 20.0f + 41.0f;
    
    return model;
}

@end
