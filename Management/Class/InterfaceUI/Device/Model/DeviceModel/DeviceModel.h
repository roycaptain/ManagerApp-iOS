//
//  DeviceModel.h
//  Management
//
//  Created by 王雷 on 2018/12/19.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceModel : NSObject

@property(nonatomic,copy)NSString *stationName; // 站点名称
@property(nonatomic,copy)NSString *parentAreaName; // 区域路径
@property(nonatomic,copy)NSString *homeTitle; // 所属对象
@property(nonatomic,copy)NSString *companyName; // 联系人
@property(nonatomic,copy)NSString *mobile; // 联系方式

@property(nonatomic,copy)NSString *filed;
@property(nonatomic,copy)NSString *filedName; // 累计充电时长或者累计充电电量类型
@property(nonatomic,assign)CGFloat chargeEnergyTotal; // 累计充电电量
@property(nonatomic,assign)CGFloat totalChargeSeconds; // 累计充电时长
@property(nonatomic,assign)CGFloat elecFeeTotal; // 累计收入
@property(nonatomic,assign)NSInteger totalChargeTime; // 累计充电次数

@property(nonatomic,assign)NSInteger warnCount; // 告警数量
@property(nonatomic,strong)NSArray *warnLevels; // 告警级别
@property(nonatomic,strong)NSArray *warnInfo; // 告警数据

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
