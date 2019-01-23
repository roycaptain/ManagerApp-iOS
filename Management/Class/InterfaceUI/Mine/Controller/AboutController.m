//
//  AboutController.m
//  Management
//
//  Created by 王雷 on 2018/11/22.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "AboutController.h"

@interface AboutController ()

@property(nonatomic,strong)UIImageView *logoImageView;

@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"关于平台"];
    [super setNavigationBarTitleFontSize:16.0f andFontColor:@"#FFFFFF"];
    
    [self logoImageView];
}

#pragma mark - lazy load
-(UIImageView *)logoImageView
{
    if (!_logoImageView) {
        CGFloat width = 100.0f;
        CGFloat x = ([GeneralSize getMainScreenWidth] - width) / 2;
        CGFloat y = 90.0f;
        
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, width)];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _logoImageView.backgroundColor = [UIColor redColor];
        [self.view addSubview:_logoImageView];
    }
    return _logoImageView;
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
