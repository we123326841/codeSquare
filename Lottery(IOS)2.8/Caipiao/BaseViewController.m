//
//  BaseViewController.m
//  Caipiao
//
//  Created by danal on 13-1-4.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "RQBase.h"

@interface BaseViewController ()
@property (strong, nonatomic) LoadingView *header;
@end

@implementation BaseViewController
@synthesize bgView = _bgView;
@synthesize rq = _rq;
@synthesize modal = _modal;
@synthesize header;

- (void)dealloc{
#ifdef DEBUG
    NSLog(@"[%@ dealloc]",[self class]);
#endif
    [self.rq cancel];   self.rq = nil;
    [_bgView release];  _bgView = nil;
    [super dealloc];
}

- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    UILabel *titleLbl = (UILabel *)self.navigationItem.titleView;
    if (titleLbl)
        titleLbl.text = title;
}

- (void)setup{
    //Navigation bar buttons
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:ResImage(@"back.png") forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0.f, 36.f, 40.f);
    if (_modal) {
        [button addTarget:self action:@selector(backToMenu:) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self setLeftBarButton:button];

    //Compat for ios7
    self.view.backgroundColor = Color(@"ViewBGColor");
}

- (void)addFakeBar{
    UIView *statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    statusBar.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:statusBar atIndex:0];
    [statusBar release];
}

- (void)viewDidLoad
{
#ifdef __IPHONE_7_0
    if (IOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#endif
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)prepareToBack{
}

- (IBAction)backAction:(id)sender{
    [self prepareToBack];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if ([self.navi.viewControllers count] > 1){
        [self.navi popViewControllerAnimated:YES];
    } else {
        [self.navi.navi popViewControllerAnimated:YES];
    }
}

- (IBAction)backHome:(id)sender{
    [self prepareToBack];
    [self.navi.navi popViewControllerAnimated:YES];
}

- (IBAction)backToMenu:(id)sender{
    if (_modal) {
        [self dismissModalViewControllerAnimated:YES];
    } else {
        [self prepareToBack];
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        AppDelegate *dele = (id)[[UIApplication sharedApplication] delegate];
        [dele.smc toggle];
    }
}

- (void)setLeftBarButton:(UIButton *)button{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, button.bounds.size.width, button.bounds.size.height)];
    [view addSubview:button];
    view.backgroundColor = [UIColor clearColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    UIBarButtonItem *plain = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:nil action:NULL];
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
    if (IOS7){
        fixed.width = -10.f;
    }
    self.navigationItem.leftBarButtonItems = @[plain,fixed,item];
    [view release];
    [item release];
    [plain release];
    [fixed release];
}

- (void)setRightBarButton:(UIButton *)button{
    if ([[[UIDevice currentDevice] systemVersion] integerValue] >= 7){
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10);
    }
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    [item release];
}

- (void)requestData{
}

- (void)showLoadingView{
    /*
    if (!self.header){
        LoadingView *loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, -100.f, 320.f, 100.f) atTop:YES];
        [self.view addSubview:loadingView];
        self.header = loadingView;
        [loadingView release];
    }
    self.header.frame = CGRectMake(0, -100.f, 320.f, 100.f);
    
    CGRect rect = self.header.frame;
    rect.origin.y = -40.f;
    [UIView animateWithDuration:.3f
                          delay:.1f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.header.frame = rect;
                         
                     } completion:^(BOOL finished) {
                         self.header.state = kPRStateLoading;
                         [self performSelector:@selector(requestData) withObject:nil afterDelay:.2f];
                     }];
    */
    HUDShowLoading(kStringLoading, nil);
    [self performSelector:@selector(requestData) withObject:nil afterDelay:.2f];
}

- (void)hideLoadingView{
    /*
    CGRect rect = self.header.frame;
    rect.origin.y = -100.f;
    self.header.state = kPRStateNormal;
    [UIView animateWithDuration:.2f animations:^{
        self.header.frame = rect;
        
    } completion:^(BOOL finished) {

    }];
     */
    HUDHide();
}

- (void)resizeTofitScreen{
    CGRect bounds = [UIScreen mainScreen].applicationFrame;
    if (self.navigationController){
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, bounds.size.height - 44.f);
    } else {
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, bounds.size.height);
    }
}


