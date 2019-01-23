//
//  MessageCell.m
//  Management
//
//  Created by 王雷 on 2018/11/22.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    // timeLabel
    CGFloat timeWidth = 80.0f;
    CGFloat timeHeight = 10.0f;
    CGFloat timeX = [GeneralSize getMainScreenWidth] - timeWidth - 15.0f;
    CGFloat timeY = 26.0f;
    _timeLabel.frame = CGRectMake(timeX, timeY, timeWidth, timeHeight);
    
    // headLabel
    CGFloat headX = 30.0f;
    CGFloat headY = 24.0f;
    CGFloat headWidth = [GeneralSize getMainScreenWidth] - headX - timeWidth - 15.0f;
    CGFloat headHeight = 14.0f;
    _headLabel.frame = CGRectMake(headX, headY, headWidth, headHeight);
    
    // _detailLabel
    CGFloat detailX = 30.0f;
    CGFloat detailY = _headLabel.frame.origin.y + _headLabel.frame.size.height + 14.5f;
    CGFloat detailWidth = [GeneralSize getMainScreenWidth] - detailX * 2;
    CGFloat detailHeight = _model.contentHeight;
    _detailLabel.frame = CGRectMake(detailX, detailY, detailWidth, detailHeight);
}

#pragma mark - initUI
-(void)initUI
{
    [self headLabel];
    [self timeLabel];
    [self detailLabel];
}

-(void)setModel:(MessageModel *)model
{
    _model = model;
    _headLabel.text = model.title;
    _timeLabel.text = model.time;
    _detailLabel.text = model.content;
}

#pragma mark - lazy load
-(UILabel *)headLabel
{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc] init];
        _headLabel.font = [UIFont systemFontOfSize:14.0f];
        _headLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _headLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_headLabel];
    }
    return _headLabel;
}

-(UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12.0f];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.adjustsFontSizeToFitWidth = YES;
        _detailLabel.numberOfLines = 0;
        _detailLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _detailLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:12.0f];
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
