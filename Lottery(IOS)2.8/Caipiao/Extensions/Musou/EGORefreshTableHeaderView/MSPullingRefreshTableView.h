//
//  PullingRefreshTableView.h
//  PullingTableView
//
//  Created by danal on 3/6/12.If you want use it,please leave my name here
//  Copyright (c) 2012 danal Luo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kPRStateNormal = 0,
    kPRStatePulling = 1,
    kPRStateLoading = 2,
    kPRStateHitTheEnd = 3
} PRState;

typedef enum {
    kPRTipsTypeDefault = 0,
    kPRTipsTypeNoData,
    kPRTipsTypeNetworkError,
} PRTipsType;

@interface LoadingView : UIView {
    UILabel *_stateLabel;
    UILabel *_dateLabel;
    UIImageView *_arrowView;
    UIActivityIndicatorView *_activityView;
    CALayer *_arrow;
    BOOL _loading;
}
@property (nonatomic,getter = isLoading) BOOL loading;    
@property (nonatomic,getter = isAtTop) BOOL atTop;
@property (nonatomic) PRState state;

- (id)initWithFrame:(CGRect)frame atTop:(BOOL)top;

- (void)updateRefreshDate:(NSDate *)date;

@end

@protocol MSPullingRefreshTableViewDelegate;

@interface MSPullingRefreshTableView : UITableView <UIScrollViewDelegate>{
    LoadingView *_headerView;
    LoadingView *_footerView;
    UILabel *_msgLabel;
    BOOL _loading;
    BOOL _isFooterInAction;
    NSInteger _bottomRow;
    PRTipsType _tipsType;
}
@property (assign,nonatomic) id <MSPullingRefreshTableViewDelegate> pullingDelegate;
@property (nonatomic) BOOL autoScrollToNextPage;
@property (nonatomic) BOOL reachedTheEnd;
@property (nonatomic) BOOL noLoadingView;
@property (nonatomic,getter = isHeaderOnly) BOOL headerOnly;

- (void)turnOffEffect:(BOOL)yesOrNo;

- (id)initWithFrame:(CGRect)frame pullingDelegate:(id<MSPullingRefreshTableViewDelegate>)aPullingDelegate;
- (id)initWithFrame:(CGRect)frame pullingDelegate:(id<MSPullingRefreshTableViewDelegate>)aPullingDelegate style:(UITableViewStyle) tableStyle;

- (void)tableViewDidScroll:(UIScrollView *)scrollView;

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView;

- (void)tableViewDidFinishedLoading;

- (void)tableViewDidFinishedLoadingWithMessage:(NSString *)msg;

- (void)launchRefreshing;

- (void)flashMessage:(NSString *)msg;

/**
 * Set tips text for the specified type
 * @param type tips type
 */
- (void)setTipsType:(PRTipsType)type;
- (void)setTips:(NSString *)tips andIcon:(UIImage *)icon;
@end



@protocol MSPullingRefreshTableViewDelegate <NSObject>

@required
- (void)pullingTableViewDidStartRefreshing:(MSPullingRefreshTableView *)tableView;

@optional
//Implement this method if headerOnly is false
- (void)pullingTableViewDidStartLoading:(MSPullingRefreshTableView *)tableView;
//Implement the follows to set date you want,Or Ignore them to use current date 
- (NSDate *)pullingTableViewRefreshingFinishedDate;
- (NSDate *)pullingTableViewLoadingFinishedDate;
@end

//Usage example
/*
_tableView = [[MSPullingRefreshTableView alloc] initWithFrame:frame pullingDelegate:aPullingDelegate];
[self.view addSubview:_tableView];
_tableView.autoScrollToNextPage = NO;
_tableView.delegate = self;
_tableView.dataSource = self;
*/