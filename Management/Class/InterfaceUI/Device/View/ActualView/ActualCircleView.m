//
//  ActualCircleView.m
//  Management
//
//  Created by 王雷 on 2018/11/27.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ActualCircleView.h"

@interface ActualCircleView ()

@property(nonatomic,strong)UIImageView *backgroundImage;
@property(nonatomic,strong)UILabel *dataLabel;
@property(nonatomic,strong)UILabel *detailLabel;

@end

@implementation ActualCircleView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

#pragma mark - private method
-(void)setBackgroundImageWithImageName:(NSString *)imageName
{
    _backgroundImage.image = [UIImage imageNamed:imageName];
}

-(void)setDataLabelWithText:(NSString *)text
{
    _dataLabel.text = text;
}

-(void)setDetailLabelWithText:(NSString *)text
{
    _detailLabel.text = text;
}

#pragma mark - createUI
-(void)createUI
{
    [self backgroundImage];
    [self dataLabel];
    [self detailLabel];
}

#pragma mark - lazy load
-(UIImageView *)backgroundImage
{
    if (!_backgroundImage) {
        CGFloat width = 70.0f;
        CGFloat x = (self.frame.size.width - width) / 2;
        CGFloat y = 0.0f;
        _backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        [self addSubview:_backgroundImage];
    }
    return _backgroundImage;
}

-(UILabel *)dataLabel
{
    if (!_dataLabel) {
        CGFloat x = 10.0f;
        CGFloat width = _backgroundImage.frame.size.width - x * 2;
        CGFloat height = 20.0f;
        CGFloat y = (_backgroundImage.frame.size.height - height) / 2;
        _dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _dataLabel.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _dataLabel.font = [UIFont systemFontOfSize:24.0f];
        _dataLabel.textAlignment = NSTextAlignmentCenter;
        _dataLabel.adjustsFontSizeToFitWidth = YES;
        [_backgroundImage addSubview:_dataLabel];
    }
    return _dataLabel;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        CGFloat width = self.frame.size.width;
        CGFloat height = 12.0f;
        CGFloat x = 0.0f;
        CGFloat y = _backgroundImage.frame.origin.y + _backgroundImage.frame.size.height + 8.0f;
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _detailLabel.textColor = [UIColor grayColor];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font = [UIFont systemFontOfSize:10.0f];
        _detailLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_detailLabel];
    }
    return _detailLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
