//
//  ActualLabel.m
//  Management
//
//  Created by 王雷 on 2018/11/27.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ActualLabel.h"

@implementation ActualLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
    }
    return self;
}

-(void)setLabelTextWithTitle:(NSString *)title withContent:(NSString *)content
{
    NSMutableAttributedString *titleAttri = [[NSMutableAttributedString alloc] initWithString:title];
    [titleAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#333333"],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]} range:NSMakeRange(0, titleAttri.length)];
    
    NSMutableAttributedString *contentAttri = [[NSMutableAttributedString alloc] initWithString:content];
    [contentAttri setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#666666"],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]} range:NSMakeRange(0, contentAttri.length)];
    
    [titleAttri appendAttributedString:contentAttri];
    self.attributedText = titleAttri;
}

@end
