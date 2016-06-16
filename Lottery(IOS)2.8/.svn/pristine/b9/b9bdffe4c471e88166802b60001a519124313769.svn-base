//
//  BaseViewController.h
//  Caipiao
//
//  Created by danal on 13-1-4.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTabBarController.h"
#import "MSPullingRefreshTableView.h"
#import "MSLoadingCell.h"
#import "RQSafe.h"


@class MSHTTPRequest;
@class RQBase;

@interface BaseViewController : UIViewController
{
    UIImageView *_bgView;
}
@property (strong, nonatomic) UIImageView *bgView;
//是否来自PresentModelViewController
@property (nonatomic) BOOL modal;
@property (strong, nonatomic) RQBase *rq;

/** 设置NavigationBar上的button */
- (void)setLeftBarButton:(UIButton *)button;
- (void)setRightBarButton:(UIButton *)button;

/** 返回 */
- (void)prepareToBack;
- (IBAction)backAction:(id)sender;
- (IBAction)backHome:(id)sender;
- (IBAction)backToMenu:(id)sender;

/** 呼叫请求 */
- (void)requestData;
/** 显示/隐藏Loading */
- (void)showLoadingView;    //此方法会调用requestData
- (void)hideLoadingView;

/**  调整view以适应屏幕 */
- (void)resizeTofitScreen;
/** 添加iOS7兼容statusBar */
- (void)addFakeBar;

+ (UIButton *)addKeyboardDoneButton;
+ (void)removeKeyboardDoneButton;

- (void)showAlertMessage:(NSString *)msg; //单个按钮的AlertView

@end

#pragma mark - ---------------------------

@interface BaseLoadingViewController : BaseViewController
<UITableViewDataSource,UITableViewDelegate,
MSPullingRefreshTableViewDelegate,MSLoadingCellDelegate>
@property (assign,nonatomic) IBOutlet MSPullingRefreshTableView *tableView;
@property (retain,nonatomic) NSMutableArray *dataList;
@property (retain,nonatomic) NSMutableArray *heightList;
@property (assign, nonatomic) NSInteger page;
@property (nonatomic) BOOL refresh;
@property (nonatomic) BOOL autoLoading;

#pragma mark - Shortcuts for TableView
- (void)configTableView;
- (void)reloadTable;
- (void)launchRefreshing;
- (void)finishLoading:(NSString *)msg;

- (NSInteger)sectionCount;
- (NSInteger)rowCountInSection:(NSInteger)section;
- (CGFloat)headerHeightForSection:(NSInteger)section;
- (UIView *)headerViewForSection:(NSInteger)section;
- (CGFloat)rowHeightAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)footerHeightForSection:(NSInteger)section;
- (UIView *)footerViewForSection:(NSInteger)section;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface NavigationController : UINavigationController
+ (id)new:(UIViewController *)rootController;
@end


@interface UIViewController (Navi)
@property (strong, nonatomic) UIViewController *parentViewController;
@property (strong, nonatomic) UINavigationController *navi;
@end


@interface UINavigationController (Navi)
- (void)pushNavigationController:(UINavigationController *)navi animated:(BOOL)animated;
@end

