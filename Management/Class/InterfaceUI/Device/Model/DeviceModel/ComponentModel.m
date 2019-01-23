//
//  ComponentModel.m
//  Management
//
//  Created by 王雷 on 2018/12/25.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ComponentModel.h"

@implementation ComponentModel

+(instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    ComponentModel *model = [[self alloc] init];
    model.deviceName = dictionary[@"deviceName"];
    model.deviceTitle = [self setNormalLabelWithTitle:@"子部件名称: " withContent:dictionary[@"deviceName"]];
    model.deviceId = dictionary[@"deviceId"];
    model.deviceFinalId = dictionary[@"deviceFinalId"];
    
    return model;
}

+(NSAttributedString *)setNormalLabelWithTitle:(NSString *)title withContent:(NSString *)content
{
    NSMutableAttributedString *titleAttri = [[NSMutableAttributedString alloc] initWithString:title];
    [titleAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} range:NSMakeRange(0, titleAttri.length)];
    
    NSMutableAttributedString *contentAttri = [[NSMutableAttributedString alloc] initWithString:content];
    [contentAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"],NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} range:NSMakeRange(0, contentAttri.length)];
    
    [titleAttri appendAttributedString:contentAttri];
    NSAttributedString *result = [titleAttri mutableCopy];
    return result;
}

@end
