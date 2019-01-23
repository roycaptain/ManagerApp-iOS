//
//  TextInputView.h
//  Management
//
//  Created by 王雷 on 2018/11/21.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextInputView : UIView

@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,strong)UILabel *underLine;
@property(nonatomic,strong)UIButton *identifyCodeBtn;

// 设置分割线
-(void)setUnderLine;
// 设置图标
-(void)setIconWithImageName:(NSString *)imageName;
// 设置默认输入文本
-(void)setPlaceHolderText:(NSString *)placeHolder;
// 设置获取验证码按钮
-(void)setIdntifyCodeBtn;

@end
