//
//  GreenBar.h
//  Caipiao
//
//  Created by Cyrus on 13-6-14.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopMenu.h"

#pragma mark - GBScrollView

@protocol GBScrollViewDelegate <NSObject>

- (void)gbScrollView:(id)scroll touchLocationX:(float)x;

@end

@interface GBScrollView : UIScrollView

@property (assign, nonatomic) id<GBScrollViewDelegate> customDelegate;

@end

#pragma mark - GreenBar

#define COLOR_NORMAL [UIColor rgbColorWithR:255 G:196 B:16 alpha:1]
#define COLOR_HIGHLIGHTED [UIColor rgbColorWithHex:@"#002F1C"]

@protocol GreenBarDelegate <NSObject>
- (void)greenBar:(id)bar didSelectedAtIndex:(NSInteger)index;
@end
@protocol GreenBarDataSource <NSObject>
/**
 * 提供下拉子标题
 * @param bar GreenBar
 * @param index The item index
 * @return titles
 */
- (NSArray *)greenBar:(id)bar subtitlesForItemAtIndex:(NSInteger)index;
- (void)greenBar:(id)bar didSelectSubtitleAtIndex:(NSInteger)index;
- (void)greenBar:(id)bar didShowSubmenu:(PopMenu *)menu;
@end

@interface GreenBar : UIView<GBScrollViewDelegate>
{
    UIView *_popMenu;
}
@property (assign, nonatomic) int selectedIndex;
@property (assign, nonatomic) int numberOfButton;
@property (strong, nonatomic) UIImageView *selectedImageView;
@property (strong, nonatomic) GBScrollView *scroll;
@property (assign, nonatomic) id<GreenBarDelegate> delegate;
@property (assign, nonatomic) id<GreenBarDataSource> dataSource;
@property (assign, nonatomic) UIView *submenuMask;      //空白区域遮罩

/**
 * 添加一个item
 * @param text 标题
 * @param isSelected 是否选中
 * @param index 位置索引
 */
- (void)greenBarLabelWithTitle:(NSString *)text isSelected:(BOOL)isSelected byIndex:(NSInteger)index;

/**
 * 关闭子菜单
 */
- (void)closeSubmenu;

@end

