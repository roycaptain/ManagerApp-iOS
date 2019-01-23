//
//  ChargeDegreeModel.h
//  Management
//
//  Created by 王雷 on 2018/12/18.
//  Copyright © 2018 Roy. All rights reserved.
//

/*
 累计充电次数模型
 */
#import <Foundation/Foundation.h>

@interface ChargeDegreeModel : NSObject

@property(nonatomic,assign)NSInteger totalCycles; // 总次数
@property(nonatomic,strong)NSArray *categories;
@property(nonatomic,strong)NSArray *data;
@property(nonatomic,assign)CGFloat viewHeight;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
