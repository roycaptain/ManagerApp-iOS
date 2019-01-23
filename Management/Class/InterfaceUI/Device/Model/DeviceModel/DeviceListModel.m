//
//  DeviceListModel.m
//  Management
//
//  Created by 王雷 on 2018/12/20.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "DeviceListModel.h"

@implementation DeviceListModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dictionary
{
    DeviceListModel *model = [[self alloc] init];
    
    NSInteger warn = [dictionary[@"warn"] boolValue];
    
    model.deviceName = dictionary[@"deviceName"];
    model.deviceId = [NSString stringWithFormat:@"%@",dictionary[@"deviceId"]];
    model.warn = warn ? @"是" : @"否";
    model.deviceSerialNum = dictionary[@"deviceSerialNum"];
    
    NSString *status = dictionary[@"deviceStatus"];
    if ([status  isEqualToString: @"NOT_CONN"]) {
        model.deviceStatus = [self setStatusLabelWithContent:@"未连接" withColor:@"#FF3333"];
    } else if ([status isEqualToString:@"NORMAL_CONN"]) {
        model.deviceStatus = [self setStatusLabelWithContent:@"连接正常" withColor:@"#3399FF"];
    } else if ([status isEqualToString:@"DIS_CONN"]) {
        model.deviceStatus = [self setStatusLabelWithContent:@"断连" withColor:@"#FF3333"];
    } else {
        model.deviceStatus = [self setStatusLabelWithContent:@"无法适配" withColor:@"#FF3333"];
    }
    
    model.warnLevel = warn ? [NSString stringWithFormat:@"%@",dictionary[@"warnLevel"]] : @"正常";
    model.warnColor = warn ? @"#FF3333" : @"#3399FF";
    
//    NSString *warnLevel = dictionary[@"warnLevel"];
//    if ([warnLevel isEqualToString:@"00"] || [warnLevel isEqualToString:@"正常"]) {
//        model.warnLevel = @"正常";
//        model.warnColor = @"#3399FF";
//    } else if ([warnLevel isEqualToString:@"01"] || [warnLevel isEqualToString:@"提示"]) {
//        model.warnLevel = @"提示";
//        model.warnColor = @"#3399FF";
//    } else if ([warnLevel isEqualToString:@"02"] || [warnLevel isEqualToString:@"重要"]) {
//        model.warnLevel = @"重要";
//        model.warnColor = @"#FF9900";
//    } else {
//        model.warnLevel = @"严重";
//        model.warnColor = @"#FF3333";
//    }
    
    return model;
}

+(NSAttributedString *)setStatusLabelWithContent:(NSString *)content withColor:(NSString *)color
{
    NSMutableAttributedString *titleAttri = [[NSMutableAttributedString alloc] initWithString:@"设备状态: "];
    [titleAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]} range:NSMakeRange(0, titleAttri.length)];
    
    NSMutableAttributedString *contentAttri = [[NSMutableAttributedString alloc] initWithString:content];
    [contentAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:color],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]} range:NSMakeRange(0, contentAttri.length)];
    
    
    [titleAttri appendAttributedString:contentAttri];
    NSAttributedString *result = [titleAttri mutableCopy];
    return result;
}

@end
