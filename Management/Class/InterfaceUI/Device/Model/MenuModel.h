//
//  MenuModel.h
//  Management
//
//  Created by 王雷 on 2018/11/29.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject

@property(nonatomic,copy)NSString *title;

+(NSArray *)initWarnLevelData;

+(NSArray *)initWarnTypeData;

@end
