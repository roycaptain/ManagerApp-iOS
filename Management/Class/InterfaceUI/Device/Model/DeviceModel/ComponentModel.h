//
//  ComponentModel.h
//  Management
//
//  Created by 王雷 on 2018/12/25.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComponentModel : NSObject

@property(nonatomic,copy)NSString *deviceName;
@property(nonatomic,copy)NSAttributedString *deviceTitle; // 子部件名称
@property(nonatomic,copy)NSString *deviceId; // 子设备Id
@property(nonatomic,copy)NSString *deviceFinalId; // 子设备分类Id

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
