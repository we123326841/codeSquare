//
//  PlayManualSettingController.m
//  Caipiao
//
//  Created by 王浩 on 15/10/26.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "PlayManualSettingController.h"
#import "OADeatilCell.h"
#import "RQManualSetting.h"
#import "NewLink.h"
@interface PlayManualSettingController ()<UITableViewDelegate>
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
@property(nonatomic,retain)NSMutableArray *mySSCCells;
@property(nonatomic,retain)NSMutableArray *myKLCCells;
@property(nonatomic,retain)NSMutableArray *my11X5Cells;
@property(nonatomic,retain)NSMutableArray *myDPCells;
@property(nonatomic,retain)NSMutableArray *myKSCCells;
@property(nonatomic,retain)NSMutableArray *mainCells;
@property (nonatomic,assign)BOOL isSelected;
@property (nonatomic,strong)NSMutableArray *userAwardLists;
@property (nonatomic,assign)int count ;
@property (nonatomic,assign)int awardCount;
@end

@implementation PlayManualSettingController
- (IBAction)allClick:(id)sender {
    [self switchModel:RadioButtonTypeAll];
}
- (IBAction)guiLinClick:(id)sender {
    [self switchModel:RadioButtonTypeGuiLin];
}


-(void)switchModel:(RadioButtonType)type{
    RQManualSetting *rq = (RQManualSetting*)self.rq;
    [rq.objects enumerateObjectsUsingBlock:^(NSArray* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(NSArray*awardList, NSUInteger idx, BOOL * _Nonnull stop) {
            [awardList enumerateObjectsUsingBlock:^(NSArray *award, NSUInteger idx, BOOL * _Nonnull stop) {
               __block int index =0;
                [award enumerateObjectsUsingBlock:^(UserAwardList*o, NSUInteger idx, BOOL * _Nonnull stop) {
                    
//                    o.radioButtonType =type;
                    o.radioButtonType =type;
                    if (type==RadioButtonTypeGuiLin) {
                        //o.guiLinDirectRet=@"0";
                        //o.guiLinThreeoneRet=@"0";
                        
                        
                        
                        o.guiLinDirectRet=@"0";
                        o.guiLinThreeoneRet=@"0";
                        o.directRetReal=@"0";
                        o.threeoneRetReal=@"0";
                       // o.isSelected=YES;
                        if (index==0) {
                            
                            o.isSelected=YES;
                        }
                    }else if (type==RadioButtonTypeAll){
//                        o.directRet =o.directRet1;
//                        o.threeoneRet=o.threeoneRet1;
                        
                        
                        o.directRet =o.directRet1;
                        o.threeoneRet=o.threeoneRet1;
                        o.directRetReal=o.directRet1;
                        o.threeoneRetReal=o.threeoneRet1;
                      //  o.isSelected=YES;

                        if (index==0) {
                            
                            o.isSelected=YES;
                        }
                    }
                    index++;

                }];
                
            }];
        }];
        
    }];
    [self.table reloadData];
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手动设置";
    MSNotificationCenterAddObserver(@selector(reloadTableData), TABLEVIEW_RELOAD);
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    // [rightbutton setBackgroundImage:ResImage(@"qr_menu.png") forState:UIControlStateNormal];
    rightbutton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    rightbutton.titleLabel.font =[UIFont systemFontOfSize:16];
    [rightbutton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [rightbutton setTitle:@"下一步" forState:UIControlStateNormal];
    rightbutton.frame = CGRectMake(0, 0, 100, 20);
    [rightbutton addTarget:self action:@selector(gotoNextStep) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem=item;
    [item release];
    
    self.datas = @[].mutableCopy;
    
    _type = DetailTypeSSC;
    _table.delegate =self;
    _table.bounces=NO;
    _table.contentInset =UIEdgeInsetsMake(45, 0, 0, 0);
    [_table registerNib:[UINib nibWithNibName:@"OADeatilCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    _table.tableFooterView = [[UIView new]autorelease];
    [self requestData];
    
    
    
}


-(void)reloadTableData{
    [self.table reloadData];
}

-(void)requestData
{
    RQManualSetting *rq = [[RQManualSetting alloc]init];
    rq.type=@0;
    self.rq = rq;
    __block PlayManualSettingController *blockself = self;
    [rq startPostWithBlock:^(RQManualSetting* rq_, NSError *error_, id rqSender_) {
        [blockself.table reloadData];
    } sender:nil];
    
    [rq release];
}

-(void)gotoNextStep{
    RQManualSetting *rq = (RQManualSetting*)self.rq;
    BOOL isSelected=[self checkSelected:rq];
    if (isSelected) {
        _userAwardLists =[NSMutableArray array];
        [rq.objects enumerateObjectsUsingBlock:^(NSArray* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj enumerateObjectsUsingBlock:^(NSArray*awardList, NSUInteger idx, BOOL * _Nonnull stop) {
                [awardList enumerateObjectsUsingBlock:^(NSArray *award, NSUInteger idx, BOOL * _Nonnull stop) {
                    [award enumerateObjectsUsingBlock:^(UserAwardList*o, NSUInteger idx, BOOL * _Nonnull stop) {
                        if (o.isSelected) {
                            [_userAwardLists addObject:o];
                        }
                    }];
                    
                }];
            }];
            
        }];

        
        
        
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"NextManualSettingController" bundle:nil];
        NewLink*viewCtl = [storyBoard instantiateInitialViewController];
        viewCtl.rq=rq;
        viewCtl.lists=_userAwardLists;
        viewCtl.type =NewLinkSettingTypeManual;
        // viewCtl.navigationItem.backBarButtonItem.tintColor=[UIColor whiteColor];
        //rAddNewLinkController *viewCtl =[[AddNewLinkController alloc]init];
        [self.navigationController pushViewController:viewCtl animated:YES];
    }else{
        HUDShowMessage(@"至少要选择一项...", nil);
    
    }
    
}



-(BOOL)checkSelected:(RQManualSetting*)rq{
   // _isSelected=NO;
    self.count =0;
    self.awardCount=0;
    
    [rq.objects enumerateObjectsUsingBlock:^(NSArray* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(NSArray*awardList, NSUInteger idx, BOOL * _Nonnull stop) {
            [awardList enumerateObjectsUsingBlock:^(NSArray *award, NSUInteger idx, BOOL * _Nonnull stop) {
               
                   
                    self.awardCount++;
                    for (int i=0; i<award.count; i++) {
                        UserAwardList *list=award[i];
                        if(list.isSelected&&![list.directRetReal isEqualToString:@"未设置"]){
                            self.count++;
                            break;
                        }
                    }

                    
                    
                    
                
                
            }];
        }];
        
    }];
    NSLog(@"count ==%d  awardCount ==%d",self.count ,self.awardCount);
    return self.count==self.awardCount ;
    
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
    RQManualSetting *rq = (RQManualSetting*)self.rq;
    NSArray *typeArr = rq.objects[_type];
    NSArray *arr = [typeArr firstObject];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"Cell";
    
    OADeatilCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    RQManualSetting *rq = (RQManualSetting*)self.rq;
    NSArray *typeArr = rq.objects[_type];
    NSArray *arr = [typeArr firstObject];
    //cell.objects = [arr objectAtIndex:indexPath.row];
    // [cell setObjects:[arr objectAtIndex:indexPath.row]];
    [cell setObjectsforManual:[arr objectAtIndex:indexPath.row]];
    //UIView* view=[cell.contentView viewWithTag:100];
    //    if ([cell.contentView.subviews isKindOfClass:[OADeatilViewOne class]]) {
    //        OADeatilViewOne *one=(OADeatilViewOne*)view;
    //        [one.radioBtn setImage: ResImage(@"checkon.png")forState:UIControlStateSelected];
    //    }else if ([view isKindOfClass:[OADeatilViewTwo class]]){
    //        OADeatilViewTwo *two =(OADeatilViewTwo*)view;
    //        [two.radioBtn setImage: ResImage(@"checkon.png")forState:UIControlStateSelected];
    //    }
    return cell;
}



