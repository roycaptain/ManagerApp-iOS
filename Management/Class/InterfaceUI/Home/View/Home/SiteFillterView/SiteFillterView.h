//
//  SiteFillterView.h
//  Management
//
//  Created by 王雷 on 2018/12/3.
//  Copyright © 2018 Roy. All rights reserved.
//

/*
 站点搜索
 */
#import <UIKit/UIKit.h>

@protocol SiteFilterDelegate <NSObject>

-(void)siteFilterConfirmActionWithAreaID:(NSString *)areaID withAreaLevel:(NSString *)areaLevel withAreaName:(NSString *)areaName;

@end

@interface SiteFillterView : UIView

@property(nonatomic,weak)id<SiteFilterDelegate> delegate;

+(instancetype)initSiteFilterViewWithData:(NSArray *)data withSiteFilterDelegeate:(id<SiteFilterDelegate>)delegate;


@end
