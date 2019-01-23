//
//  UserInfoManager.h
//  Management
//
//  Created by 王雷 on 2018/12/11.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const UserInfoAccount; // 用户账户
extern NSString *const UserInfoAccessToken; // 访问令牌

@interface UserInfoManager : NSObject

+(UserInfoManager *)shareInstance;

/*
 登陆时存储 账户 和 令牌
 */
-(BOOL)saveUserInfoAccount:(NSString *)account andAccessToken:(NSString *)accessToken;

/*
 获取用户手机号
 return NSString *account
 */
-(NSString *)achieveUserInfoAccount;

/*
 获取用户访问令牌
 return NSString *accessToken
 */
-(NSString *)achiveUserInfoAccessToken;

/*
 清除用户 账户 和 访问令牌的存储 退出登录时使用
 */
-(void)loginOut;

@end
