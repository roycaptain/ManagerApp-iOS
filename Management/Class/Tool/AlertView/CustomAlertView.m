//
//  CustomAlertView.m
//  Management
//
//  Created by 王雷 on 2018/12/11.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "CustomAlertView.h"
#import "SVProgressHUD.h"

@implementation CustomAlertView

/*
 只有菊花旋转
 */
+(void)show
{
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexString:@"#35B5FF"]];
    [SVProgressHUD show];
}

/*
 带转动的圈和文字
 */
+(void)showWithMessage:(NSString *)message
{
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexString:@"#35B5FF"]];
    [SVProgressHUD showWithStatus:message];
}

/*
 隐藏
 */
+(void)hide
{
    [SVProgressHUD dismiss];
}

/*
 带感叹号的现实信息
 */
+(void)showWithWarnMessage:(NSString *)text
{
    [SVProgressHUD showInfoWithStatus:text];
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexString:@"#35B5FF"]];
    [SVProgressHUD dismissWithDelay:1.0f];
}

/*
 成功
 */
+(void)showWithSuccessMessage:(NSString *)text
{
    [SVProgressHUD showSuccessWithStatus:text];
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexString:@"#35B5FF"]];
    [SVProgressHUD dismissWithDelay:1.0f];
}

/*
 失败
 */
+(void)showWithFailureMessage:(NSString *)text
{
    [SVProgressHUD showErrorWithStatus:text];
    [SVProgressHUD setForegroundColor:[UIColor colorWithHexString:@"#35B5FF"]];
    [SVProgressHUD dismissWithDelay:1.0f];
}

@end
