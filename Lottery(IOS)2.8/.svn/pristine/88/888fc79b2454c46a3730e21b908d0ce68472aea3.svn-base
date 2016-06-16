//
//  MSBaseViewController.m
//  MusouKit
//
//  Created by danal on 13-7-17.
//  Copyright (c) 2013年 danal. All rights reserved.
//

#import "MSBaseViewController.h"
#import "MBProgressHUD.h"

#define SAFE_RELEASE_REQ(req_) req_.delegate = nil; [req_ cancel];  [req_ release];

@interface MSBaseViewController ()

@end

@implementation MSBaseViewController
@synthesize req = _req;

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"[%@ dealloc]", [self class]);
#endif
    if ([_req respondsToSelector:@selector(delegate)]){
        [_req performSelector:@selector(setDelegate:) withObject:nil];
    }
    if ([_req respondsToSelector:@selector(cancel)]) {
        [_req performSelector:@selector(cancel) withObject:nil];
    }
    [_req release];
    
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //Compatiable with iPhone 5 and iPhone 4
    CGRect rect  = [UIScreen mainScreen].applicationFrame;
    if (self.navigationController != nil) {
        rect.size.height -= self.navigationController.navigationBar.bounds.size.height;
        self.view.frame = rect;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)showLoading{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabelText = @"请稍候...";
    [hud show:YES];
}

- (void)showLoadingMsg:(NSString *)msg{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabelText = msg;
    [hud show:YES];
}

- (void)hideLoading{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)showMsg:(NSString *)msg{
    //    HIDE_HUD_NOW(self.view);
    //    SHOW_TEXT_HUD(msg, self.view);
//    [HUDTips showTips:msg];
}

- (void)setLeftBarButton:(UIButton *)button{
    UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setRightBarButton:(UIButton *)button{
    UIBarButtonItem *item = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setRightButton:(NSString *)title target:(id)target selector:(SEL)sel{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:sel];
    self.navigationItem.rightBarButtonItem = item;
}



@end



@implementation MSTableViewController
@synthesize style = _style;
@synthesize tableView = _tableView;
@synthesize dataList = _dataList;
@synthesize heightList = _heightList;

- (void)dealloc{
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    [_heightList release];  _heightList = nil;
    [_dataList release];    _dataList = nil;
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        _dataList = [[NSMutableArray alloc] init];
        _heightList = [[NSMutableArray alloc] init];
        _style = UITableViewStylePlain;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

#pragma mark - Shortcuts for TableView
- (void)attachTableView{
    if (_tableView) return;
    
    CGRect rect = self.view.bounds;
    if (self.navigationController) {
        rect.size.height -= 44.f;
    }
    _tableView = [[UITableView alloc] initWithFrame:rect style:_style];
    [self configTableView];
    [self.view addSubview:_tableView];
    [_tableView release];
}

- (void)configTableView{
    _tableView.dataSource = self;
    _tableView.delegate = self;
}


- (NSInteger)sectionCount{
    return 1;
}

- (NSInteger)rowCountInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)headerHeightForSection:(NSInteger)section{
    return 0.f;
}

- (UIView *)headerViewForSection:(NSInteger)section{
    return nil;
}

- (CGFloat)rowHeightAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

- (UITableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (CGFloat)footerHeightForSection:(NSInteger)section{
    return 0.f;
}

- (UIView *)footerViewForSection:(NSInteger)section{
    return nil;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - TableView Data source & Delegate

- (void)launchRefreshing{
    [self requestData];
}

- (void)finishLoading:(NSString *)msg{
    [self reloadTable];
}

- (void)reloadTable{
    [self.tableView reloadData];
}

- (void)requestData{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self rowCountInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self rowHeightAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellForIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self headerHeightForSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self headerViewForSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [self footerHeightForSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self footerViewForSection:section];
}

@end