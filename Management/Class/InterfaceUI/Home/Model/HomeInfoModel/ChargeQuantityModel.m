//
//  ChargeQuantityModel.m
//  Management
//
//  Created by 王雷 on 2018/12/18.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ChargeQuantityModel.h"

@implementation ChargeQuantityModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    ChargeQuantityModel *model = [[self alloc] init];
    
    model.totalQuantity = [dictionary[@"total"] floatValue];
    model.categories = dictionary[@"nameList"];
    model.data = dictionary[@"dataList"];
    model.viewHeight = model.categories.count * 20.0f + 41.0f;
    
    return model;
}

@end
