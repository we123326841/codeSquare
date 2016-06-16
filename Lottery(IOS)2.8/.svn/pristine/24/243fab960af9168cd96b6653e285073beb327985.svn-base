//
//  MSSegmentBar.h
//  Caipiao
//
//  Created by danal-rich on 7/29/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 * Segmented bar for text segment
 */
@interface MSSegmentBar : UIControl{
    UIView *_indicator;
}
@property (nonatomic, assign) UIView *indicator;
@property (nonatomic,readonly, strong) NSArray *buttons;         //Segmented buttons
@property (nonatomic, assign) CGFloat indicatorInset;           //Default is 0.f
@property (nonatomic, assign) NSInteger selectedIndex;          //The selected button index
@property (nonatomic, strong) UIColor *highlightColor, *normalColor;

- (id)initWithFrame:(CGRect)frame buttons:(NSArray *)buttons;

@end


/**
 * The segment button
 */
typedef UIButton MSSegmentButton;


/**
 * The indicator under current segment button
 */
typedef UIImageView MSSegmentIndicator;


/**
 * Segmented view that can slide
 */
@interface MSSegmentView : UIView <UIScrollViewDelegate>{
    UIScrollView *_scroll;
}
@property (nonatomic, assign) IBOutlet id delegate;  /* MSSegmentViewDelegate */
@property (nonatomic, assign) IBOutlet MSSegmentBar *segmentBar;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, assign) NSInteger currentPage;
@end

@protocol MSSegmentViewDelegate <NSObject>
/**
 * Return number of total pages
 */
- (NSInteger)segmentViewNumberOfPages;
/**
 * Return the content view at the specified page
 */
- (UIView *)segmentView:(MSSegmentView *)segView contentViewAtPage:(NSInteger)page;
/**
 * Callback when scroll to a new page
 */
- (void)segmentViewDidScrollToPage:(MSSegmentView *)view page:(NSInteger)page;
@end

