//
//  OAPrizeDetailVC.m
//  Caipiao
//
//  Created by 王浩 on 15/10/22.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "OAPrizeDetailVC.h"
#import "OADeatilCell.h"
#import "RQPrizeDetail.h"
@interface OAPrizeDetailVC ()<UITableViewDelegate>
@property (retain, nonatomic) IBOutletCollection(UIButton) NSArray *btns;
@property (retain, nonatomic) IBOutlet UIImageView *shadowview;
@property (retain, nonatomic) IBOutlet UITableView *table;
@property (retain, nonatomic) NSMutableArray *datas;
@property (assign, nonatomic) DetailType type;
@property (assign,nonatomic) CGFloat lastPositonY;
@property (retain, nonatomic) IBOutlet UIView *superBtns;
@property (retain, nonatomic) IBOutlet UIView *lotteryType;
@property(nonatomic,assign)BOOL hasUp;
@property(nonatomic,assign)BOOL hasDown;

@end

@implementation OAPrizeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"奖金详情";
    
    self.datas = @[].mutableCopy;
    
    _type = DetailTypeSSC;
    _table.delegate =self;
   // _table.bounces=NO;
    //_table.contentInset =UIEdgeInsetsMake(45, 0, 0, 0);
    [_table registerNib:[UINib nibWithNibName:@"OADeatilCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    _table.tableFooterView = [[UIView new]autorelease];
    [self requestData];
    
    
}

-(void)requestData
{
    RQPrizeDetail *rq = [[RQPrizeDetail alloc]init];
        self.rq = rq;
    __block OAPrizeDetailVC *blockself = self;
    [rq startPostWithBlock:^(RQPrizeDetail* rq_, NSError *error_, id rqSender_) {
        [blockself.table reloadData];
    } sender:nil];
    
    [rq release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)switchbtn:(UIButton*)sender {
    
    for (UIButton *btn in self.btns) {
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.shadowview.center = sender.center;
    _type = sender.tag;
    self.hasUp =NO;
    self.hasDown =NO;
    
    [_table reloadData];
}

- (void)dealloc {
    [_btns release];
    [_shadowview release];
    [_table release];
    
    [_superBtns release];
    [_lotteryType release];
    [super dealloc];
}

#pragma mark --  UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    RQPrizeDetail *rq = (RQPrizeDetail*)self.rq;
    NSArray *typeArr = rq.objects[_type];
    NSArray *arr = [typeArr firstObject];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"Cell";
    
    OADeatilCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    RQPrizeDetail *rq = (RQPrizeDetail*)self.rq;
    NSArray *typeArr = rq.objects[_type];
    NSArray *arr = [typeArr firstObject];
    cell.objects = [arr objectAtIndex:indexPath.row];
    return cell;
}



#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RQPrizeDetail *rq = (RQPrizeDetail*)self.rq;
    NSArray *typeArr = rq.objects[_type];
    NSArray *arr = [typeArr firstObject];
    
    return [OADeatilCell cellHeightWithObjects:[arr objectAtIndex:indexPath.row]];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.separatorInset = UIEdgeInsetsZero;
    cell.backgroundColor = [UIColor clearColor];
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    // NSLog(@"%@",NSStringFromCGPoint( scrollView.contentOffset));
//    //    NSLog(@"%f",self.lastPositonY);
//    //    if (self.lastPositonY==0) {
//    //        NSLog(@"hehe cedede");
//    //    }
//    if(scrollView.contentOffset.y-self.lastPositonY>10&&self.lastPositonY!=0&&!self.hasUp&&scrollView.contentOffset.y>=0){
//        //self.table.y -=40;
//        //self.table.height+=40;
//        
//        [UIView animateWithDuration:0.5 animations:^{
//            
//            self.hasUp =YES;
//            self.hasDown =NO;
//            self.superBtns.y-=40;
//            self.lotteryType.y-=40;
//            _table.contentInset= UIEdgeInsetsMake(0, 0, 0, 0);
//        }];
//    }else if(scrollView.contentOffset.y-self.lastPositonY<-10&&self.lastPositonY!=0&&!self.hasDown&&scrollView.contentOffset.y>=0){
//        [UIView animateWithDuration:0.5 animations:^{
//            self.hasDown=YES;
//            self.hasUp =NO;
//            self.superBtns.y+=40;
//            self.lotteryType.y+=40;
//            _table.contentInset= UIEdgeInsetsMake(45, 0, 0, 0);
//        }];
//        
//    }
//    self.lastPositonY =scrollView.contentOffset.y;
//    
//}

@end