+ (UIButton *)addKeyboardDoneButton{
    [self removeKeyboardDoneButton];
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *win in windows){
        if ([NSStringFromClass([win class]) isEqualToString:@"UITextEffectsWindow"]) {
            
            UIWindow* tempWindow = win;
            UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
            doneButton.frame = CGRectMake(0, tempWindow.bounds.size.height - 53, 106, 53);
            doneButton.tag = 0xf1f1;
            doneButton.adjustsImageWhenHighlighted = NO;
            doneButton.titleLabel.font = [UIFont boldSystemFontOfSize:17.f];
            [doneButton setTitle:@"完成" forState:UIControlStateNormal];
            [doneButton setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"keyboard_tile.png"]] forState:UIControlStateNormal];
            [tempWindow addSubview:doneButton];
            return doneButton;
            break;
        }
    }
    return nil;
}

+ (void)removeKeyboardDoneButton{
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *win in windows){
        if ([NSStringFromClass([win class]) isEqualToString:@"UITextEffectsWindow"]) {
            
            UIWindow* tempWindow = win;
            [[tempWindow viewWithTag:0xf1f1] removeFromSuperview];
            break;
        }
    }
}

- (void)showAlertMessage:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    [alert release];
}

@end


#pragma mark - ------------------------------------
@interface BaseLoadingViewController ()
@property (assign, nonatomic) MSLoadingCell *loadingCell;
@end

@implementation BaseLoadingViewController

- (void)dealloc{
    self.dataList = nil;
    self.heightList = nil;
    [super dealloc];
}

- (void)configTableView{
    _tableView.headerOnly = YES;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.pullingDelegate = self;
    _autoLoading = NO;
    _refresh = YES;
    self.dataList = [NSMutableArray array];
    self.heightList = [NSMutableArray array];
}

- (void)reloadTable{
    [self.tableView reloadData];
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

#pragma mark - Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==  [self.dataList count]) {
        return 44.f;
    }
    return [self rowHeightAtIndexPath:indexPath] > 0.f ? [self rowHeightAtIndexPath:indexPath] : 44.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return [self.dataList count] + 1;
    if (self.tableView.headerOnly)
        return [self.dataList count];
    else
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
        if (self.tableView.contentSize.height < self.tableView.bounds.size.height){
            self.loadingCell.contentView.hidden = YES;
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
    [self performSelector:@selector(delayLoad:) withObject:[NSNumber numberWithBool:YES] afterDelay:.1f];
}

#pragma mark - LoadingCell

- (void)loadingCellDidStartLoading:(MSLoadingCell *)cell{
    [self performSelector:@selector(delayLoad:) withObject:[NSNumber numberWithBool:NO] afterDelay:.1f];
}


@end


@implementation NavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self.navigationBar setBackgroundImage:ResImage(@"navbar.png") forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.titleTextAttributes = @{
                                                   UITextAttributeTextColor:[UIColor whiteColor],
                                                   UITextAttributeFont:[UIFont boldSystemFontOfSize:19.f]
                                                   };
    }
    return self;
}

+ (id)new:(UIViewController *)rootController{
    return [[self alloc] initWithRootViewController:rootController];
}
- (BOOL)shouldAutorotate
{
    return NO;
}
- (NSUInteger)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
}
@end


@implementation UIViewController (Navi)
@dynamic parentViewController;
@dynamic navi;

- (void)setNavi:(UINavigationController *)navi{
    self.parentViewController = navi;
}

- (UINavigationController *)navi{
    return self.navigationController ? self.navigationController : (UINavigationController *)self.parentViewController;
}

@end


@implementation UINavigationController (Navi)

- (void)pushNavigationController:(UINavigationController *)navi animated:(BOOL)animated{
    UIViewController *container = [[UIViewController alloc] init];
    container.wantsFullScreenLayout = YES;
    [container.view addSubview:navi.view];
    [container addChildViewController:navi];
    for (UIViewController *vc in navi.viewControllers){
        [vc setNavi:navi];
    }
    [self pushViewController:container animated:animated];
    [container release];
}

@end
