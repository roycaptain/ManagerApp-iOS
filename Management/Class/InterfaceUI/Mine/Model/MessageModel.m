//
//  MessageModel.m
//  Management
//
//  Created by 王雷 on 2018/11/22.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    NSString *title = dictionary[@"title"];
    NSString *time = dictionary[@"time"];
    NSString *content = dictionary[@"content"];
    
    MessageModel *model = [[self alloc] init];
    model.title = title;
    model.time = time;
    model.content = content;
    
    // 计算 content 坐标
    CGFloat contentHeight = 0.0f;
    CGFloat contentWidth = [GeneralSize getMainScreenWidth] - 60.0f;
    if (content.length) {
        contentHeight = [Tool calculateStringHeight:content withFontSize:12.0f withStringWidth:contentWidth];
    }
    
    model.contentHeight = contentHeight;
    model.cellHeight = contentHeight + 76.0f;
    
    return model;
}

@end
