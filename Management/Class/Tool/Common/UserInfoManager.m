//
//  UserInfoManager.m
//  Management
//
//  Created by 王雷 on 2018/12/11.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "UserInfoManager.h"

NSString *const UserInfoAccount = @"UserInfoAccount"; // 用户账户
NSString *const UserInfoAccessToken = @"AccessToken"; // 访问令牌

@interface UserInfoManager ()

@property(nonatomic,strong)NSUserDefaults *defaults;

@end

@implementation UserInfoManager

+(UserInfoManager *)shareInstance
{
    static UserInfoManager *singleton = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

/*
 登陆时存储 账户 和 令牌
 */
-(BOOL)saveUserInfoAccount:(NSString *)account andAccessToken:(NSString *)accessToken
{
    [self.defaults setObject:account forKey:UserInfoAccount];
    [self.defaults setObject:accessToken forKey:UserInfoAccessToken];
    return [self.defaults synchronize];
}

/*
 获取用户手机号
 return NSString *account
 */
-(NSString *)achieveUserInfoAccount
{
    return [self.defaults objectForKey:UserInfoAccount];
}

/*
 获取用户访问令牌
 return NSString *accessToken
 */
-(NSString *)achiveUserInfoAccessToken
{
    return [self.defaults objectForKey:UserInfoAccessToken];
}

/*
 清除用户 账户 和 访问令牌的存储 退出登录时使用
 */
-(void)loginOut
{
    NSDictionary *dictionary = [self.defaults dictionaryRepresentation];
    for (id key in dictionary) {
        [self.defaults removeObjectForKey:key];
    }
    [self.defaults synchronize];
}

@end
