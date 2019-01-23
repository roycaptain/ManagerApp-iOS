//
//  ChargeQuantityModel.h
//  Management
//
//  Created by 王雷 on 2018/12/18.
//  Copyright © 2018 Roy. All rights reserved.
//

/*
 累计充电量模型
 */
#import <Foundation/Foundation.h>

@interface ChargeQuantityModel : NSObject

@property(nonatomic,assign)CGFloat totalQuantity;
@property(nonatomic,strong)NSArray *categories;
@property(nonatomic,strong)NSArray *data;
@property(nonatomic,assign)CGFloat viewHeight;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
