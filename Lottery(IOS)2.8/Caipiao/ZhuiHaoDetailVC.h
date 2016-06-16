//
//  ZhuiHaoDetailVC.h
//  Caipiao
//
//  Created by Cyrus on 13-6-17.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "RQZhuiHaoDetail.h"

@interface ZhuiHaoDetailVC : BaseViewController<MSPullingRefreshTableViewDelegate,
UIScrollViewDelegate,
UITableViewDataSource,
UITableViewDelegate,
RQBaseDelegate>{
    BOOL _isRefresh;
    BOOL _isEditing;
    NSMutableArray *_editArray;
    NSInteger _selectedCount;
}

@property (assign, nonatomic) BOOL isLowGame;
@property (assign, nonatomic) IBOutlet MSPullingRefreshTableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (copy, nonatomic) NSString *taskId;
@property (assign, nonatomic) IBOutlet UILabel *countLbl;
@property (assign, nonatomic) IBOutlet UIView *selectionView;
@property (assign, nonatomic) IBOutlet UILabel *selectedLbl;
@property (assign, nonatomic) IBOutlet UILabel *selectedTagLbl;
@property (assign, nonatomic) IBOutlet UIButton *stopZhuiHaoButton;
@property (assign, nonatomic) UIButton *rightBarButton;
@property (retain, nonatomic) IBOutlet UIButton *selectAllBtn;

@end
