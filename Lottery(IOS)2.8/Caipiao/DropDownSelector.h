//
//  DropDownSelector.h
//  Caipiao - A simple drop down list selector
//
//  Created by danal-rich on 8/5/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownSelector : UIView <UITableViewDataSource,UITableViewDelegate>
{
    UITableView     *_tableView;
    UIView          *_maskView;
}
@property (nonatomic, strong) NSArray *rowTitles;
@property (nonatomic, copy) void(^selectBlock)(DropDownSelector *selector, NSInteger row);

/**
 * Show to a attached view
 */
- (void)attachToView:(UIView *)view;

/**
 * Dismiss from the screen
 */
- (void)dismiss;

@end
