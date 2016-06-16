//
//  HigherChaseSetting.m
//  Caipiao
//
//  Created by 王浩 on 15/12/1.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "HigherChaseSetting.h"
#import "BaseChaseViewCell.h"
#import "HigherChaseViewCell.h"
#import "SaveViewCell.h"
#import "HighChaseNumType.h"
#import "HMTableViewController.h"
@interface HigherChaseSetting ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *cells;
@property (nonatomic,strong)BaseChaseViewCell*cell;
@property (nonatomic,strong)HigherChaseViewCell*cell1;
@property (nonatomic,strong)SaveViewCell *cell2;

@end

@implementation HigherChaseSetting

-(NSMutableArray*)cells{
    if (_cells ==nil) {
        _cells =[NSMutableArray array];
        
        self.cell= [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        [_cells addObject:self.cell];
        
        self.cell1=[self.tableView dequeueReusableCellWithIdentifier:@"cell1"];
        self.cell1.textField1.delegate=self;
        self.cell1.textField11.delegate=self;
        self.cell1.textField2.delegate=self;
        self.cell1.textField22.delegate=self;
        self.cell1.textField3.delegate=self;
        self.cell1.textField33.delegate=self;
        self.cell1.textField333.delegate=self;
        self.cell1.textField4.delegate=self;
        self.cell1.textField44.delegate=self;
        self.cell1.textField444.delegate=self;
        [_cells addObject:self.cell1];
        
        self.cell2=[self.tableView dequeueReusableCellWithIdentifier:@"cell2" ];
        [_cells addObject:self.cell2];
    }
    return _cells;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self setExtraCellLineHidden:self.tableView];
    self.title=@"追号设置";
    self.tableView.bounces=YES;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    UIButton *view =[[UIButton alloc]init];
    [view setBackgroundImage:ResImage(@"ToPlan.png") forState:UIControlStateNormal];
    // view.backgroundColor =[UIColor orangeColor];
    view.frame =CGRectMake(0, 0, 320, 50);
    [view addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseChaseViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HigherChaseViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SaveViewCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    
    self.tableView.tableFooterView =view;
    
    [self cells];
    HighChaseNumType *highChaseNumType = [NSKeyedUnarchiver unarchiveObjectWithFile: [self filePath] ];
    if (highChaseNumType) {
        self.cell.numLabel.text=JXIntToString(highChaseNumType.totalIssue);
        self.cell.numLabel1.text=JXIntToString(highChaseNumType.startBeiShu);
        self.cell.switchView.on=highChaseNumType.isStop;
        if (highChaseNumType.type==HighterChaseNumGeQi) {
            self.cell1.btn1.selected=YES;
            self.cell1.textField1.text=JXIntToString(highChaseNumType.issue);
            self.cell1.textField11.text=JXIntToString(highChaseNumType.beiShu);
        }else if(highChaseNumType.type==HighterChaseNumFenDuan){
            self.cell1.btn2.selected=YES;
            self.cell1.textField2.text=JXIntToString(highChaseNumType.issue);
            self.cell1.textField22.text=JXIntToString(highChaseNumType.beiShu);
        }else if(highChaseNumType.type==HighterChaseNumYingLiJe){
            self.cell1.btn3.selected=YES;
            self.cell1.textField3.text =JXIntToString(highChaseNumType.issue);
            self.cell1.textField33.text=JXIntToString(highChaseNumType.payOffAmount);
            self.cell1.textField333.text=JXIntToString(highChaseNumType.payOffAmount2);
        }else if(highChaseNumType.type==HighterChaseNumYingLiRate){
            self.cell1.btn4.selected=YES;
            self.cell1.textField4.text=JXIntToString(highChaseNumType.issue);
            self.cell1.textField44.text=JXIntToString(highChaseNumType.payOffRate);
            self.cell1.textField444.text=JXIntToString(highChaseNumType.payOffRate2);

        }
    }else{
        self.cell.numLabel.text=JXIntToString(10);
        self.cell.numLabel1.text=JXIntToString(1);
        self.cell.switchView.on=YES;

        self.cell1.btn1.selected=YES;
        self.cell1.textField1.text=JXIntToString(2);
        self.cell1.textField11.text=JXIntToString(2);

    
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)submit:(UIButton*)btn{
    HighChaseNumType *highChaseType =nil;
    for (UIButton *btn in  self.cell1.btns) {
        if (btn.isSelected) {
            highChaseType=[[HighChaseNumType alloc]init];
            
            highChaseType.totalIssue =[self.cell.numLabel.text intValue];
            highChaseType.startBeiShu=[self.cell.numLabel1.text intValue];
            highChaseType.isStop =self.cell.switchView.isOn;
            if(btn==self.cell1.btn1){
                if(self.cell1.textField1.text.length==0){
                      HUDShowMessage(@"请设置期数..", nil);
                    return;
                }
                
                if (self.cell1.textField11.text.length==0) {
                    HUDShowMessage(@"请设置倍数..", nil);
                    return;
                }
                highChaseType.issue =[self.cell1.textField1.text intValue];
                highChaseType.beiShu =[self.cell1.textField11.text intValue];
                highChaseType.type =HighterChaseNumGeQi;
                break;
            }else if (btn==self.cell1.btn2){
                if(self.cell1.textField2.text.length==0){
                    HUDShowMessage(@"请设置期数..", nil);
                    return;
                }
                
                if (self.cell1.textField22.text.length==0) {
                    HUDShowMessage(@"请设置倍数..", nil);
                    return;
                }
                highChaseType.issue =[self.cell1.textField2.text intValue];
                highChaseType.beiShu =[self.cell1.textField22.text intValue];
                highChaseType.type =HighterChaseNumFenDuan;
                break;
            }else if (btn==self.cell1.btn3){
                if(self.cell1.textField3.text.length==0){
                    HUDShowMessage(@"请设置期数..", nil);
                    return;
                }
                
                if (self.cell1.textField33.text.length==0) {
                    HUDShowMessage(@"请设置盈利金额..", nil);
                    return;
                }
                
                if (self.cell1.textField333.text.length==0) {
                    HUDShowMessage(@"请设置盈利金额..", nil);
                    return;
                }
                highChaseType.issue =[self.cell1.textField3.text intValue];
                highChaseType.payOffAmount=[self.cell1.textField33.text intValue];
                highChaseType.payOffAmount2=[self.cell1.textField333.text intValue];
                highChaseType.type =HighterChaseNumYingLiJe;
                

                break;
            }else if (btn==self.cell1.btn4){
                if(self.cell1.textField4.text.length==0){
                    HUDShowMessage(@"请设置期数..", nil);
                    return;
                }
                
                if (self.cell1.textField44.text.length==0) {
                    HUDShowMessage(@"请设置盈利率..", nil);
                    return;
                }
                
                if (self.cell1.textField444.text.length==0) {
                    HUDShowMessage(@"请设置盈利率..", nil);
                    return;
                }
                highChaseType.issue =[self.cell1.textField4.text intValue];
                highChaseType.payOffRate=[self.cell1.textField44.text intValue];
                highChaseType.payOffRate2=[self.cell1.textField444.text intValue];
                highChaseType.type=HighterChaseNumYingLiRate;

                break;
            }
        }
    }
    
    
    
    
    if (self.cell2.save_Btn.isSelected) {
        
        BOOL flag = [NSKeyedArchiver archiveRootObject:highChaseType toFile:[self filePath]];
        if(flag) {
            NSLog(@"归档成功！");
        }
				
    }
//    HighChaseNumType *high1 = [NSKeyedUnarchiver unarchiveObjectWithFile: [self filePath] ];
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.delegate respondsToSelector:@selector(higherChase:popFinished:)]) {
        [self.delegate higherChase:self popFinished:highChaseType];
    }
}
-(NSString *)filePath
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDirectory, YES)objectAtIndex:0];
    NSString *path = [docPath stringByAppendingPathComponent:@"highNum"];
    
    //  NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/texts"]; //两种方法都可以
    
    
    return path;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0||section==1) {
        
        return 40.f;
    }else{
        return 6.f;
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // cell.detailTextLabel.text=@"尼玛的";
    UITableViewCell *cell =nil;
    if (indexPath.section==0) {
        cell =[self.cells objectAtIndex:0];
        
        
        
        
    }else if(indexPath.section==1){
        cell  =[self.cells objectAtIndex:1];
    }else if (indexPath.section ==2){
        cell  =[self.cells objectAtIndex:2];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 125.f;
    }else if (indexPath.section==1){
        return 297.f;
    }else{
        return 44.f;
    }
    
    
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
////    if (section==0) {
////        return @"基本参数";
////    }else if(section==1){
////        return @"高级参数";
////    }else{
////        return @"你妹";
////    }
//
//
//
//}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //创建一个用于返回效果的UIView，用来承接文字或图片
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 40.0)] ;
    customView.backgroundColor=RGBAHex(@"DDDDDD");
    //自定义文字效果
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    // headerLabel.backgroundColor = [UIColor orangeColor];
    //字体不透明
    headerLabel.opaque =NO;
    // headerLabel.textColor = [UIColor purpleColor];
    //
    headerLabel.highlightedTextColor = [UIColor grayColor];
    //字体效果
    headerLabel.font = [UIFont systemFontOfSize:15];
    //设置label格式
    headerLabel.frame = CGRectMake(10.0, 0.0, 320.0, 40.0);
    
    if (section == 0) {
        headerLabel.text =  @"基本参数";
        
    }else if(section==1){
        headerLabel.text = @"高级参数";
    }else{
        headerLabel.text =@"";
        
    }    //将自定义的内容添加到UIView上
    [customView addSubview:headerLabel];
    //返回自定义好的效果
    return customView;
}

- (void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    
}



-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame1 = textField.frame;
    CGRect frame = [textField.superview convertRect:textField.frame toView:self.view];
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    // self.view.frame =CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view endEditing:YES];
    return YES;
}
@end
