//
//  MapController.m
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MapController.h"
#import "MapTopView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "ChargeAnnotationView.h"
#import "ChargeAnnotation.h"

@interface MapController ()<MAMapViewDelegate>

@property(nonatomic,strong)MapTopView *topView;
@property(nonatomic,strong)MAMapView *mapView;

@end

@implementation MapController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];

    
    [self startRequestMapInfo];
}

#pragma mark - createUI
-(void)createUI
{
    [super setNavigationBarBackItem];
    self.tabBarController.tabBar.hidden = YES;
    
    [self topView];
    [self mapView];
    [_topView setChargingCount:0 andFreeCount:0];
}

#pragma mark - private method
-(void)startRequestMapInfo
{
    NSString *accessToken = [NSString stringWithFormat:@"Bearer %@",[[UserInfoManager shareInstance] achiveUserInfoAccessToken]];
    NSDictionary *headerDictionary = @{@"Authorization" : accessToken};
    NSDictionary *bodyDictionary = @{@"id" : [[SiteInfoManager shareInstance] getSiteInfoWithAreaID],@"level" : [[SiteInfoManager shareInstance] getSiteInfoWithAreaLevel]};
    
    __weak typeof(self) weakSelf = self;
    [CustomAlertView show];
    [[NetworkRequest shareInstance] requestGETWithURLString:URLInterfaceMapInfo WithHTTPHeaderFieldDictionary:headerDictionary withParamDictionary:bodyDictionary successful:^(NSDictionary *resultDictionary) {
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        if ([code integerValue] == RequestAccessTokenLose) {
            [CustomAlertView showWithWarnMessage:msg];
            [super redirectTargetLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        NSDictionary *data = resultDictionary[@"data"];
        NSArray *chargeringStations = data[@"chargeringStations"];
        NSArray *notChargerStations = data[@"notChargerStations"];
        NSMutableArray *stationAnnotations = [[NSMutableArray alloc] init];
        
        if (chargeringStations.count > 0) {
            for (NSDictionary *dictionary in chargeringStations) {
                ChargeAnnotation *annotation = [[ChargeAnnotation alloc] initWithAnnotationModelWithDict:dictionary withState:1];
                [stationAnnotations addObject:annotation];
            }
        }
        if (notChargerStations.count > 0) {
            for (NSDictionary *dictionary in notChargerStations) {
                ChargeAnnotation *annotation = [[ChargeAnnotation alloc] initWithAnnotationModelWithDict:dictionary withState:0];
                [stationAnnotations addObject:annotation];
            }
        }
        if (stationAnnotations.count == 0) {
            [CustomAlertView showWithWarnMessage:@"暂无数据"];
            return;
        }
        ChargeAnnotation *centerAnnotation = stationAnnotations[0];
        weakSelf.mapView.centerCoordinate = CLLocationCoordinate2DMake(centerAnnotation.coordinate.latitude, centerAnnotation.coordinate.longitude);
        [weakSelf.topView setChargingCount:chargeringStations.count andFreeCount:notChargerStations.count];
        [weakSelf.mapView addAnnotations:[stationAnnotations mutableCopy]];
        
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - lazy load
-(MapTopView *)topView
{
    if (!_topView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 44.0f;

        _topView = [[MapTopView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self.view addSubview:_topView];
    }
    return _topView;
}

-(MAMapView *)mapView
{
    if (!_mapView) {
        CGFloat x = 0.0f;
        CGFloat y = _topView.frame.origin.y + _topView.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y;
        
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _mapView.delegate = self;
        [self.view addSubview:_mapView];
    }
    return _mapView;
}

#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAUserLocation class]]) { // 显示定位蓝点
        return nil;
    }
    if ([annotation isKindOfClass:[ChargeAnnotation class]]) {
        static NSString *ChargeAnnotationIndentifier = @"ChargeAnnotationIndentifier";
        ChargeAnnotationView *chargeAnnotation = (ChargeAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ChargeAnnotationIndentifier];
        if (chargeAnnotation == nil) {
            chargeAnnotation = [[ChargeAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ChargeAnnotationIndentifier];
            chargeAnnotation.canShowCallout= NO;       //设置气泡可以弹出，默认为NO
            chargeAnnotation.draggable = NO;        //设置标注可以拖动，默认为NO
        }
        
        chargeAnnotation.imageView.image = [UIImage imageNamed:@"icon_map_selected"];
        
        return chargeAnnotation;
    }
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
