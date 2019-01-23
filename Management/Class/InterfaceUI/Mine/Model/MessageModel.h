//
//  MessageModel.h
//  Management
//
//  Created by 王雷 on 2018/11/22.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *time; // 标题
@property(nonatomic,copy)NSString *content; // 内容

@property(nonatomic,assign)CGFloat contentHeight; // 内容的高度
@property(nonatomic,assign)CGFloat cellHeight; // 行高

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary;

@end
