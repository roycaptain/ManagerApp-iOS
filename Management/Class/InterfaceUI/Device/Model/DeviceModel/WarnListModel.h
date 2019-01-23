//
//  WarnListModel.h
//  Management
//
//  Created by 王雷 on 2018/12/20.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WarnListModel : NSObject

@property(nonatomic,copy)NSString *deviceName; //设备名称
@property(nonatomic,copy)NSString *warnTypeName; // 告警名称
@property(nonatomic,copy)NSString *warnCodeName; // 告警种类名称
@property(nonatomic,assign)NSInteger warnCount; // 重复次数
@property(nonatomic,copy)NSString *warnLevelName; // 告警级别
@property(nonatomic,copy)NSString *parentAreaName; // 设备路径
@property(nonatomic,copy)NSString *firstTime; // 第一次上报时间
@property(nonatomic,copy)NSString *newestTime; // 最新上报时间

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary withParentAreaName:(NSString *)parentAreaName;

@end
