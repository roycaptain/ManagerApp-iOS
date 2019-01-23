//
//  ChargeSiteView.h
//  Management
//
//  Created by 王雷 on 2018/11/23.
//  Copyright © 2018 Roy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChargeSiteView : UIView

@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *describeLabel;
@property(nonatomic,copy)NSString *startDescribe;
@property(nonatomic,copy)NSString *endDescribe;

-(void)setIconImageWithImageName:(NSString *)imageName;

-(void)setSiteCountWithCount:(NSInteger)count andCountColor:(NSString *)color;

@end
