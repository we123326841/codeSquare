//
//  DropDownMenu.h
//  Caipiao
//
//  Created by CYRUS on 14-7-30.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DropDownMenu;

@protocol DropDownMenuDelegate <NSObject>
@required
- (UITableViewCell *)dropDownMenu:(DropDownMenu *)menu cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (void)dropDownMenu:(DropDownMenu *)menu selectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DropDownMenu : UIView<UITableViewDataSource, UITableViewDelegate>
{
    BOOL _isOpened;
}

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UIImageView *arrow;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (assign, nonatomic) CGFloat menuHeight;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (assign, nonatomic) id <DropDownMenuDelegate> delegate;

- (void)reloadData;
- (void)open;
- (void)close;
- (void)enable:(BOOL)enable;

@end
