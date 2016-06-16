//
//  NewLink.m
//  Caipiao
//
//  Created by 王浩 on 15/10/20.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "NewLink.h"
#import "XDPopupListView.h"
#import "HyperlinksButton.h"
#import "RQDoRetSetting.h"
#import "OAPrizeDetailVC.h"
@interface NewLink()<XDPopupListViewDelegate,XDPopupListViewDataSource,UITextFieldDelegate>

/**下拉列表视图*/
@property(nonatomic,strong)XDPopupListView *mDropDownListView;
/**返点输入栏*/
@property (weak, nonatomic) IBOutlet UITextField *enablePoint;
/**箭头控件*/
@property (weak, nonatomic) IBOutlet UIImageView *image_arrow;
/**链接备注*/
@property (weak, nonatomic) IBOutlet UITextField *enableChar;
/**时间label*/
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
/**时间视图*/
@property (retain, nonatomic) IBOutlet UIView *timeView;
/**类型*/
@property (retain, nonatomic) IBOutlet UILabel *typeLabel;
/**时间数组*/
@property(nonatomic,strong)NSArray * mContentList;
/**链接按钮*/
@property (retain, nonatomic) IBOutlet HyperlinksButton *link;
/**请求*/
@property (nonatomic,strong) RQDoRetSetting *doRetSetting;
/**textFiled*/
@property (nonatomic,assign) int length;

@end
@implementation NewLink

-(NSArray *)mContentList{
    if (_mContentList==nil) {
        _mContentList =@[@"1天",@"5天",@"10天",@"30天",@"永久"];
    }
    return _mContentList;
}



#pragma mark - 其他方法

-(void)viewDidLoad{
    [super viewDidLoad];
    
    if (_type ==NewLinkSettingTypeManual) {
        
    
    if (self.rq.type.intValue==0) {
        self.navigationItem.title =@"手动设置";
            _typeLabel.text =@"玩家";
    }else if (self.rq.type.intValue==1){
         self.navigationItem.title =@"手动设置";
        _typeLabel.text =@"代理";
    }
    }else{
        [self requestData];
    
    }

    [self setTargetAndNotification];
}


//网络请求

-(void)requestData
{
    [HUDView showLoading:self.view];

    self.lists =[NSMutableArray array];
    RQManualSetting *rq = [[RQManualSetting alloc]init];
    rq.type=@0;
    self.rq = rq;
    __block NewLink *blockself = self;
    [rq startPostWithBlock:^(RQManualSetting* rq_, NSError *error_, id rqSender_) {
        
        [HUDView dismissCurrent];
        _enablePoint.placeholder =[NSString stringWithFormat:@"可分配返点范围为0-%lu",(long)rq.fastsetupreturnmax];
        [rq.objects enumerateObjectsUsingBlock:^(NSArray* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj enumerateObjectsUsingBlock:^(NSArray*awardList, NSUInteger idx, BOOL * _Nonnull stop) {
                [awardList enumerateObjectsUsingBlock:^(NSArray *award, NSUInteger idx, BOOL * _Nonnull stop) {
                    [award enumerateObjectsUsingBlock:^(UserAwardList*o, NSUInteger idx, BOOL * _Nonnull stop) {
                        [blockself.lists addObject:o];
                    }];
                    
                }];
            }];
            
        }];

        
        
    } sender:nil];
    
  }


/**
 *给控件设置代理
 *
 */

-(void)setTargetAndNotification{
    _enableChar.delegate =self;
    _enablePoint.delegate =self;
       UIView *accessoryView =[[UIView alloc]initWithFrame:CGRectMake(0, 0,     [UIScreen mainScreen].bounds.size.width
, 45)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.layer.cornerRadius = 5.0;
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(endEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor colorWithRed:231/255.0 green:164/255.0 blue:192/255.0 alpha:1.0] forState:UIControlStateNormal];
    CGFloat margin =7;
    CGFloat width =60;
    btn.frame=CGRectMake(accessoryView.frame.size.width-margin-width, margin, width, accessoryView.frame.size.height-margin*2);
    btn.backgroundColor =[UIColor whiteColor];
    [accessoryView addSubview:btn];
    accessoryView.backgroundColor=[UIColor colorWithRed:200/255.0 green:203/255.0 blue:211/255.0 alpha:1.0];
    _enablePoint.inputAccessoryView =accessoryView;
    [_link addTarget:self action:@selector(linkClick:) forControlEvents:UIControlEventTouchUpInside];
    [_enableChar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_enablePoint addTarget:self action:@selector(textFieldDidChangeForPoint:) forControlEvents:UIControlEventEditingChanged];
    self.mDropDownListView = [[XDPopupListView alloc] initWithBoundView:self.timeView dataSource:self delegate:self popupType:XDPopupListViewDropDown];
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeClick)];
    [XDNotificationCenter addObserver:self selector:@selector(show:) name:XDListviewshow object:nil];
    [XDNotificationCenter addObserver:self selector:@selector(dismiss:) name:XDListviewdismiss object:nil];
    [_timeView addGestureRecognizer:tapGestureTel];

}




-(void)endEditBtn:(UIButton*)btn{
    [self.view endEditing:YES];

}
/**
 *  下拉菜单显示回调
 */

-(void)show:(NSNotification*)notification{
    [self.image_arrow setImage:ResImage(@"arrowUp.png")];
}


/**
 *  下拉菜单隐藏回调
 */

-(void)dismiss:(NSNotification*)notification{
    [self.image_arrow setImage:ResImage(@"arrowDown.png")];
}
/**
 *触发下拉显示的方法
 */

-(void)timeClick{

    [self.mDropDownListView show];
}
/**
 *链接点击时间
 */
