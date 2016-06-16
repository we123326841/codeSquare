//
//  InfoCenterViewController.h
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "MSSegmentBar.h"
#import "RQNotice.h"

@class MSSegmentBar;
//站内信
@interface InfoCenterViewController : BaseViewController
<MSPullingRefreshTableViewDelegate,UIScrollViewDelegate,
UITableViewDataSource,UITableViewDelegate,RQBaseDelegate,MSSegmentViewDelegate>
{
    BOOL    _isEditing, _isRefresh;
    IBOutlet UIView *_titleView;
    IBOutlet UIView *_actionView;
    IBOutlet BadgeIconButton *_noticeButton;
    IBOutlet BadgeIconButton *_msgButton;
    IBOutlet MSSegmentBar   *_segBar;
    IBOutlet MSSegmentView  *_segView;
}
@property (strong, nonatomic) NSMutableArray *controllers;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (retain,nonatomic) IBOutlet MSPullingRefreshTableView *tableView;

- (IBAction)selectAllAction:(id)sender;
- (IBAction)deleteAction:(id)sender;
- (IBAction)noticeButtonClick:(id)sender;
- (IBAction)msgButtonClick:(id)sender;

@end

//公告
@interface NoticeViewController : BaseViewController
<MSPullingRefreshTableViewDelegate,UIScrollViewDelegate,
UITableViewDataSource,UITableViewDelegate,RQBaseDelegate>
{
    BOOL _isRefresh;
}
@property (retain, nonatomic) IBOutlet MSPullingRefreshTableView *tableView;
@property (nonatomic, assign) NoticeType noticeType;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, assign) UINavigationController *navi;

- (void)launchLoading;

@end