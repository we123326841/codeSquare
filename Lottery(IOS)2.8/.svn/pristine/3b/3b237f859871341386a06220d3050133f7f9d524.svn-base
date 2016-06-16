//
//  SearchUserViewController.m
//  Caipiao
//
//  Created by danal on 13-10-9.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "SearchUserViewController.h"
#import "AgentDetailViewController.h"
#import "ColorCell.h"
#import "RQAgentMember.h"
#import "DropDownOptionView.h"

@interface SearchUserViewController ()<RQBaseDelegate>
@property (nonatomic) BOOL bShowHistory;
@end

@implementation SearchUserViewController

- (void)dealloc{
    [_keyword release];
    [super dealloc];
}

- (void)viewDidLoad
{
    self.title = @"搜索";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textField.delegate = self;
    UIButton *magnifier = [UIButton buttonWithType:UIButtonTypeCustom];
    magnifier.frame = CGRectMake(0, 0, 38, 14);
    magnifier.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [magnifier setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [magnifier addTarget:self action:@selector(searchUser:) forControlEvents:UIControlEventTouchUpInside];
    self.textField.rightView = magnifier;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    
    //    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    //    self.textField.leftView = leftView;
    //    self.textField.leftViewMode = UITextFieldViewModeAlways;
    //    [leftView release];
    DropDownOptionView *optionView = [[DropDownOptionView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    optionView.selectedIndex = _high ? 0 : 1;
    optionView.options = [NSArray arrayWithObjects:@"高频",@"低频", nil];
    optionView.textLbl.textColor = [UIColor whiteColor];
    [optionView setCallback:@selector(selectOption:) target:self];
    self.textField.leftView = optionView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    [optionView release];
    
    [self setupTableView];
//    [self launchRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)cancelAction:(id)sender{
    [self.view endEditing:YES];
}

- (void)setupTableView{
    self.tableView.backgroundColor = [UIColor clearColor];
    [self configTableView];
    self.textField.text = self.keyword;
}

- (void)searchUser:(id)sender{
    [self.textField resignFirstResponder];
    self.refresh = YES;
//    [[self class] addRecord:self.textField.text];
    [self launchRefreshing];
}

- (void)selectOption:(DropDownOptionView *)sender{
    _high = sender.selectedIndex == 0;
    [self requestData];
}

- (UINavigationController *)nav{
    return _nav != nil ? _nav : self.navigationController;
}

#pragma mark - Table

- (void)requestData{
//    for (int i = 0; i < 10; i++) {
//        [self.dataList addObject:@"cell"];
//    }
//    [self performSelector:@selector(finishLoading:) withObject:nil afterDelay:1.f];
    RQSearchUser *request = [[RQSearchUser alloc] init];
    request.high = _high;
    request.keyword = self.textField.text;
    [request startPostWithDelegate:self];
    self.rq = request;
    [request release];
}

- (NSInteger)rowCountInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)cellForIndexPath:(NSIndexPath *)indexPath{
    id obj = [self.dataList objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[AgentMember class]]){
        static NSString *identifier = @"cell";
        ColorCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [ColorCell blackColorCell:identifier];
            cell.edgeInsets = UIEdgeInsetsMake(0.5, 0, 0.5, 0);
            
            UILabel *leftLbl = [[UILabel alloc] initWithFrame:CGRectMake(30, 24/2, 100, 20)];
            leftLbl.tag = 101;
            leftLbl.backgroundColor = [UIColor clearColor];
            leftLbl.textColor = [UIColor whiteColor];
            leftLbl.font = [UIFont boldSystemFontOfSize:13.f];
            [cell.contentView addSubview:leftLbl];
            [leftLbl release];
            
            UILabel *rightLbl = [[UILabel alloc] initWithFrame:CGRectMake(320-110, 24/2, 80, 20)];
            rightLbl.tag = 102;
            rightLbl.textAlignment = UITextAlignmentRight;
            rightLbl.backgroundColor = [UIColor clearColor];
            rightLbl.textColor = [UIColor whiteColor];
            rightLbl.font = [UIFont boldSystemFontOfSize:13.f];
            [cell.contentView addSubview:rightLbl];
            [rightLbl release];
        }
        UILabel *leftLbl = (UILabel *)[cell.contentView viewWithTag:101];
        UILabel *rightLbl = (UILabel *)[cell.contentView viewWithTag:102];
        AgentMember *am = obj;
        if (self.bShowHistory){ //show history
            leftLbl.text = [NSString stringWithFormat:@"%@ (%@)", am.name, am.high ? @"高频" : @"低频"];
        } else {    //show search result
            leftLbl.text = am.name;
            rightLbl.text  = [SharedModel formatBalance:am.balance];    //@"一级代理";
        }
        return cell;
    }
    //Tips cell
    else if([obj isKindOfClass:[NSString class]]){
        static NSString *identifier = @"cell_tips";
        ColorCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell){
            cell = [ColorCell blackColorCell:identifier];
            cell.tintAlpha = 0.f;
            cell.edgeInsets = UIEdgeInsetsMake(0.5, 0, 0.5, 0);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *tipLbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 200, 20)];
            tipLbl.tag = 201;
            tipLbl.textColor = kGrayTipsTextColor;
            tipLbl.font = [UIFont systemFontOfSize:10.f];
            tipLbl.backgroundColor = [UIColor clearColor];
            [cell.contentView addSubview:tipLbl];
            [tipLbl release];
        }
        UILabel *tipLbl = (UILabel *)[cell.contentView viewWithTag:201];
        tipLbl.text = obj;
        return cell;
    }
    return nil;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AgentMember *am = [self.dataList objectAtIndex:indexPath.row];
    if ([am isKindOfClass:[AgentMember class]]){
        AgentDetailViewController *vc = [[AgentDetailViewController alloc] init];
        vc.member = am;
        vc.high = am.high;
        [self.nav pushViewController:vc animated:YES];
        [vc release];
    }
}

