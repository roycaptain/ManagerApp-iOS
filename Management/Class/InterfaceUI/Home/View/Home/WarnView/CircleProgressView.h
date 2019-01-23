//
//  CircleProgressView.h
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

/*
 环形进度
 */
#import <UIKit/UIKit.h>

@interface CircleProgressView : UIView

@property(nonatomic,assign)CGFloat progress; // 进度值

-(void)updateProgress:(CGFloat)progress widthCount:(NSInteger)count;

@end
