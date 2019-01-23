//
//  MenuCell.m
//  Management
//
//  Created by 王雷 on 2018/11/29.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MenuCell.h"

@interface MenuCell ()

@property(nonatomic,strong)UILabel *headLabel;

@end

@implementation MenuCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark - createUI
-(void)createUI
{
    [self headLabel];
}

-(void)setModel:(MenuModel *)model
{
    _model = model;
    _headLabel.text = model.title;
}

#pragma mark - private method
-(void)setCellSelectState:(BOOL)isSelected
{
    if (isSelected) {
        _headLabel.textColor = [UIColor colorWithHexString:@"#3399FF"];
        self.isSelected = YES;
    } else {
        _headLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.isSelected = NO;
    }
    
}

#pragma mark - lazy load
-(UILabel *)headLabel
{
    if (!_headLabel) {
        CGFloat width = 100.0f;
        CGFloat height = 14.0f;
        CGFloat x = (self.contentView.frame.size.width - width) / 2;
        CGFloat y = (self.contentView.frame.size.height - height) / 2;
        _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _headLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _headLabel.textAlignment = NSTextAlignmentCenter;
        _headLabel.font = [UIFont systemFontOfSize:13.0f];
        _headLabel.text = @"发生故障";
        [self.contentView addSubview:_headLabel];
    }
    return _headLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}

@end
