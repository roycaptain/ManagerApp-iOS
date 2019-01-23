//
//  CustomAlertView.h
//  Management
//
//  Created by 王雷 on 2018/12/11.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomAlertView : NSObject

/*
 只有菊花旋转
 */
+(void)show;

/*
 带转动的圈和文字
 */
+(void)showWithMessage:(NSString *)message;

/*
 隐藏
 */
+(void)hide;

/*
 带感叹号的现实信息
 */
+(void)showWithWarnMessage:(NSString *)text;

/*
 成功
 */
+(void)showWithSuccessMessage:(NSString *)text;

/*
 失败
 */
+(void)showWithFailureMessage:(NSString *)text;

@end
