//
//  WaveView.h
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

/*
 波浪效果
 */
#import <UIKit/UIKit.h>

@interface WaveView : UIView

@property (nonatomic, assign) CGFloat alpha; // 振幅A
@property (nonatomic, assign) CGFloat omega; // 角速度ω
@property (nonatomic, assign) CGFloat phi; //初相φ
@property (nonatomic, assign) CGFloat kappa; //偏距k
@property (nonatomic, assign) CGFloat speed; // 移动速度

@end
