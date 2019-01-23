//
//  MenuModel.m
//  Management
//
//  Created by 王雷 on 2018/11/29.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

+(NSArray *)initWarnLevelData
{
    NSArray *originArray = @[@"全部",@"一般",@"重要",@"紧急"];
    NSMutableArray *mutableData = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < originArray.count; i++) {
        MenuModel *model = [[self alloc] init];
        model.title = originArray[i];
        [mutableData addObject:model];
    }
    return [mutableData copy];
}

+(NSArray *)initWarnTypeData
{
    NSArray *originArray = @[@"全部",@"风扇故障",@"电压过高",@"其他"];
    NSMutableArray *mutableData = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < originArray.count; i++) {
        MenuModel *model = [[self alloc] init];
        model.title = originArray[i];
        [mutableData addObject:model];
    }
    return [mutableData copy];
}

@end
