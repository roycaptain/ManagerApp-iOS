//
//  RatioModel.h
//  Management
//
//  Created by 王雷 on 2018/12/19.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RatioModel : NSObject

@property(nonatomic,copy)NSString *total;
@property(nonatomic,strong)NSArray *categories;
@property(nonatomic,strong)NSArray *data;
@property(nonatomic,assign)CGFloat viewHeight;
@property(nonatomic,assign)CGFloat viewWidth;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
