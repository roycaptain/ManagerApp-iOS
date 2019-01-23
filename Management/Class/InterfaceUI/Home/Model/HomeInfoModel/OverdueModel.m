//
//  OverdueModel.m
//  Management
//
//  Created by 王雷 on 2018/12/19.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "OverdueModel.h"
#import "AAChartKit.h"

@implementation OverdueModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    OverdueModel *model = [[self alloc] init];
    
    NSArray *existInfo = [dictionary[@"existInfo"] componentsSeparatedByString:@","];
    model.categories = dictionary[@"nameList"];
    model.viewHeight = 305.0f;
    model.viewWidth = model.categories.count * 25.0f;
    
    NSArray *dataList = dictionary[@"dataList"];
    if (dataList.count == 0) {
        model.data = NULL;
    } else {
        NSArray *tempList = dataList[0];
        NSMutableArray *resultList = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < tempList.count; i++) {
            NSMutableArray *lineList = [NSMutableArray arrayWithCapacity:dataList.count];
            for (NSInteger j = 0; j < dataList.count; j++) {
                [lineList addObject:@"0"];
            }
            [resultList addObject:lineList];
        }
        for (NSInteger i=0; i<dataList.count; i++) {
            for (NSInteger j=0; j<tempList.count; j++) {
                resultList[j][i] = dataList[i][j];
            }
        }
        NSMutableArray *mutableData = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < resultList.count; i++) {
            [mutableData addObject:AASeriesElement.new.nameSet(existInfo[i]).dataSet(resultList[i])];
        }
        model.data = [mutableData mutableCopy];
    }
    
//    // 将二维数组倒置
//    NSArray *tmpArray = dataList[0];
//    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:tmpArray.count];
//    for (NSInteger i=0; i<tmpArray.count; i++) {
//        NSMutableArray *lineArray = [NSMutableArray arrayWithCapacity:dataList.count];
//        for (NSInteger j=0; j<dataList.count; j++) {
//            [lineArray addObject:@"0"];
//        }
//        [newArray addObject:lineArray];
//    }
//
//    for (NSInteger i=0; i<dataList.count; i++) {
//        for (NSInteger j=0; j<tmpArray.count; j++) {
//            newArray[j][i] = dataList[i][j];
//        }
//    }
//    model.data = [newArray mutableCopy];
    
    return model;
}

@end
