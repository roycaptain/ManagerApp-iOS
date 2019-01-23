//
//  TextTitleField.h
//  Management
//
//  Created by 王雷 on 2018/11/22.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextTitleField : UIView

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UILabel *underLine;

// 设置分割线
-(void)setUnderLine;
// 设置图标
-(void)setTitleWithText:(NSString *)title;
// 设置默认输入文本
-(void)setPlaceHolderText:(NSString *)placeHolder;
// 设置密码输入
-(void)setTextFieldSecureTextEntry;

@end
