//
//  WarnView.m
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "WarnView.h"
#import "CircleProgressView.h"
#import "WaveView.h"

@interface WarnView ()

@property(nonatomic,strong)CircleProgressView *circleProgressView;
@property(nonatomic,strong)WaveView *waveView;

@end

@implementation WarnView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3.0f;
        self.layer.masksToBounds = YES;
        
        [self waveView];
        [self circleProgressView];
        
    }
    return self;
}

#pragma mark - private method
-(void)updateProgressWithprogress:(CGFloat)progress withCount:(NSInteger)count
{
    [self.circleProgressView updateProgress:progress widthCount:count];
}

#pragma mark - lazy load
-(WaveView *)waveView
{
    if (!_waveView) {
        CGFloat width = 162.0f;
        CGFloat x = (self.frame.size.width - width) / 2;
        CGFloat y = (self.frame.size.height - width) / 2;
        _waveView = [[WaveView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _waveView.alpha = 10.0f;
        _waveView.kappa = width / 2;
        _waveView.speed = 1.0f;
        _waveView.layer.masksToBounds = YES;
        _waveView.layer.cornerRadius = width / 2;
        [self addSubview:_waveView];
    }
    return _waveView;
}

-(CircleProgressView *)circleProgressView
{
    if (!_circleProgressView) {
        CGFloat progressWidth = 162.0f;
        CGFloat progressX = (self.frame.size.width - progressWidth) / 2;
        CGFloat progressY = (self.frame.size.height - progressWidth) / 2;
        _circleProgressView = [[CircleProgressView alloc] initWithFrame:CGRectMake(progressX, progressY, progressWidth, progressWidth)];
        [self addSubview:_circleProgressView];
    }
    return _circleProgressView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
