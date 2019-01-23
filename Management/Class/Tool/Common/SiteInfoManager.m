//
//  SiteInfoManager.m
//  Management
//
//  Created by 王雷 on 2018/12/19.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "SiteInfoManager.h"

@interface SiteInfoManager ()

@property(nonatomic,copy)NSString *areaID;
@property(nonatomic,copy)NSString *areaLevel;

@end

@implementation SiteInfoManager

+ (SiteInfoManager *)shareInstance
{
    static SiteInfoManager *singleton = nil;
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
        self.areaID = @"1";
        self.areaLevel = @"ROOT";
    }
    return self;
}

/*
 储存用户筛选的区域信息 areaID areaLevel
 */
-(void)setSiteInfoWithAreaID:(NSString *)areaID withAreaLevel:(NSString *)areaLevel
{
    self.areaID = areaID;
    self.areaLevel = areaLevel;
}

/*
 获取用户储存的 areaID areaLevel
 */
-(NSString *)getSiteInfoWithAreaID
{
    return self.areaID;
}

-(NSString *)getSiteInfoWithAreaLevel
{
    return self.areaLevel;
}

@end
