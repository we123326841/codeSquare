//
//  DropDownMenu.m
//  Caipiao
//
//  Created by CYRUS on 14-7-30.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "DropDownMenu.h"

//#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
//#define RADIANS_TO_DEGREES(radians) ((radians)*(180.0/M_PI))

@implementation DropDownMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib
{
    //self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor rgbColorWithHex:@"cccccc"].CGColor;
    
    _dataList = [[NSMutableArray alloc] init];
    _menuHeight = self.bounds.size.height;
    _selectedIndex = 0;
    
    _mainView = [[UIView alloc] initWithFrame:CGRectMake(-5, 0, 330, _menuHeight)];
    [self addSubview:_mainView];
    
    UIImage *arrowImage = ResImage(@"arrow_down.png");
    _arrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 28, self.bounds.size.height/2 - 6/2, 12, 6)];
    _arrow.image = arrowImage;
    [self addSubview:_arrow];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [_mainView addGestureRecognizer:tap];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _menuHeight, self.bounds.size.width, 0)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.alpha = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = Color(@"ViewBGColor");
    [self addSubview:_tableView];
}

- (void)handleTap:(UIGestureRecognizer *)recognizer
{
    if (!_isOpened) [self open];
    else [self close];
}

- (void)open
{
    if (!_isOpened) {
        [UIView animateWithDuration:0.3f animations:^{
            _arrow.transform = CGAffineTransformRotate(_arrow.transform, DEGREES_TO_RADIANS(180));
            CGRect rect = self.frame;
            CGRect tableRect = _tableView.frame;
            CGFloat h = [_dataList count] > 4 ? _menuHeight*4 : _menuHeight*[_dataList count];
            rect.size.height += h;
            self.frame = rect;
            tableRect.size.height += h;
            _tableView.frame = tableRect;
            _tableView.alpha = 1;
        } completion:^(BOOL finished) {
            self.layer.shadowColor = [UIColor rgbColorWithHex:@"e6e6e6"].CGColor;
            self.layer.shadowOffset = CGSizeMake(0, 4.f);
            self.layer.shadowOpacity = 1.0;
            self.layer.shadowRadius = 2.0;
            self.layer.masksToBounds = NO;
            //self.layer.shouldRasterize = YES;
            //self.layer.rasterizationScale = 2.0;
        }];
        _isOpened = YES;
    }
}

- (void)close
{
    if (_isOpened) {
        [UIView animateWithDuration:0.3f animations:^{
            _arrow.transform = CGAffineTransformRotate(_arrow.transform, DEGREES_TO_RADIANS(180));
            CGRect rect = self.frame;
            CGRect tableRect = _tableView.frame;
            rect.size.height = _menuHeight;
            self.frame = rect;
            tableRect.size.height = 0;
            _tableView.frame = tableRect;
            _tableView.alpha = 0;
        } completion:^(BOOL finished) {
            self.layer.shadowColor = [UIColor rgbColorWithHex:@"e6e6e6"].CGColor;
            self.layer.shadowOffset = CGSizeMake(0, 4.f);
            self.layer.shadowOpacity = 0.0;
            self.layer.shadowRadius = 0.0;
            self.layer.masksToBounds = YES;
            //self.layer.shouldRasterize = NO;
            //self.layer.rasterizationScale = 2.0;
        }];
        _isOpened = NO;
    }
}

- (void)reloadData
{
    [_tableView reloadData];
}

- (void)enable:(BOOL)enable
{
    if (enable) {
        self.userInteractionEnabled = YES;
        self.arrow.hidden = NO;
    }else {
        self.userInteractionEnabled = NO;
        self.arrow.hidden = YES;
        [self close];
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [_delegate dropDownMenu:self cellForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _menuHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([_delegate respondsToSelector:@selector(dropDownMenu:selectRowAtIndexPath:)]) {
        [_delegate dropDownMenu:self selectRowAtIndexPath:indexPath];
    }
    [self handleTap:nil];
    _selectedIndex = indexPath.row;
}

@end
