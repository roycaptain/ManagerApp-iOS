//
//  Tool.h
//  Management
//
//  Created by 王雷 on 2018/11/22.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tool : NSObject

/*
 根据字符串获取宽度
 @param NSString *string
 @param CGFloat fontSize
 @param CGFloat height
 */
+(CGFloat)calculateStringWidth:(NSString *)string withFontSize:(CGFloat)fontSize withStringHeight:(CGFloat)height;

/*
 根据字符串获取高度
 @param NSString *string
 @param CGFloat fontSize
 @param CGFloat width
 */
+(CGFloat)calculateStringHeight:(NSString *)string withFontSize:(CGFloat)fontSize withStringWidth:(CGFloat)width;

// 验证密码
+(BOOL)checkPasswordInput:(NSString *)password;

// 判断字符串是否为空
+(BOOL)isBlankString:(NSString *)text;

@end
