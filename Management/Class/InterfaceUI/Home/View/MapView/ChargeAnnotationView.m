//
//  ChargeAnnotationView.m
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ChargeAnnotationView.h"
#import "ChargeAnnotation.h"

CGFloat const width = 21.0f; // 标注的宽度
CGFloat const height = 28.0f; // 标注的高度

@interface ChargeAnnotationView ()

@property(nonatomic,strong)UIImageView *pointView;
@property(nonatomic,strong)ChargeAnnotation *chargeAnnotation;

@end

@implementation ChargeAnnotationView

-(id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bounds = CGRectMake(0.0f, 0.0f, width, height);
        [self pointView];
        
        self.chargeAnnotation = (ChargeAnnotation *)annotation;
        NSString *imageName = self.chargeAnnotation.state ? @"icon_map_selected" : @"icon_map_normal";
        self.pointView.image = [UIImage imageNamed:imageName];
    }
    return self;
}

#pragma mark - lazy load
-(UIImageView *)pointView
{
    if (!_pointView) {
        _pointView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, height)];
        [self addSubview:_pointView];
    }
    return _pointView;
}

-(ChargeAnnotation *)chargeAnnotation
{
    if (!_chargeAnnotation) {
        _chargeAnnotation = [[ChargeAnnotation alloc] init];
    }
    return _chargeAnnotation;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
