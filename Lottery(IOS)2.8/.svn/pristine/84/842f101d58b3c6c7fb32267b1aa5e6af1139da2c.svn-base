//
//  NextManualSettingController.m
//  Caipiao
//
//  Created by 王浩 on 15/10/28.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "NextManualSettingController.h"
#import "XDPopupListView.h"
@interface NextManualSettingController ()<XDPopupListViewDelegate,XDPopupListViewDataSource,UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UILabel *typeLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UITextField *contentFiled;
@property (retain, nonatomic) IBOutlet UIImageView *arrowImage;
@property(nonatomic,strong)XDPopupListView *mDropDownListView;
/**时间数组*/
@property(nonatomic,strong)NSArray * mContentList;
@end

@implementation NextManualSettingController


-(NSArray *)mContentList{
    if (_mContentList==nil) {
        _mContentList =@[@"1天",@"5天",@"10天",@"30天",@"永久"];
    }
    return _mContentList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if( self.rq.type.intValue ==0){
        _typeLabel.text =@"代理";
    }else if (self.rq.type.intValue==1){
        _typeLabel.text =@"玩家";
    }
    [self setTargetAndNotification];

}
- (IBAction)createUrl:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




-(void)setTargetAndNotification{
    
    _contentFiled.delegate =self;
    //[_link addTarget:self action:@selector(linkClick:) forControlEvents:UIControlEventTouchUpInside];
    [_contentFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.mDropDownListView = [[XDPopupListView alloc] initWithBoundView:self.timeLabel dataSource:self delegate:self popupType:XDPopupListViewDropDown];
    UITapGestureRecognizer *tapGestureTel = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeClick)];
    [XDNotificationCenter addObserver:self selector:@selector(show:) name:XDListviewshow object:nil];
    [XDNotificationCenter addObserver:self selector:@selector(dismiss:) name:XDListviewdismiss object:nil];
    [_timeLabel addGestureRecognizer:tapGestureTel];
    
}
/**
 *  下拉菜单显示回调
 */

-(void)show:(NSNotification*)notification{
    [self.arrowImage setImage:ResImage(@"messagescenter_arrow_up.png")];
}


/**
 *  下拉菜单隐藏回调
 */

-(void)dismiss:(NSNotification*)notification{
    [self.arrowImage setImage:ResImage(@"messagescenter_arrow_down.png")];
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

#pragma mark - 销毁方法

- (void)dealloc {
    
    [XDNotificationCenter removeObserver:self name:XDListviewdismiss object:nil];
    [XDNotificationCenter removeObserver:self name:XDListviewshow object:nil];
    
}

@end
