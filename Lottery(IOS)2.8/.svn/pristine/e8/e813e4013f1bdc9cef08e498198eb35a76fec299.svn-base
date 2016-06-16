//
//  MyAccountTableView.h
//  Caipiao
//
//  Created by CYRUS on 14-8-4.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    kDataTypeGameHistory,
    kDataTypeZhuiHao
}DataType;

@protocol MyAccountTableViewDelegate;


@interface MyAccountTableView : UIView<MSPullingRefreshTableViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, RQBaseDelegate>
{
    BOOL _isRefresh;
}

@property (strong, nonatomic) MSPullingRefreshTableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@property (assign, nonatomic) DataType type;
@property (assign, nonatomic) NSInteger subType;
@property (strong, nonatomic) RQBase *rq;
@property (assign, nonatomic) id <MyAccountTableViewDelegate>delegate;
- (void)startLoading;
- (void)reloadData;

@end

@protocol MyAccountTableViewDelegate <NSObject>

-(void)tableview:(MyAccountTableView*)table didScroll:(UIScrollView*)scroll;
-(void)tableview:(MyAccountTableView *)table scrollViewWillBeginDragging:(UIScrollView *)scrollView;
-(void)tableview:(MyAccountTableView *)table scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
@end
