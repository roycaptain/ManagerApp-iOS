//
//  SiteInfoManager.h
//  Management
//
//  Created by 王雷 on 2018/12/19.
//  Copyright © 2018 Roy. All rights reserved.
//

/*
 区域筛选信息储存单例
 */
#import <Foundation/Foundation.h>

@interface SiteInfoManager : NSObject

+(SiteInfoManager *)shareInstance;

/*
 储存用户筛选的区域信息 areaID areaLevel
 */
-(void)setSiteInfoWithAreaID:(NSString *)areaID withAreaLevel:(NSString *)areaLevel;

/*
 获取用户储存的 areaID areaLevel
 */
-(NSString *)getSiteInfoWithAreaID;

-(NSString *)getSiteInfoWithAreaLevel;

@end
