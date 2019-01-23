//
//  ChargeCapacityView.h
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

/*
 累计充电量
 */
#import <UIKit/UIKit.h>
@class ChargeQuantityModel;

@interface ChargeCapacityView : UIView

-(void)updateCapacityWithChargeQuantity:(ChargeQuantityModel *)model;

@end
