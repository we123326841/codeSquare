//
//  OpenAccountVC.m
//  Caipiao
//
//  Created by GroupRich on 15/7/30.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "OpenAccountVC.h"
#import "OACell.h"
#import "QRCodeAndShareVC.h"
#import "RQOpenLinkList.h"
#import "Musou.h"
#import "AddNewLinkController.h"
typedef NS_ENUM(NSInteger, OpenType) {
    OpenTypePlayer=0,
    OpenTypeDelegate
  
};

@interface OpenAccountVC ()

@property (retain, nonatomic) IBOutlet UIImageView *maskview;
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *headerBtns;
@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,assign) OpenType type;
@property (retain, nonatomic) IBOutlet UIImageView *noOAMsgV;
@property(retain ,nonatomic) OpenLinkObject*object;
@end

@implementation OpenAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"你妹" style:UIBarButtonItemStyleDone target:self action:@selector(hehe)];
    
    
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbutton setBackgroundImage:ResImage(@"newlink.png") forState:UIControlStateNormal];
    rightbutton.frame = CGRectMake(0, 0, 21, 20);
    [rightbutton addTarget:self action:@selector(hehe) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem=item;
    [item release];
    
    self.title = @"开户中心";
    
    //_tableview.rowHeight = 80;
    [_tableview registerNib:[UINib nibWithNibName:@"OACell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    _tableview.tableFooterView = [[UIView new]autorelease]
    ;
    
    self.type = OpenTypeDelegate;
    
  //  [self requestData];
}

-(void)hehe{
   // NSLog(@"呵呵");
  //  self.navigationItem.backBarButtonIt
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"AddNewLinkController" bundle:nil];
    
    AddNewLinkController *viewCtl = [storyBoard instantiateInitialViewController];
   // viewCtl.navigationItem.backBarButtonItem.tintColor=[UIColor whiteColor];
    //rAddNewLinkController *viewCtl =[[AddNewLinkController alloc]init];
    [self.navigationController pushViewController:viewCtl animated:YES];
    
    //[[AppDelegate shared].nav pushNavigationController:[[NavigationController new:viewCtl] autorelease] animated:YES];
   // [vc release];

}
-(void)requestData
{
    RQOpenLinkList *rq = [[RQOpenLinkList alloc]init];
    self.rq = rq;
    __block OpenAccountVC *blockself = self;
   // HUDShowLoading(@"正在更新数据,请稍后", nil);
    [rq startPostWithBlock:^(RQOpenLinkList* rq_, NSError *error_, id rqSender_) {
        HUDHide();
        [blockself.tableview reloadData];
        if (rq_.isEmpty==YES) {
            _noOAMsgV.hidden = NO;
        }else
        {
            _noOAMsgV.hidden = YES;
        }
        
    } sender:nil];
    [rq release];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated{
    [self requestData];

}
- (IBAction)switchBtn:(UIButton*)sender {
    
    for (UIButton *btn in self.headerBtns) {
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.type = sender.tag;
    
    self.maskview.center = sender.center;
    
    [self.tableview reloadData];
}

#pragma mark --  UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    RQOpenLinkList *rq = (RQOpenLinkList*)self.rq;
    if (_type == OpenTypeDelegate) {
      return   [(NSArray*)[rq.openLink objectAtIndex:1] count];
    }else
    {
     return    [(NSArray*)[rq.openLink objectAtIndex:0] count];

    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"Cell";
    
    OACell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    
    OpenLinkObject *object = nil;
    RQOpenLinkList *rq = (RQOpenLinkList*)self.rq;
    if (_type == OpenTypeDelegate) {
        object = [[rq.openLink objectAtIndex:1]objectAtIndex:indexPath.row];
    }else
    {
        object = [[rq.openLink objectAtIndex:0]objectAtIndex:indexPath.row];
    }
    
    cell.textL.text = object.remark==nil?@"":object.remark;
    
    
    NSString *stateStr = @"";
    stateStr = (object.registers==0?@"未注册":[NSString stringWithFormat:@"已注册(%@)",@(object.registers)]);
    if (object.registers==0) {
        stateStr = @"未使用";
       // cell.stateL.textColor = RGBAHex(@"ff2929");
        cell.stateL.textColor =[UIColor grayColor];

    }else
    {
        stateStr = [NSString stringWithFormat:@"已注册(%@)",@(object.registers)];
        cell.stateL.textColor = RGBAHex(@"29b8a0");
    }
    if (object.end.length>0) {
        NSDateFormatter *f = [[NSDateFormatter alloc]init];
        f.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        f.timeZone = [NSTimeZone systemTimeZone];
        NSDate *d = [f dateFromString:object.end];
        if (d) {
            NSTimeInterval i = [[NSDate date] timeIntervalSinceDate:d];
            if (i>0) {
                stateStr  = @"已过期";
                cell.stateL.textColor = RGBAHex(@"ff2929");
            }

        }
    }
    
    cell.stateL.text = stateStr;
    
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",cell.textL.text]];
//    
//    [str addAttribute:NSForegroundColorAttributeName value:cell.textL.textColor range:NSMakeRange(0,cell.textL.text.length)];
//    [str addAttribute:NSForegroundColorAttributeName value:cell.stateL.textColor range:NSMakeRange(cell.textL.text.length+1,cell.stateL.text.length)];
//    [str addAttribute:NSFontAttributeName value:cell.textL.font range:NSMakeRange(0, cell.textL.text.length)];
//    [str addAttribute:NSFontAttributeName value:cell.stateL.font range:NSMakeRange(cell.textL.text.length+1,cell.stateL.text.length)];
    
   // cell.textL.text  =@"";
   // cell.stateL.text = @"";
    //cell.textL.attributedText = str;
 
    cell.timeL.text = object.start;
    if(!cell.textL.text.length){cell.contentLabelView.centerY=cell.contentView.centerY;
    }else{
        cell.contentLabelView.y=43;
    }
    return cell;
}



#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OpenLinkObject *object = nil;

    RQOpenLinkList *rq = (RQOpenLinkList*)self.rq;
    if (_type == OpenTypeDelegate) {
        object = [[rq.openLink objectAtIndex:1]objectAtIndex:indexPath.row];
    }else
    {
        object = [[rq.openLink objectAtIndex:0]objectAtIndex:indexPath.row];
    }
    if (object.remark) {
        return 80;
    }else{
    
        return 60;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OpenLinkObject *object = nil;
    RQOpenLinkList *rq = (RQOpenLinkList*)self.rq;
    if (_type == OpenTypeDelegate) {
        object = [[rq.openLink objectAtIndex:1]objectAtIndex:indexPath.row];
    }else
    {
        object = [[rq.openLink objectAtIndex:0]objectAtIndex:indexPath.row];
    }
    
    QRCodeAndShareVC *vc = [[QRCodeAndShareVC alloc]init];
    
  OACell *cell = [tableView cellForRowAtIndexPath:indexPath];
    vc.state =cell.stateL.text;
    vc.object = object;
    [vc setBlock:^(OpenLinkObject *o) {
        if (_type == OpenTypeDelegate) {
            [[rq.openLink objectAtIndex:1] removeObject:object];
            
        }else{
            [[rq.openLink objectAtIndex:0] removeObject:object];

        }
        [self.tableview reloadData];
    }];
    
    
    //_object =object;
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}




- (void)dealloc {
    [_maskview release];
    [_headerBtns release];
    [_tableview release];
    [_noOAMsgV release];
    [super dealloc];
}
@end

