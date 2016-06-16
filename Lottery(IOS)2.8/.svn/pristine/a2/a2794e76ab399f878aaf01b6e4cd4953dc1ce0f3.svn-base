//
//  NavTitleMenu.h
//  Caipiao
//
//  Created by danal on 13-1-7.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchLabel.h"

@protocol NavTitileMenuDelegate;

@interface NavTitleMenu : UIView {
    UIImageView *_bg;
    UIView *_mask;
    CGRect _origFrame;
    BOOL _opened;
    id _target;
    SEL _selector;
    NSInteger _lastIndex;
}
@property (assign, nonatomic) id<NavTitileMenuDelegate> delegate;
@property (strong ,nonatomic) NSArray *titles;
@property (nonatomic) BOOL opened;
@property (readonly, nonatomic) NSInteger lastIndex;
@property (assign, nonatomic) NSInteger selectedIndex;

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
- (void)addTarget:(id)target selector:(SEL)selector;
- (void)selectItemAtIndex:(NSInteger)index;
- (void)selectItemForTitle:(NSString *)title;
- (void)showInView:(UIView *)view;
- (void)dismiss;
- (void)commit;
- (void)rollback;

@end

@interface NavTitleControl : TouchLabel
@property (nonatomic) BOOL opened;
@property (nonatomic) BOOL hideIcon;
@end

@protocol NavTitileMenuDelegate <NSObject>
@optional
- (void)navTitleMenuSelectedIndexUpdated:(int)selectedIndex;

@end