//
//  OverdueModel.h
//  Management
//
//  Created by 王雷 on 2018/12/19.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OverdueModel : NSObject

@property(nonatomic,strong)NSArray *categories;
@property(nonatomic,strong)NSArray *data;
@property(nonatomic,assign)CGFloat viewWidth;
@property(nonatomic,assign)CGFloat viewHeight;

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
