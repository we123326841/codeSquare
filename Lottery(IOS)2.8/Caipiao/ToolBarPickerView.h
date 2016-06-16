//
//  ToolBarPickerView.h
//  Caipiao
//
//  Created by Cyrus on 13-6-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDSSC.h"

@interface ToolBarPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) UIPickerView *picker;
@property (strong, nonatomic) NSMutableArray *listArray;
@property (strong, nonatomic) UIButton *confirmButton;
@property (strong, nonatomic) UIButton *backgroundButton;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (copy, nonatomic) void (^selectRowBlock) (ToolBarPickerView *toolBar, CDSSC *model);

- (void)toolBarDidSelectRowWithBlock:(void (^) (ToolBarPickerView *toolBar, CDSSC *model))block;
- (void)dismiss;

@end
