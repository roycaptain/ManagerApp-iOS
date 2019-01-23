//
//  MapTopView.m
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MapTopView.h"
#import "MapLabel.h"

@interface MapTopView ()

@property(nonatomic,strong)UILabel *cutLine;
@property(nonatomic,strong)MapLabel *chargingLabel;
@property(nonatomic,strong)MapLabel *freeLabel;

@end

@implementation MapTopView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self chargingLabel];
        [self cutLine];
        [self freeLabel];
    }
    return self;
}

#pragma mark - private method
-(void)setChargingCount:(NSInteger)chargingCount andFreeCount:(NSInteger)freeCount
{
    [_chargingLabel setCountWithHeadText:@"充电中" withNSInteger:chargingCount];
    [_freeLabel setCountWithHeadText:@"空闲中" withNSInteger:freeCount];
}

#pragma mark - lazy load
-(MapLabel *)chargingLabel
{
    if (!_chargingLabel) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = self.frame.size.width / 2 -0.5;
        CGFloat height = self.frame.size.height;
        
        _chargingLabel = [[MapLabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_chargingLabel setIconWithImageName:@"icon_map_selected"];
        [self addSubview:_chargingLabel];
    }
    return _chargingLabel;
}

-(UILabel *)cutLine
{
    if (!_cutLine) {
        CGFloat x = _chargingLabel.frame.origin.x + _chargingLabel.frame.size.width;
        CGFloat y = 0.0f;
        CGFloat width = 1.0f;
        CGFloat height = self.frame.size.height;
        
        _cutLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _cutLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self addSubview:_cutLine];
    }
    return _cutLine;
}

-(MapLabel *)freeLabel
{
    if (!_freeLabel) {
        CGFloat x = _cutLine.frame.origin.x + _cutLine.frame.size.width;
        CGFloat y = 0.0f;
        CGFloat width = self.frame.size.width / 2 -0.5;
        CGFloat height = self.frame.size.height;
        
        _freeLabel = [[MapLabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_freeLabel setIconWithImageName:@"icon_map_normal"];
        [self addSubview:_freeLabel];
    }
    return _freeLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
