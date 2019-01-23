//
//  ChargeSiteView.m
//  Management
//
//  Created by 王雷 on 2018/11/23.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ChargeSiteView.h"

@implementation ChargeSiteView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 3.0f;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        
        [self createUI];
    }
    return self;
}

#pragma mark - createUI
-(void)createUI
{
    [self iconImageView];
    [self describeLabel];
}

#pragma mark - private method
-(void)setIconImageWithImageName:(NSString *)imageName
{
    _iconImageView.image = [UIImage imageNamed:imageName];
}

-(void)setSiteCountWithCount:(NSInteger)count andCountColor:(NSString *)color
{
    NSMutableAttributedString *firstAttri = [[NSMutableAttributedString alloc] initWithString:_startDescribe];
    [firstAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:12.0f]} range:NSMakeRange(0, firstAttri.length)];
    
    NSString *countStr = [NSString stringWithFormat:@" %ld ",(long)count];
    NSMutableAttributedString *secondAttri = [[NSMutableAttributedString alloc] initWithString:countStr];
    [secondAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:color],NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:18.0f]} range:NSMakeRange(0, secondAttri.length)];
    
    NSMutableAttributedString *thirdAttri = [[NSMutableAttributedString alloc] initWithString:_endDescribe];
    [thirdAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor],NSFontAttributeName : [UIFont systemFontOfSize:12.0F]} range:NSMakeRange(0, thirdAttri.length)];
    
    [firstAttri appendAttributedString:secondAttri];
    [firstAttri appendAttributedString:thirdAttri];
    
    _describeLabel.attributedText = firstAttri;    
}

#pragma mark - lazy load
-(UIImageView *)iconImageView
{
    if (!_iconImageView) {
        CGFloat width = 50.0f;
        CGFloat y = 25.0f;
        CGFloat x = (self.frame.size.width - width) / 2;
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}

-(UILabel *)describeLabel
{
    if (!_describeLabel) {
        CGFloat x = 0.0f;
        CGFloat y = _iconImageView.frame.origin.y + _iconImageView.frame.size.height + 17.0f;
        CGFloat width = self.frame.size.width;
        CGFloat height = 14.0f;
        
        _describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _describeLabel.textAlignment = NSTextAlignmentCenter;
        _describeLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_describeLabel];
    }
    return _describeLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
