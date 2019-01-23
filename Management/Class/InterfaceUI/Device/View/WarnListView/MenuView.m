//
//  MenuView.m
//  Management
//
//  Created by 王雷 on 2018/11/29.
//  Copyright © 2018 Roy. All rights reserved.
//

#import "MenuView.h"
#import "MenuItem.h"
#import "MenuCell.h"
#import "MenuModel.h"

@interface MenuView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)MenuItem *levelItem; // 告警级别
@property(nonatomic,strong)MenuItem *typeItem; // 告警种类
@property(nonatomic,strong)UILabel *underLine; // 分割线

@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,assign)BOOL showFillter; // 是否显示筛选

@property(nonatomic,strong)NSArray *levelData; //
@property(nonatomic,strong)NSArray *typeData;
@property(nonatomic,strong)NSArray *data;

@property(nonatomic,assign)NSInteger levelSelected;
@property(nonatomic,assign)NSInteger typeSelcted;
@property(nonatomic,assign)NSInteger selectedRow;

@property(nonatomic,assign)NSInteger selectBtnTag;

@property(nonatomic,strong)UITableView *fillterTableView;

@end

@implementation MenuView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

#pragma mark - createUI
-(void)createUI
{
    [self levelItem];
    [self typeItem];
    [self underLine];
    
    [self baseView];
    
    self.showFillter = NO;
    
    self.levelData = [MenuModel initWarnLevelData];
    self.typeData = [MenuModel initWarnTypeData];
    [self data];
    
    self.levelSelected = 0;
    self.typeSelcted = 0;
    self.selectedRow = 0;
    self.selectBtnTag = 0;
}

#pragma mark - click action
-(void)menuItemClickAction:(MenuItem *)menuItem
{
    if ([menuItem isEqual:_levelItem]) {
        _data = _levelData;
        _selectedRow = _levelSelected;
        _selectBtnTag = 1;
    } else {
        _data = _typeData;
        _selectedRow = _typeSelcted;
        _selectBtnTag = 2;
    }
    
    [self setMenuItemStatu:menuItem];
    
    if (menuItem.selected) {
        [self presentFillterView];
    } else {
        [self dissFillterView];
    }
}

// 点击按钮时的效果
-(void)setMenuItemStatu:(MenuItem *)menuItem
{
    if ([menuItem isEqual:_levelItem]) {
        [_levelItem setItemSelectState:!menuItem.selected];
        if (_typeItem.selected) {
            [_typeItem setItemSelectState:NO];
        }
    }
    if ([menuItem isEqual:_typeItem]) {
        [_typeItem setItemSelectState:!_typeItem.selected];
        if (_levelItem.selected) {
            [_levelItem setItemSelectState:NO];
        }
    }
}

-(void)presentFillterView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + 44.0f + self.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y;
        weakSelf.baseView.frame = CGRectMake(x, y, width, height);
        [weakSelf.baseView addSubview:weakSelf.fillterTableView];
        [weakSelf.fillterTableView reloadData];
    }];
}

-(void)dissFillterView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        [weakSelf.fillterTableView removeFromSuperview];
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + 44.0f + self.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 0.0f;
        weakSelf.baseView.frame = CGRectMake(x, y, width, height);
    }];
}

-(void)hideFillterView
{
    if (_selectBtnTag == 1) {
        [_levelItem setItemSelectState:!_levelItem.selected];
        if (_typeItem.selected) {
            [_typeItem setItemSelectState:NO];
        }
    }
    if (_selectBtnTag == 2) {
        [_typeItem setItemSelectState:!_typeItem.selected];
        if (_levelItem.selected) {
            [_levelItem setItemSelectState:NO];
        }
    }
    [self dissFillterView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    if ([touch.view isEqual:_baseView]) {
        [self dissFillterView];
    }
}


#pragma mark - lazy load
-(MenuItem *)levelItem
{
    if (!_levelItem) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = self.frame.size.width / 2;
        CGFloat height = 44.0f;
        _levelItem = [[MenuItem alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_levelItem setHeadLabelTitle:@"告警级别"];
        [_levelItem addTarget:self action:@selector(menuItemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_levelItem];
    }
    return _levelItem;
}

-(MenuItem *)typeItem
{
    if (!_typeItem) {
        CGFloat x = self.frame.size.width / 2;
        CGFloat y = 0.0f;
        CGFloat width = self.frame.size.width / 2;
        CGFloat height = 44.0f;
        _typeItem = [[MenuItem alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [_typeItem setHeadLabelTitle:@"告警种类"];
        [_typeItem addTarget:self action:@selector(menuItemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_typeItem];
    }
    return _typeItem;
}

-(UILabel *)underLine
{
    if (!_underLine) {
        CGFloat width = self.frame.size.width;
        CGFloat height = 0.5f;
        CGFloat x = 0.0f;
        CGFloat y = self.frame.size.height - height;
        _underLine = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _underLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        [self addSubview:_underLine];
    }
    return _underLine;
}

-(UIView *)baseView
{
    if (!_baseView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + 44.0f + self.frame.size.height;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = 0.0f;
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _baseView.backgroundColor = [[UIColor colorWithHexString:@"#12131A"] colorWithAlphaComponent:0.6f];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_baseView];
    }
    return _baseView;
}

-(UITableView *)fillterTableView
{
    if (!_fillterTableView) {
        CGFloat x = 0.0f;
        CGFloat y = 0.0f;
        CGFloat width = _baseView.frame.size.width;
        CGFloat height = 200.0f;
        _fillterTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _fillterTableView.delegate = self;
        _fillterTableView.dataSource = self;
        _fillterTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _fillterTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _fillterTableView;
}

-(NSArray *)levelData
{
    if (!_levelData) {
        _levelData = [[NSArray alloc] init];
    }
    return _levelData;
}

-(NSArray *)typeData
{
    if (!_typeData) {
        _typeData = [[NSArray alloc] init];
    }
    return _typeData;
}

-(NSArray *)data
{
    if (!_data) {
        _data = [[NSArray alloc] init];
    }
    return _data;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FillterCellIdentifier = @"FillterCellIdentifier";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:FillterCellIdentifier];
    if (cell == nil) {
        cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FillterCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = _data[indexPath.row];
    
    if (indexPath.row == _selectedRow) {
        [cell setCellSelectState:YES];
    } else {
        [cell setCellSelectState:NO];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != _selectedRow) {
        MenuCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell setCellSelectState:!cell.selected];
        _selectedRow = indexPath.row;
        if (_selectBtnTag == 1) {
            _levelSelected = _selectedRow;
        } else {
            _typeSelcted = _selectedRow;
        }
        [_fillterTableView reloadData];
    }
    // 隐藏
    [self hideFillterView];
    NSLog(@" tag - %ld indexPath - %ld",(long)_selectBtnTag,(long)indexPath.row);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
