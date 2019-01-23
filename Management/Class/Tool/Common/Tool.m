//
//  Tool.m
//  Management
//
//  Created by 王雷 on 2018/11/22.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "Tool.h"

@implementation Tool

/*
 根据字符串获取宽度
 @param NSString *string
 @param NSInteger fontSize
 @param CGFloat height
 */
+(CGFloat)calculateStringWidth:(NSString *)string withFontSize:(CGFloat)fontSize withStringHeight:(CGFloat)height
{
    NSDictionary *dictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string
                   boundingRectWithSize:CGSizeMake(0, height)
                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                   attributes:dictionary context:nil];
    return rect.size.width;
}

/*
 根据字符串获取高度
 @param NSString *string
 @param NSInteger fontSize
 @param CGFloat width
 */
+(CGFloat)calculateStringHeight:(NSString *)string withFontSize:(CGFloat)fontSize withStringWidth:(CGFloat)width
{
    NSDictionary *dictionary = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    CGRect rect = [string
                   boundingRectWithSize:CGSizeMake(width, 0)/*计算高度要先指定宽度*/
                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                   attributes:dictionary context:nil];
    return rect.size.height;
}

// 验证密码
+(BOOL)checkPasswordInput:(NSString *)password
{
    return [self isBlankString:password];
}

/*
 判断字符串是否为空
 空字符串 return YES 否则 return NO
 */
+(BOOL)isBlankString:(NSString *)text
{
    if (!text) {
        return YES;
    }
    if ([text isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [text stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

@end
