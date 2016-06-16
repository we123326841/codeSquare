//
//  MSTableViewController.m
//  Musou
//
//  Created by luo danal on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MSTableViewController.h"

@interface MSTableViewController ()

@end

@implementation MSTableViewController
@synthesize tableView = _tableView;
@synthesize dataList = _dataList;
@synthesize offset = _offset;
@synthesize isAutoLoadingCell;

- (void)dealloc{
    [_dataList release];    _dataList = nil;
    [_tableView release];    _tableView = nil;
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        _dataList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadView
{
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
    [super loadView];
    _tableView = [[MSPullingRefreshTableView alloc] initWithFrame:self.view.bounds pullingDelegate:self];
    _tableView.headerOnly = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)setOffset:(CGPoint)offset{
    CGRect rect = self.tableView.frame;
    rect.origin = offset;
    rect.size.height -= offset.y;
    rect.size.width -= offset.x;
    self.tableView.frame = rect;
}

#pragma mark - Delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"MS_TABLE_CELL";
    static NSString *loadingCellIdentifier = @"MS_TABLE_LOADING_CELL";
    UITableViewCell *cell = nil;
    if (indexPath.row == [self.dataList count] ) {
        cell = [tableView dequeueReusableCellWithIdentifier:loadingCellIdentifier];
        if (cell == nil) {
            MSLoadingCellType type = self.isAutoLoadingCell ? MSLoadingCellTypeAutoLoad : MSLoadingCellTypeTapToLoad;
            cell = [[[MSLoadingCell alloc] initWithType:type reuseIdentifier:loadingCellIdentifier] autorelease]; 
            [(MSLoadingCell *)cell setDelegate:self];
            
        }
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (cell == nil) {
            [self configCell:&cell atIndexPath:indexPath reuseIdentifier:identifier];
//        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -  Scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}

#pragma mark - The following methods should be overrided

- (void)configCell:(UITableViewCell **)cell atIndexPath:(NSIndexPath *)indexPath reuseIdentifier:(NSString *)identifier{

    if (*cell == nil) {
        *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier] autorelease];
    }
    (*cell).detailTextLabel.text = @"detail";
}

#pragma mark - Pulling

- (void)pullingTableViewDidStartRefreshing:(MSPullingRefreshTableView *)tableView{
    [tableView performSelector:@selector(tableViewDidFinishedLoading) withObject:nil afterDelay:1.f];
}

#pragma mark - LoadingCell

- (void)loadingCellDidStartLoading:(MSLoadingCell *)cell{
    [cell performSelector:@selector(stopLoad) withObject:nil afterDelay:1.f];
}

@end