#pragma mark - TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    [self searchUser:nil];
    return YES;
}

#pragma mark - RQDelegate

- (void)onRQStart:(RQBase *)rq{
    
}

- (void)onRQComplete:(RQSearchUser *)rq error:(NSError *)error{
    if (error){
    } else if (rq.msgContent){
        HUDShowMessage(rq.msgContent, nil);
    } else {
        [self.dataList removeAllObjects];
        if ([rq.list count] > 0){
            for (AgentMember *am in rq.list){
                [self.dataList addObject:am];
                am.high = _high;
                [[self class] addRecord:am];
            }
        } else {
#ifdef DEBUG
            AgentMember *am = [[[AgentMember alloc] init] autorelease];
            am.name = @"SearchTest";
            am.balance = @"1002.0000";
            [[self class] addRecord:am];
#endif
        }
    }
    
    //如未搜索到结果，则增加提示行
    if ([self.dataList count] == 0) {
        [self.dataList addObject:@"搜索结束，未找到匹配用户。"];
    }
    
    
    [self finishLoading:nil];

}

- (void)showHistory{
    self.bShowHistory = YES;
    self.title = @"最近搜索";
    self.textField.hidden = YES;
    self.cancelButton.hidden = YES;
    CGRect rect = self.tableView.frame;
    rect.size.height += (rect.origin.y - 10.f);
    rect.origin.y = 10.f;
    self.tableView.frame = rect;
    self.tableView.noLoadingView = YES;
    NSArray *records = [[self class] searchRecords];
    if (records && [records count] > 0){
        [self.dataList addObjectsFromArray:records];
        [self reloadTable];
    }
}

#pragma mark - Class methods

+ (void)addRecord:(id)record{
    NSMutableArray *records = [NSMutableArray arrayWithArray:[self searchRecords]];
    if (!records) records = [NSMutableArray array];
    if ([record isKindOfClass:[AgentMember class]]){
        AgentMember *am = record;
        for (AgentMember *one in records) {
            if ([one.name isEqualToString:am.name] && one.high == am.high){
                [records removeObject:one];
                break;
            }
        }
        [records insertObject:record atIndex:0];
    }
    
    if ([records count] > 10) {
        [records removeObjectsInRange:NSMakeRange(10, [records count] - 10)];
    }
    NSString *file = [NSBundle pathInDocuments:@"Searchs.plist"];
    [NSKeyedArchiver archiveRootObject:records toFile:file];
}

+ (NSArray *)searchRecords{
    NSString *file = [NSBundle pathInDocuments:@"Searchs.plist"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:file];
}

@end
