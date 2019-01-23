//
//  SubUnitModel.m
//  Management
//
//  Created by 王雷 on 2018/12/25.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "SubUnitModel.h"

@implementation SubUnitModel

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary withInfo:(NSDictionary *)tableInfo
{
    SubUnitModel *model = [[self alloc] init];
    
    model.singleName = [NSString stringWithFormat:@"%@",dictionary[@"value"]];
    model.showExpression = [dictionary[@"showExpression"] boolValue];
    model.singalCode = [NSString stringWithFormat:@"%@",dictionary[@"name"]];
    model.createtime = [NSString stringWithFormat:@"%@",tableInfo[@"createtime"]];
    NSDictionary *refValue = dictionary[@"refValue"];
    NSString *tableInfoValue = [NSString stringWithFormat:@"%@",tableInfo[model.singalCode]];
    if (!refValue) {
        model.singleValue = tableInfoValue;
    } else {
        model.singleValue = [NSString stringWithFormat:@"%@",refValue[tableInfoValue]];
    }
    
    return model;
}

@end
