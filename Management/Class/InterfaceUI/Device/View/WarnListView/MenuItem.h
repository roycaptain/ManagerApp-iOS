//
//  MenuItem.h
//  Management
//
//  Created by 王雷 on 2018/11/29.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItem : UIButton

-(void)setHeadLabelTitle:(NSString *)text;
-(void)setItemSelectState:(BOOL)isSelect;

@end

