//
//  MethodView.h
//  Caipiao
//
//  Created by danal-rich on 8/4/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MethodMenuItem, MethodView, MethodPanelView;

@protocol  MethodItemClickDelegate <NSObject>
- (void)onMethodItemClick:(NSString *)methodName view:(MethodView *)methodView;
@end


/**
 * Recently played methods
 */
@interface MethodView : UIView {
    UIScrollView *_scroll;
    UIView  *_lastSelected;
    UIView  *_curSelected;
    NSArray *_methodItems;
    
    MethodPanelView  *_panelView;
}
@property (nonatomic, assign) UIScrollView *scroll;
@property (nonatomic, assign) id<MethodItemClickDelegate> delegate;
@property (nonatomic, strong) NSArray *recentItemNames;
@property (nonatomic, strong) NSArray *methodItems; //All items
@property (nonatomic, copy) NSString *selectedMethodName;

- (void)updateDisplay;

/**
 * Rollback the selected item to the last selected
 */
- (void)commit;

/**
 * Update the last selectd as the current selected item
 */
- (void)rollback;

/**
 * Open or close the method panel
 */
- (BOOL)togglePanel;

- (void)showItemHighlightAtIndex:(NSInteger)index;
@end


/**
 * All methods
 */
@interface MethodPanelView : MethodView {
    UIView  *_maskView;
}
@property (nonatomic, assign) UIView *maskView;
@property (nonatomic, assign, readonly) CGFloat actualHeight;
@property (nonatomic) BOOL opened;
@end

@interface MethodButton : UIButton
@property (nonatomic, assign) MethodMenuItem *methodMenuItem;
@end