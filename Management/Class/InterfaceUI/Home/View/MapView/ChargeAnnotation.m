//
//  ChargeAnnotation.m
//  Management
//
//  Created by 王雷 on 2018/11/26.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "ChargeAnnotation.h"

@implementation ChargeAnnotation

- (instancetype)initWithAnnotationModelWithDict:(NSDictionary *)dictionary withState:(NSInteger)state
{
    self = [super init];
    if (self) {
        self.coordinate = CLLocationCoordinate2DMake([dictionary[@"latitude"] doubleValue], [dictionary[@"longitude"] doubleValue]);
        self.state = state;
    }
    return self;
}

@end
