//
//  MapLabel.m
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MapLabel.h"

@interface MapLabel ()

@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *label;

@end

@implementation MapLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self icon];
        [self label];
    }
    return self;
}

#pragma mark - private method
-(void)setIconWithImageName:(NSString *)imageName
{
    _icon.image = [UIImage imageNamed:imageName];
}

-(void)setCountWithHeadText:(NSString *)text withNSInteger:(NSInteger)count
{
    NSMutableAttributedString *firstAttri = [[NSMutableAttributedString alloc] initWithString:text];
    [firstAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]} range:NSMakeRange(0, firstAttri.length)];

    NSString *countStr = [NSString stringWithFormat:@" %ld ",(long)count];
    NSMutableAttributedString *secondAttri = [[NSMutableAttributedString alloc] initWithString:countStr];
    [secondAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#3399FF"],NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:14.0f]} range:NSMakeRange(0, secondAttri.length)];

    NSMutableAttributedString *thirdAttri = [[NSMutableAttributedString alloc] initWithString:@"个"];
    [thirdAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"],NSFontAttributeName : [UIFont systemFontOfSize:14.0F]} range:NSMakeRange(0, thirdAttri.length)];

    [firstAttri appendAttributedString:secondAttri];
    [firstAttri appendAttributedString:thirdAttri];

    _label.attributedText = firstAttri;
}

#pragma mark - lazy load
-(UIImageView *)icon
{
    if (!_icon) {
        CGFloat width = 15.0f;
        CGFloat height = 20.0f;
        CGFloat x = 46.0f;
        CGFloat y = (self.frame.size.height - height) / 2;
        
        _icon = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_icon];
    }
    return _icon;
}

-(UILabel *)label
{
    if (!_label) {
        CGFloat width = 100.0f;
        CGFloat height = 15.0f;
        CGFloat x = _icon.frame.origin.x + _icon.frame.size.width + 5.0f;
        CGFloat y = (self.frame.size.height - height) / 2;
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_label];
    }
    return _label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
