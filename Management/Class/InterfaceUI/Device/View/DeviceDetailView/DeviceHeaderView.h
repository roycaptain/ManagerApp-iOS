//
//  DeviceHeaderView.h
//  Management
//
//  Created by 王雷 on 2018/11/28.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceHeaderView : UIView

-(void)setDeviceName:(NSString *)deviceName andParentAreaName:(NSString *)parentAreaName;
-(void)setWarnCount:(NSString *)warnCount andCategories:(NSArray *)categories andData:(NSArray *)data;

-(void)setFillterClickWithTarget:(id)target withAction:(SEL)buttonAction;

@end
