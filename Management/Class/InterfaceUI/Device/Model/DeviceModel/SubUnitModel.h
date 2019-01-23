//
//  SubUnitModel.h
//  Management
//
//  Created by 王雷 on 2018/12/25.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubUnitModel : NSObject

@property(nonatomic,copy)NSString *singleName; // 信号名
@property(nonatomic,copy)NSString *singleValue; // 信号值
@property(nonatomic,assign)BOOL showExpression; // 是否显示曲线表
@property(nonatomic,copy)NSString *singalCode; // 信号码
@property(nonatomic,copy)NSString *createtime; // 时间

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary withInfo:(NSDictionary *)tableInfo;

@end
