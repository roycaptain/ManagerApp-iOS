//
//  RatioView.h
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

/*
 充电桩使用率
 */
#import <UIKit/UIKit.h>

@class RatioModel;

@interface RatioView : UIView

-(void)updateWithRatioModel:(RatioModel *)model;

@end