-(void)linkClick:(HyperlinksButton*)btn{
    NSLog(@"linkClick");
   OAPrizeDetailVC *vc= [[OAPrizeDetailVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];

}
/**
 *创建连接按钮
 */
- (IBAction)createUrl:(id)sender {
    NSLog(@"生成链接");
    self.doRetSetting =[[RQDoRetSetting alloc]init];
    if (_lists.count==0) {
         HUDShowLoading(@"数据正在加载中,请稍后....", nil);
        return;
    }
    self.doRetSetting.lists=_lists;
    if (_type ==NewLinkSettingTypeManual) {
        
        
        if (self.rq.type.intValue==0) {
           //玩家
            self.doRetSetting.type=0;
        }else if (self.rq.type.intValue==1){
         //代理
            self.doRetSetting.type =1;
        }
        self.doRetSetting.setUp =1;
        self.doRetSetting.isFastSetting=NO;
        self.doRetSetting.setValue=0;
    }else{
       //快捷设置
        self.doRetSetting.type =1;
        self.doRetSetting.isFastSetting=YES;
        self.doRetSetting.setUp =2;
        if (_enablePoint.text.length) {
            
            self.doRetSetting.setValue =[_enablePoint.text floatValue];
        }else{
            HUDShowMessage(@"请输入返点..", nil);
            return;
        }
    }
    

    
    
    
  
    if ([_timeLabel.text isEqualToString:@"永久"]) {
        self.doRetSetting.days =-1;
    }else if([_timeLabel.text isEqualToString:@"1天"]){
    self.doRetSetting.days =1;
    }else if ([_timeLabel.text isEqualToString:@"5天"]){
    self.doRetSetting.days =5;
    }else if ([_timeLabel.text isEqualToString:@"10天"]){
        self.doRetSetting.days =10;

    }else if ([_timeLabel.text isEqualToString:@"30天"]){
        self.doRetSetting.days =30;

    }
    if (_enableChar.text.length||self.length==0) {
        if (self.length<4&&self.length>0) {
            HUDShowMessage(@"输入的文字不能小于4个字符.", nil);
            return;
        }
        self.doRetSetting.memo =_enableChar.text;
    }else{
        HUDShowMessage(@"请输入备注信息..", nil);
        return;
    }
    [HUDView showLoadingToView:[UIApplication sharedApplication].keyWindow msg:@"正在生成链接..请稍后" subtitle:nil touchToHide:NO];
      __block NewLink *blockself = self;
    [self.doRetSetting startPostWithBlock:^(RQBase* rq_, NSError *error_, id rqSender_) {
        
         [HUDView dismissCurrent];
        if (rq_.msgContent){
            HUDShowMessage(rq_.msgContent,nil);
        }else{
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        if ([blockself.doRetSetting.status isEqualToString:@"success"]) {
            
            [HUDView showMessageToView:self.view.window msg:@"添加链接成功" subtitle:nil];
        }
            
        }
        
    } sender:nil];
    
    
    
}


#pragma mark  - 触摸事件

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}


#pragma mark - XDPopupListViewDelegate

-(void)clickedListViewAtIndexPath:(NSIndexPath *)indexPath{
  
    _timeLabel.text =self.mContentList[indexPath.row];
}


-(CGFloat)itemCellHeight:(NSIndexPath *)indexPath{
    return 44.0f;
}


#pragma mark -XDPopupListViewDataSource

- (UITableViewCell *)itemCell:(NSIndexPath *)indexPath{
    if (self.mContentList.count == 0) {
        return nil;
    }
    static NSString *identifier = @"id";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    cell.textLabel.text = self.mContentList[indexPath.row];
    cell.textLabel.textColor=[UIColor colorWithRed:67/255.0 green:67/255.0 blue:67/255.0 alpha:1.0];
    return cell;
    
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return self.mContentList.count;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}


#pragma mark -UITextField addTarget

-(void)textFieldDidChangeForPoint:(UITextField*)textField{
    if ([textField.text doubleValue]>self.rq.fastsetupreturnmax) {
        HUDShowMessage(@"输入返点超出上限", nil);
        textField.text=[NSString stringWithFormat:@"%lu",self.rq.fastsetupreturnmax];
    }
}



- (void)textFieldDidChange:(UITextField *)textField
{
    
    
    
    // NSLog(@"%@",[self convertToInt:textField.text]);
    
    
    // NSLog(@"---%d",textField.text.length);
    
    
    
    if (textField == self.enableChar) {
        
        //        NSString *newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSString *newStr = self.enableChar.text;
        
        
        // 要求：昵称唯一，中文、数字、字母和下划线随意组合，长度1到20个字符（10个汉字），字母区分大小写。
        // 因为utf 8 是可变长度的，所以还要处理一下
        self.length = 0;
        for (int i = 0; i < newStr.length; i++) {
            NSString *subString = [newStr substringWithRange:NSMakeRange(i, 1)];
            const char *cString = [subString UTF8String];
            if (strlen(cString) >= 2) {
                self.length += 2;
            } else {
                self.length ++;
            }
            
            if (self.length >= 16) {
                textField.text = [newStr substringToIndex:i+1];
                break;
            }
        }
        
        //        if (length <= 16) {
        //            return YES;
        //        } else {
        //            return NO;
        //        }
        
        
        //        if (textField.text.length > 16) {
        //            textField.text = [textField.text substringToIndex:16];
        //        }
    }
}


#pragma mark - 销毁方法

- (void)dealloc {
    
    
    [XDNotificationCenter removeObserver:self name:XDListviewdismiss object:nil];
    [XDNotificationCenter removeObserver:self name:XDListviewshow object:nil];
    
}
@end
