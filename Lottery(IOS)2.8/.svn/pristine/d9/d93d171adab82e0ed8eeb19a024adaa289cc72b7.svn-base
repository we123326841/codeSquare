//
//  MSTableViewController.m
//  Musou
//
//  Created by luo danal on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSLoadingTableViewController.h"

@interface MSLoadingTableViewController ()
@property (assign, nonatomic) MSLoadingCell *loadingCell;
@end

@implementation MSLoadingTableViewController
@synthesize tableView = _tableView;
@synthesize page = _page;
@synthesize refresh = _refresh;
@synthesize loadingCell = _loadingCell;
@synthesize autoLoading = _autoLoading;


- (void)dealloc{
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    [_tableView release];    _tableView = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)attachTableView{
    CGRect rect = self.view.bounds;
    if (self.navigationController) {
        rect.size.height -= 44.f;
    }
    _tableView = [[MSPullingRefreshTableView alloc] initWithFrame:rect pullingDelegate:self];
    [self configTableView];
    [self.view addSubview:_tableView];
}

- (void)configTableView{
    _tableView.headerOnly = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.pullingDelegate = self;
    _autoLoading = NO;
}

#pragma mark - Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==  [self.dataList count]) {
        return 44.f;
    }
    return [self rowHeightAtIndexPath:indexPath] > 0.f ? [self rowHeightAtIndexPath:indexPath] : 44.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [self.dataList count] + 1;
    return [self.dataList count] > 0 ? [self.dataList count] + 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *loadingCellIdentifier = @"MS_TABLE_LOADING_CELL";
    UITableViewCell *cell = nil;
    if ( indexPath.row == [self.dataList count] ) {
        cell = [tableView dequeueReusableCellWithIdentifier:loadingCellIdentifier];
        if (cell == nil) {
            MSLoadingCellType type = self.autoLoading ? MSLoadingCellTypeAutoLoad : MSLoadingCellTypeTapToLoad;
            cell = [[[MSLoadingCell alloc] initWithType:type reuseIdentifier:loadingCellIdentifier] autorelease];
            [(MSLoadingCell *)cell setDelegate:self];
            self.loadingCell = (MSLoadingCell *)cell;
        }
        
    } else {
        
        cell = [self cellForIndexPath:indexPath];
    }
    return cell;
}

//Remove blank cells at the bottom
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return MAX([self headerHeightForSection:section],1.f);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self didSelectRowAtIndexPath:indexPath];
}

#pragma mark - The following methods should be overrided

- (void)delayLoad:(id)obj{
    _refresh = [obj boolValue];
    _page = _refresh ? 1 : _page + 1;
    [self requestData];
}

- (void)launchRefreshing{
    [self.tableView launchRefreshing];
}

- (void)finishRefreshing{
    [self.tableView tableViewDidFinishedLoading];
    [self reloadTable];
}

- (void)finishLoading:(NSString *)msg{
    [self reloadTable];
    if (msg) [self.tableView flashMessage:msg];
    
    if (_refresh) {
        [self finishRefreshing];
    } else {
        [self.loadingCell stopLoad];
    }
}

#pragma mark - Pulling

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

- (void)pullingTableViewDidStartRefreshing:(MSPullingRefreshTableView *)tableView{
//    [tableView performSelector:@selector(tableViewDidFinishedLoading) withObject:nil afterDelay:1.f];
    [self performSelector:@selector(delayLoad:) withObject:[NSNumber numberWithBool:YES] afterDelay:.1f];
}

#pragma mark - LoadingCell

- (void)loadingCellDidStartLoading:(MSLoadingCell *)cell{
//    [cell performSelector:@selector(stopLoad) withObject:nil afterDelay:1.f];
    [self performSelector:@selector(delayLoad:) withObject:[NSNumber numberWithBool:NO] afterDelay:.1f];
}

@end



@implementation MSPullToLoadTableViewController
@synthesize tableView = _tableView;
@synthesize page = _page;
@synthesize refresh = _refresh;

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)attachTableView{
    CGRect rect = self.view.bounds;
    if (self.navigationController) {
        rect.size.height -= 44.f;
    }
    _tableView = [[MSPullingRefreshTableView alloc] initWithFrame:rect pullingDelegate:self];
    [self configTableView];
    [self.view addSubview:_tableView];
}

- (void)configTableView{
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.pullingDelegate = self;
}

- (void)delayLoad:(id)obj{
    _refresh = [obj boolValue];
    _page = _refresh ? 1 : _page + 1;
    [self requestData];
}

- (void)launchRefreshing{
    [self.tableView launchRefreshing];
}

- (void)finishLoading:(NSString *)msg{
    [self.tableView tableViewDidFinishedLoadingWithMessage:msg];
}

#pragma mark - Pulling

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

- (void)pullingTableViewDidStartRefreshing:(MSPullingRefreshTableView *)tableView{
    [self performSelector:@selector(delayLoad:) withObject:[NSNumber numberWithBool:YES] afterDelay:.1f];
}

- (void)pullingTableViewDidStartLoading:(MSPullingRefreshTableView *)tableView{
    [self performSelector:@selector(delayLoad:) withObject:[NSNumber numberWithBool:NO] afterDelay:.1f];
}
@end