//
//  ZhuiHaoListViewController.h
//  Caipiao
//
//  Created by danal on 13-5-29.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "RQZhuiHaoInfo.h"
#import "NavTitleMenu.h"
#import "ToolBarPickerView.h"
#import "GreenBar.h"

@interface ZhuiHaoListViewController : BaseViewController
<MSPullingRefreshTableViewDelegate,
UIScrollViewDelegate,
UITableViewDataSource,UITableViewDelegate,
RQBaseDelegate,
GreenBarDelegate,
NavTitileMenuDelegate>
{
    BOOL _isRefresh;
    NSInteger _selectedIndex; //GreenBar选中的index
    NSInteger _pickerSelectedIndex;
    NSString *_selectedType; //选中彩种的名字
    UIView *_contentView;
    BOOL _isLowGame;
}
@property (assign, nonatomic) MSPullingRefreshTableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (strong, nonatomic) NSMutableArray *typeArray;
@property (strong, nonatomic) NSMutableArray *allArray;
@property (copy, nonatomic) void(^selectBlock)(ZhuiHaoInfoItem *infoItem);
@property (assign, nonatomic) IBOutlet UILabel *countLbl;
@property (strong, nonatomic) NavTitleControl *titleLbl;
@property (strong, nonatomic) NavTitleMenu *navTitleMenu;

@end
