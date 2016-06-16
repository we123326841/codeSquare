//
//  FavoriteViewController.m
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "FavoriteViewController.h"

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController
@synthesize tableView = _tableView;
@synthesize dataList = _dataList;

- (void)dealloc{
    [_tableView release];   _tableView = nil;
    [_dataList release];    _dataList = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CGRect rect = self.view.bounds;
    rect.size.height -= 44.f;
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIView *bgView = [[UIView alloc] initWithFrame:_tableView.bounds];
    bgView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView = [bgView autorelease];
    _tableView.backgroundColor = [UIColor clearColor];
//    _tableView.separatorColor = kYellowTextColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _dataList = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 20; i++) {
        [_dataList addObject:@"cell"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView*

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CELL";
    FavoriteCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil){
        cell = [[[FavoriteCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.row = indexPath.row;
    cell.numberOfRows = [self.dataList count];
    return cell;
}



@end