#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RQManualSetting *rq = (RQManualSetting*)self.rq;
    NSArray *typeArr = rq.objects[_type];
    NSArray *arr = [typeArr firstObject];
    
    return [OADeatilCell cellHeightWithObjectsForManaul:[arr objectAtIndex:indexPath.row]];
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.separatorInset = UIEdgeInsetsZero;
    cell.backgroundColor = [UIColor clearColor];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // NSLog(@"%@",NSStringFromCGPoint( scrollView.contentOffset));
    //    NSLog(@"%f",self.lastPositonY);
    //    if (self.lastPositonY==0) {
    //        NSLog(@"hehe cedede");
    //    }
    if(scrollView.contentOffset.y-self.lastPositonY>10&&self.lastPositonY!=0&&!self.hasUp&&scrollView.contentOffset.y>=0){
        //self.table.y -=40;
        //self.table.height+=40;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.hasUp =YES;
            self.hasDown =NO;
            self.superBtns.y-=40;
            self.lotteryType.y-=40;
            _table.contentInset= UIEdgeInsetsMake(0, 0, 0, 0);
        }];
    }else if(scrollView.contentOffset.y-self.lastPositonY<-10&&self.lastPositonY!=0&&!self.hasDown&&scrollView.contentOffset.y>=0){
        [UIView animateWithDuration:0.5 animations:^{
            self.hasDown=YES;
            self.hasUp =NO;
            self.superBtns.y+=40;
            self.lotteryType.y+=40;
            _table.contentInset= UIEdgeInsetsMake(45, 0, 0, 0);
        }];
        
    }
    self.lastPositonY =scrollView.contentOffset.y;
    
}



@end
