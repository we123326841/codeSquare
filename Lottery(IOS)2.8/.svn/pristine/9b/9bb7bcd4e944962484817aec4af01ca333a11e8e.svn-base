//
//  MSBaseViewController.h
//  MusouKit
//
//  Created by danal on 13-7-17.
//  Copyright (c) 2013年 danal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSBaseViewController : UIViewController
@property (strong, nonatomic) NSObject *req;

- (void)showLoading;
- (void)showLoadingMsg:(NSString *)msg;
- (void)hideLoading;
- (void)showMsg:(NSString *)msg;

- (void)setLeftBarButton:(UIButton *)button;
- (void)setRightBarButton:(UIButton *)button;
- (void)setRightButton:(NSString *)title target:(id)target selector:(SEL)sel;

@end


@interface MSTableViewController : MSBaseViewController
<UITableViewDataSource,UITableViewDelegate>
@property (assign,nonatomic) IBOutlet UITableView *tableView;
@property (assign,nonatomic) UITableViewStyle style;
@property (retain,nonatomic) NSMutableArray *dataList;
@property (retain,nonatomic) NSMutableArray *heightList;

#pragma mark - Shortcuts for TableView
- (void)attachTableView;
- (void)configTableView;
- (void)reloadTable;
- (void)requestData;
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
