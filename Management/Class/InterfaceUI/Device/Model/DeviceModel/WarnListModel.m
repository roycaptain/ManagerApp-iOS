//
//  WarnListModel.m
//  Management
//
//  Created by 王雷 on 2018/12/20.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "WarnListModel.h"

@implementation WarnListModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary withParentAreaName:(NSString *)parentAreaName
{
    WarnListModel *model = [[self alloc] init];
    
    model.deviceName = dictionary[@"deviceName"];
    model.warnTypeName = dictionary[@"warnTypeName"];
    model.warnCodeName = dictionary[@"warnCodeName"];
    model.warnCount = [dictionary[@"warnCount"] integerValue];
    model.warnLevelName = dictionary[@"warnLevelName"];
    model.parentAreaName = [parentAreaName copy];
    model.firstTime = dictionary[@"firstTime"];
    model.newestTime = dictionary[@"newestTime"];
    
    return model;
}

@end
