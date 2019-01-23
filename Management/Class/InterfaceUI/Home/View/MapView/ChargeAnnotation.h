//
//  ChargeAnnotation.h
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

@interface ChargeAnnotation : NSObject<MAAnnotation>

@property(nonatomic,assign)CLLocationCoordinate2D coordinate; // 坐标
@property(nonatomic,assign)NSInteger state; // 状态 1 充电中 0 空闲中

- (instancetype)initWithAnnotationModelWithDict:(NSDictionary *)dictionary withState:(NSInteger)state;

@end
