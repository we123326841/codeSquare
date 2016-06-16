//
//  CycleScrollView.h
//  Caipiao
//
//  Created by cYrus_c on 13-11-18.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControl.h"

@protocol CycleScrollViewDelegate;
@protocol CycleScrollViewDatasource;

@interface CycleScrollView : UIView <UIScrollViewDelegate> {
    
    id<CycleScrollViewDelegate> _delegate;
    id<CycleScrollViewDatasource> _datasource;
    
    NSInteger _totalPages;
    NSMutableArray *_curViews;
    NSTimer *_timer;
}

@property (nonatomic, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) PageControl *pageControl;
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign, setter = setDataource:) id<CycleScrollViewDatasource> datasource;
@property (nonatomic, assign, setter = setDelegate:) id<CycleScrollViewDelegate> delegate;

- (void)reloadData;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;
- (void)removeAndClear;

@end

@protocol CycleScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(CycleScrollView *)csView atIndex:(NSInteger)index;

@end

@protocol CycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)viewForPageAtIndex:(NSInteger)index;

@end
