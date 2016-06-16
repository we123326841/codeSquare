//
//  HMTableViewController.m
//  CaiPiaoDemoyo
//
//  Created by 王浩 on 15/11/17.
//  Copyright © 2015年 王浩. All rights reserved.
//

#import "HMTableViewController.h"
#import "HigherNumTableViewCell.h"
#import "LotteryTimer.h"
#import "IssueItem.h"
#import "HigherChaseModel.h"
#import "CDBetList.h"
#import "RQBet.h"
#import "RQBase.h"
#import "RQAllTraceIssues.h"
#import "ResultViewController.h"
#import "HigherChaseSetting.h"
#import "HighChaseNumType.h"

#define HMMAX_VALUE 100000
@interface HMTableViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,RQBaseDelegate,HigherChaseSettingDelegate,HigherNumTableViewCellDelagete>
@property (retain, nonatomic) IBOutlet UILabel *totalLabel;
@property (retain, nonatomic) IBOutlet UILabel *issueLabel;
@property (retain, nonatomic) IBOutlet UILabel *currentIssue;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong,nonatomic) NSMutableArray *higherChaseModels;
@property(nonatomic,strong) NSMutableArray *betList;
@property(nonatomic,strong) NSMutableArray * mutiles;
@property (nonatomic,assign)  int totalAmount;
@property (nonatomic,assign)BOOL isStop;
@property (nonatomic, strong) NSArray *traceIssueList;
@property (nonatomic,strong)NSString *bettingMessage;
@property (nonatomic,assign)int totalQishu;
@property (nonatomic,assign)int geqiBeiShu;
@property (nonatomic,assign)int geqiQiShi;
@property (nonatomic,assign)int qishiBeiShu;
@property (nonatomic,assign)int qiShuFD;
@property (nonatomic,assign)int beiShuFD;
@property (nonatomic,assign)int qiShuPF;
@property (nonatomic,assign)int yingLiPF;
@property (nonatomic,assign)int yingLi2PF;
@property (nonatomic,assign)int qiShuPFR;
@property (nonatomic,assign)int yingLiPFR;
@property (nonatomic,assign)int yingLi2PFR;
@property (nonatomic,assign)NSInteger sectionNum;
@property (nonatomic,assign)NSInteger section0;
@property (nonatomic,assign)NSInteger section1;
@property (nonatomic,strong)NSMutableArray *sectionModels0;
@property (nonatomic,strong)NSMutableArray *sectionModels1;
@property (nonatomic,assign)BOOL isNeedAlertShow;
@property (nonatomic,assign)int mode;
@property (nonatomic,assign)BOOL isVisible;
@property (nonatomic,strong)IssueChangeAlert *alert;
@property (nonatomic,assign)BOOL isGeQiMax;
@end

@implementation HMTableViewController

-(NSMutableArray*)higherChaseModels{
    int zhuShu =[self getZhuShu];
        if (_higherChaseModels==nil) {
        _higherChaseModels=[NSMutableArray array];
        //  _mutiles=[NSMutableArray array];
        
            
        IssueItem *issueItem=[IssueItem current];
        NSString *issue=issueItem.issueNumber;
        
        //NSArray *issues=[issue componentsSeparatedByString:@"-"];
        long long issueInt= [issue longLongValue];
        long long issueCode =issueInt;
        issue=[NSString stringWithFormat:@"%lld",issueInt];
        if (issueItem.lotteryId==14&&issueItem.channelid==4) {
            issue=[issue substringFromIndex:issue.length-4];
        }else{
            issue=[issue substringFromIndex:issue.length-3];
        }
        issueInt =[issue intValue];
        //限制倍数
        NSInteger limitTimes = [self limitTimes];
        CDBetList *bet=self.betList[0];
        int mode=[bet.mode integerValue];
        self.mode =mode;
        MenuItemModel *itemModel =[BetManager menuItemModelForMethodId:[bet.methodId intValue] lottery:[bet.lotteryId intValue]channelId:[bet.channelId intValue]];
        
        
        float methodPrize=[itemModel.methodPrize floatValue];
        double prizeNum=0 ;
        if(mode==1){
            prizeNum=methodPrize;
            
        }else{
            prizeNum =methodPrize*10/100.0;
        }
        
        for(int i =1;i<=self.totalQishu;i++){
            
            BOOL isneedSX =NO;
            
            
            long long beiShu=0;
            
            if (_type==HighterChaseNumGeQi) {
                beiShu=(long long)pow(self.geqiBeiShu, (i-1)/self.geqiQiShi)*self.qishiBeiShu;
                
                if (beiShu>=(int)limitTimes) {
                    self.isGeQiMax=YES;
                    
                   
                }
                
                if (self.isGeQiMax) {
                    beiShu =(int)limitTimes;
                    self.isNeedAlertShow=YES;
                }
                
                
            }else if(_type==HighterChaseNumFenDuan){
                if (i<=self.qiShuFD) {
                    beiShu =self.qishiBeiShu;
                    if (beiShu>=(int)limitTimes) {
                        
                        
                        beiShu =(int)limitTimes;
                        self.isNeedAlertShow=YES;
                    }
                    
                }else{
                    beiShu =self.beiShuFD;
                    if (beiShu>=(int)limitTimes) {
                        
                        
                        beiShu =(int)limitTimes;
                        self.isNeedAlertShow=YES;
                    }
                }
                
            }else if(_type ==HighterChaseNumYingLiJe){
                for (int j =1; j<=HMMAX_VALUE; j++) {
                    
                    if (i<=self.qiShuPF) {
                        if (i==1) {
                            if (mode!=1) {
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }
                                
                                

                                if (self.yingLiPF <= prizeNum * beiShu - beiShu * zhuShu * 0.2) {
                                    
                                    break;
                                    
                                }
                            }else{
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }

                                if (self.yingLiPF <= prizeNum * beiShu - beiShu * zhuShu * 2) {
                                    
                                    break;
                                }
                                
                            }
                        }else{
                            if (mode!=1) {
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }
                                if (self.yingLiPF <= prizeNum
                                    * beiShu
                                    - (beiShu * zhuShu * 0.2 + [[_higherChaseModels[i-2] totalNumber] doubleValue])) {
                                    
                                    
                                    break;
                                    
                                }
                            }else{
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }


                                if (self.yingLiPF <= prizeNum
                                    * beiShu
                                    - (beiShu * zhuShu * 2 + [[_higherChaseModels[i-2] totalNumber] intValue])) {
                                    
                                    break;
                                }
                                
                            }
                            
                        }
                    }else{
                        if (i==1) {
                            if (mode!=1) {
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }

                                
                                if (self.yingLi2PF <= prizeNum * beiShu - beiShu * zhuShu
                                    * 0.2) {
                                    
                                    break;
                                    
                                }
                            }else{
                                
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }
                                
                                if (self.yingLi2PF <= prizeNum * beiShu - beiShu * zhuShu * 2) {
                                    
                                    
                                    break;
                                }
                                
                            }
                        }else{
                            if (mode!=1) {
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }

                                if (self.yingLi2PF <= prizeNum
                                    * beiShu
                                    - (beiShu * zhuShu * 0.2 + [[_higherChaseModels[i-2] totalNumber] doubleValue])) {
                                    
                                    break;
                                    
                                }
                                
                            }else{
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }

                                if (self.yingLi2PF <= prizeNum
                                    * beiShu
                                    - (beiShu * zhuShu * 2 + [[_higherChaseModels[i-2] totalNumber] doubleValue])) {
                                    
                                    break;
                                }
                                
                            }
                            
                        }
                        
                    }
//                    if(j==HMMAX_VALUE){
//                        beiShu=(int)limitTimes;
//                        self.isNeedAlertShow=YES;
//                        isneedSX =YES;
//                    }
                }
                
                
            }else if (_type ==HighterChaseNumYingLiRate){
                for (int j =1; j<=HMMAX_VALUE; j++) {
                    
                    if (i<=self.qiShuPFR) {
                        if (i==1) {
                            if (mode!=1) {
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }

                                if (self.yingLiPFR <= ((prizeNum * beiShu - beiShu * zhuShu
                                                        * 0.2) / (beiShu * zhuShu * 0.2)) * 100) {
                                    
                                    break;
                                    
                                }
                            }else{
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }

                                if (self.yingLiPFR <= ((prizeNum * beiShu - beiShu * zhuShu
                                                        * 2) / (beiShu * zhuShu * 2)) * 100) {
                                    
                                    break;
                                }
                            }
                        }else{
                            if(mode!=1){
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }

                                if (self.yingLiPFR <= (prizeNum * beiShu - (beiShu * zhuShu
                                                                       * 0.2 + [[_higherChaseModels[i-2] totalNumber] doubleValue]))
                                    / ((beiShu * self.betList.count * 0.2 + [[_higherChaseModels[i-2] totalNumber] doubleValue]))
                                    * 100) {
                                    
                                    break;
                                    
                                }
                            }else{
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }


                                if (self.yingLiPFR <= (prizeNum * beiShu - (beiShu * zhuShu
                                                                       * 2 + [[_higherChaseModels[i-2] totalNumber] doubleValue]))
                                    / ((beiShu * zhuShu * 2 + [[_higherChaseModels[i-2] totalNumber] doubleValue])) * 100) {
                                    
                                    break;
                                }
                                
                            }
                            
                            
                        }
                    }else{
                        if(i==1){
                            if (mode!=1) {
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }
                                if (self.yingLi2PFR <= ((prizeNum * beiShu - beiShu * zhuShu
                                                         * 0.2) / (beiShu * zhuShu * 0.2)) * 100) {
                                    
                                    
                                    break;
                                    
                                }
                            }else{
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }

                                if (self.yingLi2PFR <= ((prizeNum * beiShu - beiShu * zhuShu
                                                         * 2) / (beiShu * zhuShu * 2)) * 100) {
                                    
                                    break;
                                }
                                
                            }
                        }else{
                            if (mode!=1) {
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }


                                if (self.yingLi2PFR <= (prizeNum * beiShu - (beiShu * zhuShu
                                                                        * 0.2 + [[_higherChaseModels[i-2] totalNumber] doubleValue]))
                                    / ((beiShu * zhuShu * 0.2 + [[_higherChaseModels[i-2] totalNumber] doubleValue]))
                                    * 100) {
                                    
                                    break;
                                    
                                }
                            }else{
                                beiShu = j;
                                if (beiShu>=(int)limitTimes) {
                                    
                                    
                                    beiShu =(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                }
                                if(j==HMMAX_VALUE){
                                    beiShu=(int)limitTimes;
                                    self.isNeedAlertShow=YES;
                                    isneedSX =YES;
                                }

                                if (self.yingLi2PFR <= (prizeNum * beiShu - (beiShu * zhuShu
                                                                        * 2 + [[_higherChaseModels[i-2] totalNumber] doubleValue]))
                                    / ((beiShu * zhuShu * 2 + [[_higherChaseModels[i-2] totalNumber] doubleValue])) * 100) {
                                    
                                    break;
                                }
                                
                                
                            }
                            
                        }
                    }
//                    if (i==3) {
//                        
//                        NSLog(@"ni ni=%d",j);
//                    }
//                    if(j==HMMAX_VALUE){
//                        beiShu=(int)limitTimes;
//                        self.isNeedAlertShow=YES;
//                        isneedSX =YES;
//                    }
                }
                
            }
            //[self.mutiles addObject:@(beiShu)];
            
            double totalNum =0;
            
            if (i==1) {//1 为元
                if(mode==1){
                    totalNum =beiShu*zhuShu*2;
                }else{
                    totalNum =beiShu*zhuShu*0.2;
                }
                
            }else{
                if(mode==1){
                    
                    
                    totalNum =beiShu*zhuShu*2+[[_higherChaseModels[i-2] totalNumber] doubleValue];
                    
                }else{
                    
                    
                    totalNum =beiShu*zhuShu*0.2+[[_higherChaseModels[i-2] totalNumber] doubleValue];
                    
                }
                
                
                
            }
            
            
            HigherChaseModel *model =[[HigherChaseModel alloc]init];
            
            double payOffNum =prizeNum*beiShu -totalNum;
            double payOffRate  =(payOffNum/totalNum)*100;
            model.serialNumber =JXIntToString(i);
            model.beiShuNumber =JXLongToString(beiShu);
            model.issueNumber=JXLongToString(issueInt);
            model.totalNumber=JXDoubleToString(totalNum);
            model.payOffNumber=JXDoubleToString(payOffNum);
            model.payOffRate = JXFloatToString(payOffRate);
            model.beiTouLimit =JXIntToString((int)limitTimes);
            model.methodName =itemModel.showName;
            model.isNeedSX =isneedSX;
            model.issueCode =issueCode;
            [_higherChaseModels addObject:model];
            issueInt++;
            issueCode++;
        }
        
        
        
        //zhuiQi.setText(String.format(zhuiQi.getText().toString(),models.size()));
        //换地方了唷
        //        _issueLabel.text =[NSString stringWithFormat:@"追 %lu 期",(unsigned long)[_higherChaseModels count]];
        //        double totalMoney = [self zhuiHaoTotalMoney];
        //        //total_num.setText(String.format(total_num.getText().toString(),totalMoney ));
        //        _totalLabel.text =[NSString stringWithFormat:@"总计 %f 元",totalMoney];
        
    }
    
    
    
    
    return _higherChaseModels;
    
}



-(int)getZhuShu{
    int zhuShu =0;
    for (CDBetList *bet in self.betList){
        zhuShu += [bet.count intValue];
        
    }
    
    return zhuShu;


}



-(void)showOrjump{
    HighChaseNumAlert *alert = [HighChaseNumAlert alertWithTitle:@"计划已调整"
                                                         message:nil
                                                          detail:nil
                                                         buttons:@"调整设置",@"查看计划",nil];
    [alert show];
    [alert setCompleteBlock:^(WhiteAlert *a, NSInteger buttonIndex) {
        if (buttonIndex==0) {
            [self nextDetail:nil];
        }
        
        
        
    }];
    
}

-(IssueChangeAlert*)alert{
    if (_alert==nil) {
       _alert = [IssueChangeAlert alertWithTitle:@"奖期已切换"
                                                           message:@"吉利分分彩第2201期已结束,您的注单将进入第2202期"
                                                            detail:nil
                                                           buttons:@"你妹",@"确定",nil];
    
    }
    return _alert;
}



-(void)openIssueChangeDiglag{
   
    
    
    IssueItem *item=[IssueItem current];
 //[IssueItem current].issue
    CDLottery *lot = [CDLottery findLotteryById:item.lotteryId andChannelId:item.channelid];
    self.alert.msgLbl.text =[NSString stringWithFormat:@"%@本期已结束,您的注单将进入第%@期",item.lotteryName,lot.issue];
    [self.alert dismiss];
        [self.alert show];
}



-(void)higherChaseModelsChange{
    int zhuShu=[self getZhuShu];
    CDBetList *bet=self.betList[0];
    int mode=[bet.mode integerValue];
    MenuItemModel *itemModel =[BetManager menuItemModelForMethodId:[bet.methodId intValue] lottery:[bet.lotteryId intValue]channelId:[bet.channelId intValue]];
    
    
    float  methodPrize=[itemModel.methodPrize floatValue];
    double prizeNum=0 ;
    if(mode==1){
        prizeNum=methodPrize;
        
    }else{
        prizeNum =methodPrize*10/100.0;
    }
    double totalNum =0;
    
    for (int i=1;  i<=_higherChaseModels.count; i++) {
        HigherChaseModel *model=_higherChaseModels[i-1];
        int beiShu=[model.beiShuNumber intValue];
        if (i==1) {//1 为元
            if(mode==1){
                totalNum =beiShu*zhuShu*2;
            }else{
                totalNum =beiShu*zhuShu*0.2;
            }
            
        }else{
            if(mode==1){
                
                
                totalNum =beiShu*zhuShu*2+[[_higherChaseModels[i-2] totalNumber] intValue];
                
            }else{
                
                
                totalNum =beiShu*zhuShu*0.2+[[_higherChaseModels[i-2] totalNumber] doubleValue];
                
            }
            
            
            
        }
        double payOffNum =prizeNum*beiShu -totalNum;
        double payOffRate  =(payOffNum/totalNum)*100;
        model.totalNumber=JXDoubleToString(totalNum);
        model.payOffNumber=JXDoubleToString(payOffNum);
        model.payOffRate = JXFloatToString(payOffRate);
        
    }
    
    [self.tableView reloadData];
    
    
}



-(double)zhuiHaoTotalMoney{
    double totalNum =0;
    //    if (self.sectionModels0.count!=0&&self.sectionModels1.count==0) {
    //        totalNum=[[self.sectionModels0[self.sectionModels0.count-1] totalNumber] doubleValue];
    //    }else if (self.sectionModels0.count!=0&&self.sectionModels1.count!=0){
    //        totalNum =[[self.sectionModels0[self.sectionModels0.count-1] totalNumber] doubleValue]-[[self.sectionModels1[self.sectionModels1.count-1] totalNumber] doubleValue];
    //    }
    int zhuShu =0;
    
    for (HigherChaseModel *model in self.sectionModels0) {
        for (CDBetList *bet in self.betList){
          //  zhuShu += [bet.count intValue];
            
            if (self.mode!=1) {
                totalNum+=[model.beiShuNumber doubleValue]*0.2*[[bet count] intValue];
                
            }else{
                
                totalNum+=[model.beiShuNumber doubleValue]*2*[[bet count] intValue];
            }

        
        
        
        
        
        }

        
        
           }
    return totalNum;
    
}
-(NSInteger)limitTimes{
    
    __block NSInteger limitTimes = NSIntegerMax;
    [self.betList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        CDBetList *bet = (CDBetList*)obj;
        limitTimes = MIN(limitTimes, [bet.limitbet integerValue]);
        *stop=YES;
    }];
    
    limitTimes = MAX(limitTimes, 1);
    
    return (NSInteger)limitTimes;
}

-(NSMutableArray*)sectionModels0{
    if (_sectionModels0 ==nil) {
        _sectionModels0 =[NSMutableArray array];
    }
    return _sectionModels0;
}


-(NSMutableArray*)sectionModels1{
    if (_sectionModels1 ==nil) {
        _sectionModels1 =[NSMutableArray array];
    }
    return  _sectionModels1;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"高级追号";
   // self.isVisible=YES;
    [self retrieveTraceIssues];
    self.betList=[CDBetList betListForAccount:[SharedModel shared].username];
    self.view.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //   UIView *view= [[UIView alloc]init];
    //    view.backgroundColor =[UIColor redColor];
    //    view.frame =CGRectMake(0, 0, 100, 100);
    //    self.tableView.tableHeaderView =view;
    
    // self.tableView.contentInset =UIEdgeInsetsMake(40, 0, 0, 0);
    
    NSString *headerStr=nil;
    HighChaseNumType *highChaseNumType = [NSKeyedUnarchiver unarchiveObjectWithFile: [self filePath] ];
    if (highChaseNumType) {
        headerStr=[self setHighChaseNumValue:highChaseNumType];
    }else{
        [self setDefaultHighChaseNumValue];
        headerStr=[NSString stringWithFormat:@"隔期倍投 追号 追中即停"];
    }
    
    
    
    MSNotificationCenterAddObserver(@selector(requestSimpleInitData), UIApplicationDidBecomeActiveNotification);
    
    
    MSNotificationCenterAddObserver(@selector(bindAction:),kNotificationLastOpenCodeUpdated);

    
    
    _issueLabel.textColor = Color(@"BetFooterBalanceColor");
    _totalLabel.textColor = Color(@"BetFooterCountColor");
    //@"BetFooterCountColor"
    [self setHighChaseTitle:headerStr];
    
    //    NSMutableAttributedString *headerAttStr =[[NSMutableAttributedString alloc] initWithString:headerStr];
    //
    //    [headerAttStr addAttribute:NSForegroundColorAttributeName value: Color(@"OALeftColor") range:NSMakeRange(0, 4)];
    //    [headerAttStr addAttribute:NSForegroundColorAttributeName value: Color(@"OALeftColor") range:NSMakeRange(8,4)];
    //    _headerLabel.attributedText =headerAttStr;
    [self.tableView registerNib:[UINib nibWithNibName:@"HigherNumTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator =NO;
    [self setData];
    //[self setZhuiQiAndTotalNum];
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.isVisible=NO;

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.isVisible =YES;
}

-(void)setZhuiQiAndTotalNum{
    _issueLabel.text =[NSString stringWithFormat:@"追 %lu 期",(unsigned long)[self.sectionModels0 count]];
    double totalMoney = [self zhuiHaoTotalMoney];
    //total_num.setText(String.format(total_num.getText().toString(),totalMoney ));
    _totalLabel.text =[NSString stringWithFormat:@"总计 %.2f 元",totalMoney];
    
}


-(void)setData{
   self.sectionNum=1;
    
    [HUDView showLoadingToView:self.view msg:@"正在计算数据..请稍后" subtitle:nil];

    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
       // NSLog(@"111111111");
        
        for(HigherChaseModel*model in self.higherChaseModels){
            if (model.isNeedSX) {
                
                self.sectionNum =2;
                self.section1++;
                [self.sectionModels1 addObject:model];
            }else{
                self.section0++;
                [self.sectionModels0 addObject:model];
            }
        }
        
        
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            if (self.isNeedAlertShow) {
                
                [self showOrjump];
                self.isNeedAlertShow=NO;
                
            }
            [self setZhuiQiAndTotalNum];
            [self.tableView reloadData];
       
           // NSLog(@"2222222");
            [HUDView dismissCurrent];

        });

    });

    
    
    
    
    
}


-(void)setHighChaseTitle:(NSString*)headerStr{
    NSMutableAttributedString *headerAttStr =[[NSMutableAttributedString alloc] initWithString:headerStr];
    
    [headerAttStr addAttribute:NSForegroundColorAttributeName value: Color(@"OALeftColor") range:NSMakeRange(0, 4)];
    [headerAttStr addAttribute:NSForegroundColorAttributeName value: Color(@"OALeftColor") range:NSMakeRange(8,4)];
    _headerLabel.attributedText =headerAttStr;
}


-(void)setDefaultHighChaseNumValue{
    // 当前期起，起始1倍，追10期，每隔2期，倍数*2；
    self.totalQishu = 10;// 默认追10期
    self.geqiBeiShu = 2;// 隔期倍数*
    self.geqiQiShi = 2;// 隔期期数
    self.qishiBeiShu = 1;// 起始倍数
    self.isStop = true; // 追中即停
    
    
}

-(NSString*)setHighChaseNumValue:(HighChaseNumType *)highChaseNumType{
    self.totalQishu =highChaseNumType.totalIssue;
    self.qishiBeiShu =highChaseNumType.startBeiShu;
    self.isStop =highChaseNumType.isStop;
    self.type=highChaseNumType.type;
    
    NSString *isStopStr=nil;
    if (self.isStop) {
        isStopStr =@"追中即停";
    }else{
        isStopStr =@"追中不停";
    }
    NSString *str =nil;
    if (highChaseNumType.type == HighterChaseNumGeQi) {
        self.geqiBeiShu =highChaseNumType.beiShu;
        self.geqiQiShi =highChaseNumType.issue;
        str=[NSString stringWithFormat:@"隔期倍投 追号 %@",isStopStr];
    }else if(highChaseNumType.type ==HighterChaseNumFenDuan){
        self.qiShuFD =highChaseNumType.issue;
        self.beiShuFD =highChaseNumType.beiShu;
        str=[NSString stringWithFormat:@"分段倍投 追号 %@",isStopStr];
    }else if(highChaseNumType.type ==HighterChaseNumYingLiJe){
        self.qiShuPF =highChaseNumType.issue;
        self.yingLiPF =highChaseNumType.payOffAmount;
        self.yingLi2PF =highChaseNumType.payOffAmount2;
        str=[NSString stringWithFormat:@"盈利金额 追号 %@",isStopStr];
    }else if(highChaseNumType.type ==HighterChaseNumYingLiRate){
        self.qiShuPFR =highChaseNumType.issue;
        self.yingLiPFR =highChaseNumType.payOffRate;
        self.yingLi2PFR =highChaseNumType.payOffRate2;
        str=[NSString stringWithFormat:@"盈利率  追号 %@",isStopStr];
    }
    return str;
}


-(NSString *)filePath
{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDirectory, YES)objectAtIndex:0];
    NSString *path = [docPath stringByAppendingPathComponent:@"highNum"];
    
    //  NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/texts"]; //两种方法都可以
    
    
    return path;
}



/** 取回奖期 */
- (void)retrieveTraceIssues{
   // HUDShowLoading(@"加载奖期...", nil);
    RQAllTraceIssues *r = [[RQAllTraceIssues alloc] init] ;
    
    r.channelId = [IssueItem current].channelid;
    r.lotteryId = [IssueItem current].lotteryId;
    [r startPostWithBlock:^(RQAllTraceIssues* rq_, NSError *error_, id rqSender_) {
        self.traceIssueList = [RQAllTraceIssues allIssues:rq_.lotteryId channelId:rq_.channelId];
     //   HUDHide();
        
    } sender:nil];
}







-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fireTimer:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    
    return self.sectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    NSInteger rows =0;
    if (section==0) {
        rows=self.section0;
    }else if (section==1){
        rows =self.section1;
    }
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    HigherChaseModel *model=nil;
    UIColor *col=nil;
    if (indexPath.section ==0) {
        
        
        model =self.sectionModels0[indexPath.row];
        col=indexPath.row%2==1?[UIColor whiteColor]:[UIColor colorWithRed:217/255.0 green:236/255.0 blue:231/255.0 alpha:0.4];
        
    }else if(indexPath.section==1){
        model =self.sectionModels1[indexPath.row];
        col=indexPath.row%2==1?[UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:0.9]:[UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:0.9];
        
    }
    
    HigherNumTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    [cell setModel:model];
    cell.payOffRateLabel.textColor=indexPath.section==1?[UIColor redColor]:[UIColor darkGrayColor];
    if ([model.payOffRate containsString:@"-"]) {
        cell.payOffRateLabel.textColor=[UIColor redColor];
    }

    cell.issueLabel.textColor=(indexPath.section==0&&indexPath.row==0)?[UIColor blueColor]:[UIColor darkGrayColor];
    cell.bgView.backgroundColor =col;
    
    cell.delegate=self;
    cell.textField.delegate =self;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }else if (section==1){
        return 35;
    }
    return 0;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==1){
        UIView *view=[[UIView alloc]init];
        view.backgroundColor =[UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:0.7];
        UILabel *label =[[UILabel alloc]init];
        label.text =@"被筛选的追号";
        label.textColor=[UIColor blackColor];
        label.alpha=0.6;
        label.font =[UIFont systemFontOfSize:14];
        label.textAlignment=NSTextAlignmentCenter;
        label.frame=CGRectMake(0, 0, self.view.width, 35);
        [view addSubview:label];
        return view;
    }
    return nil;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame1 = textField.frame;
    CGRect frame = [textField.superview convertRect:textField.frame toView:self.view];
    int offset = frame.origin.y + 64 - (self.view.frame.size.height - 230.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textFiled{
    // self.view.frame =CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height);
    
    BeiShuField *filed= (BeiShuField*)textFiled;
    
    [self tableViewCell:filed.cell textFieldDidChange:[textFiled.text intValue]];
    
    
    [self.view endEditing:YES];
    return YES;
}
- (IBAction)nextDetail:(UIButton *)sender {
    NSLog(@"4444");
    HigherChaseSetting*vc=[UIStoryboard storyboardWithName:@"HigherChaseSetting" bundle:nil].instantiateInitialViewController;
    vc.delegate=self;
    //[self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)higherChase:(HigherChaseSetting *)chaseSetting popFinished:(HighChaseNumType *)numType{
//    _higherChaseModels =nil;
//    _sectionModels0=nil;
//    _sectionModels1=nil;
    // _type =numType.type;
    self.isGeQiMax=NO;
    _higherChaseModels =nil;
    _sectionModels0=nil;
    _sectionModels1=nil;
    
    
    self.section0=0;
    self.section1=0;
    [self setHighChaseTitle:[self setHighChaseNumValue:numType]];
    [self setData];
    //[self setZhuiQiAndTotalNum];
    //[self.tableView reloadData];
    
}


- (void)dealloc {
    
    MSNotificationCenterRemoveObserver();
    [[SimpleLotteryTimer shared] stop];
}


- (void)timerLoop:(SimpleLotteryTimer *)timer{
    _timeLabel.text = [[SimpleLotteryTimer shared] remainningTimeStr];
   // NSString *issue=[IssueItem current].issue;
   IssueItem *item= [IssueItem current];
    CDLottery *lot = [CDLottery findLotteryById:item.lotteryId andChannelId:item.channelid];
    NSString *issue =lot.issue;
    NSArray *issues=[issue componentsSeparatedByString:@"-"];
    _currentIssue.text = [NSString stringWithFormat:@"%@期",issues[1]];
    
}

- (void)fireTimer:(NSNotification *)noti{
    [[SimpleLotteryTimer shared] setTimerLoopCallback:@selector(timerLoop:) target:self];
    [[SimpleLotteryTimer shared] launch];
}
-(void)requestSimpleInitData{
    [[SimpleLotteryTimer shared] launch];
    [[SimpleLotteryTimer shared]simpleInit];
}









- (IBAction)confirm:(id)sender{
    [self retrieveTraceIssues];
    if(self.sectionModels0.count==0){
        HUDShowMessage(@"盈利率投注全部被筛选,请从新选择计划..", nil);
        return;
    }
    NSMutableArray *multiples =[NSMutableArray array];
    for(HigherChaseModel *model in self.sectionModels0){
        [multiples addObject:@([model.beiShuNumber intValue])];
    }
    if ([self.betList count] == 0) return;
    
    // if (![self checkTraceIssues]) return;
    
    NSMutableArray *betList = [CDBetList betListForAccount:[SharedModel shared].username];
    
    CGFloat totalAmount = 0.f;
    NSInteger totalBetCount = 0;
    for (CDBetList *bet in betList){
        totalAmount += [bet.amount floatValue];
        totalBetCount += [bet.count intValue];
    }
    //Fee
    
    
    // CDLottery *lot = [CDLottery findLotteryById: [IssueItem current].lotteryId andChannelId: [IssueItem current].channelid];
    //CGFloat fee = 0.f;
    //if (_totalAmount > lot.backOutStartFee.floatValue){
    //   fee = lot.backOutRadio.floatValue * _totalAmount;
    //}
    
    NSString *balance = [SharedModel shared].balance;//
    if ([self zhuiHaoTotalMoney]>[balance floatValue]  ) {
        MSBlockAlertView *alert = [[MSBlockAlertView alloc]initWithTitle:@"余额不足" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
        return;
    }
    
    
    
    NSString *msg = [NSString stringWithFormat:@"%@ 投注金额%.2f",[IssueItem current].lotteryName,[self zhuiHaoTotalMoney]];
    NSString *detail = [NSString stringWithFormat:@"起始期号：第%@期\n追号期数：%ld期\n总金额: %f元",
                        [IssueItem current].issue,
                        (unsigned long)self.sectionModels0.count,
                        [self zhuiHaoTotalMoney]
                        ];
    self.bettingMessage = [NSString stringWithFormat:@"%@ 注单金额%.2f元",[IssueItem current].lotteryName,[self zhuiHaoTotalMoney]];
    //self.bettingDetail = detail;
    WhiteAlert *alert = [WhiteAlert alertWithTitle:@"投注确认"
                                           message:msg
                                            detail:detail
                                           buttons:@"取消",@"确认投注",nil];
    [alert show];
    [alert setCompleteBlock:^(WhiteAlert *a, NSInteger buttonIndex) {
        if (buttonIndex == 1){
            
            RQBet *rq = [[RQBet alloc] init ];
            self.rq = rq;
            rq.channelId = [IssueItem current].channelid;
            rq.lotteryId = [IssueItem current].lotteryId;
            rq.curmid = [IssueItem current].curmid;
            rq.mode = @([BetManager mode]).stringValue;
            rq.select4 = @"1倍";
            rq.multiple = multiples.count;
            rq.multiples=multiples;
            rq.totalNumbers = totalBetCount;
            rq.totalMoney = [self zhuiHaoTotalMoney];   //totalAmount;
            HigherChaseModel *model=self.sectionModels0[0];
            long long code =model.issueCode;
            rq.issueNumber =[NSString stringWithFormat:@"%lld",code];
            rq.beiShu =[model.beiShuNumber intValue];
            rq.betList = betList;
            rq.isHighChaseNum=YES;
            //追号
            if (self.sectionModels0.count > 1) {
                //            long long startIssue = [[IssueItem current].issueNumber longLongValue];
                //            if (startIssue > 0) {
                
                BOOL stopOnWin = self.isStop;
                
                NSMutableArray *traceIssueItems = [NSMutableArray array];
                @try {
                    for (NSUInteger i = 0; i < self.higherChaseModels.count; i++) {
                        if(![self.higherChaseModels[i] isNeedSX]){
                        TraceIssueObject *tio = _traceIssueList[i];
                        TraceIssueItem *item = [[TraceIssueItem alloc] init];
                        item.issue = tio.issueCode; //@(startIssue+i).stringValue; //[self.traceIssueList objectAtIndex:i];
                        item.money =[BetManager mode]==kModeYuan ? 2.0f:0.2f;
                        [traceIssueItems addObject:item];
                        }
                    }
                }
                @catch (NSException *exception) {
                    [HUDView showMessageToView:self.view msg:@"追号奖期错误" subtitle:nil];
                    return;
                }
                
                rq.traceIf = [traceIssueItems count] > 0;
                rq.traceStop = stopOnWin;
                rq.traceIssueItems = traceIssueItems;
            }
            [rq startPostWithDelegate:self];
        }
        
    }];
    
}


- (void)onRQStart:(RQBet *)rq{
    [HUDView showLoadingToView:[UIApplication sharedApplication].keyWindow msg:@"正在投注，请稍候..." subtitle:nil touchToHide:NO];
}

- (void)onRQComplete:(RQBet *)rq error:(NSError *)error{
    [HUDView dismissCurrent];
    [SharedModel shared].traceStartIssue = nil;
    
    if (error || rq.msgContent || rq.fullFail) {
        
        WhiteAlert *alert = [WhiteAlert alertWithTitle:@"投注失败"
                                               message:rq.msgContent
                                                detail:nil
                                               buttons:@"确定",nil];
        [alert show];
    } else if (rq.orderId > 0){    //Success
        
        //  NSInteger   totalCount = _totalCount,
        // multiple = _inputedMultiple,
        //issueCount = _issueCount;
        CGFloat     amount = _totalAmount;
        
        NSString *ln = [IssueItem current].lotteryName;
        [RQPublicHistory saveLastOpenIssue:[IssueItem current]];
        [CDUserInfo user].lastLottery = ln;
        [[CDUserInfo user] save];
        MSNotificationCenterPost(kHomeViewControllerNewInfo);
        //        WhiteAlert *alert = [WhiteAlert alertWithTitle:@"投注成功"
        //                                                   message:_bettingMessage
        //                                                    detail:_bettingDetail
        //                                                   buttons:@"再次投注",@"查看结果",nil];
        //        [alert setCompleteBlock:^(WhiteAlert *a, NSInteger buttonIndex) {
        //            if (buttonIndex == 1){
        //                ResultViewController *vc = [[ResultViewController alloc] init];
        //                [vc setOnViewDidLoad:^(ResultViewController *c) {
        //                    c.lotteryNameLbl.text = self.lottery.name;
        //                    c.issueLbl.text = [NSString stringWithFormat:@"第%@期[追%ld期]",rq.issueNumber,(long)issueCount];
        //                    c.amountLbl.text = [NSString stringWithFormat:@"%ld注x%ld倍x%ld期=%.2f元",
        //                                        (long)totalCount,
        //                                        (long)multiple,
        //                                        (long)issueCount,
        //                                        amount];
        //                    c.detailLbl.text = self.bettingMessage;
        //                }];
        //                [self.navigationController pushViewController:vc animated:YES];
        //                [vc release];
        //            } else {
        //                [self.navigationController popViewControllerAnimated:YES];
        //            }
        //        }];
        //        [alert show];
        {
            ResultViewController *vc = [[ResultViewController alloc] init];
            [vc setOnViewDidLoad:^(ResultViewController *c) {
                c.lotteryNameLbl.text = [IssueItem current].lotteryName;
                c.issueLbl.text = [NSString stringWithFormat:@"第%@期[追%ld期]",[IssueItem current].issue,(long)self.sectionModels0.count];
                c.amountLbl.text = [NSString stringWithFormat:@"%.2f元",[self zhuiHaoTotalMoney]];
                c.detailLbl.text = self.bettingMessage;
            }];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        //[self resetTrace];
       // [CDBetList deleteAll];
        //[self reload];
    }
    else if (rq.overMutipleDTO != nil){
        OverMultipleAlert *alert = [OverMultipleAlert alertWithTitle:@"提示" msg:@"您的注单内容超出倍数限制" details:rq.overMutipleDTO button:@"我知道了"];
        [alert show];
    }
    else if (rq.lists == nil){
        WhiteAlert *alert = [WhiteAlert alertWithTitle:@"提示" message:@"您投注的号码方案受到限制，请重新选择" detail:nil buttons:@"我知道了"];
        [alert show];
    }
}


-(void)tableViewCell:(HigherNumTableViewCell *)cell textFieldDidChange:(int)value{
    NSLog(@"编辑,----%d",value);
    for (HigherChaseModel *model in _higherChaseModels) {
        if (cell.model==model) {
            model.beiShuNumber=[NSString stringWithFormat:@"%d",value];
            break;
        }
    }
    
    [self higherChaseModelsChange];
    [self setZhuiQiAndTotalNum];
    
    
}



-(void)bindAction:(NSNotification*)notifi{
    [self openIssueChangeDiglag];
    IssueItem *item= [IssueItem current];
    CDLottery *lot = [CDLottery findLotteryById:item.lotteryId andChannelId:item.channelid];
    //NSString *issue =lot.issue;
    
    
    [IssueItem current].channelid = [lot.channelid intValue];
    [IssueItem current].lotteryId = [lot.lotteryId intValue];
    [IssueItem current].curmid = [lot.curmid intValue];
    [IssueItem current].lotteryName = lot.name;
    [IssueItem current].issueNumber = lot.issueCode;
    [IssueItem current].issue = lot.issue;

    
    
    
    
    IssueItem *issueItem=[IssueItem current];
    NSString *issue=issueItem.issueNumber;
    
    
    long long issueInt= [issue longLongValue];
    long long issueCode =issueInt;
    issue=[NSString stringWithFormat:@"%lld",issueInt];
    if (issueItem.lotteryId==14&&issueItem.channelid==4) {
        issue=[issue substringFromIndex:issue.length-4];
    }else{
        issue=[issue substringFromIndex:issue.length-3];
        
    }
    issueInt =[issue intValue];

    
    
    
    
    
    //NSArray *issues=[issue componentsSeparatedByString:@"-"];
    
    for(HigherChaseModel *model in self.higherChaseModels){
        
       
        
        model.issueNumber=JXLongToString(issueInt);
        model.issueCode =issueCode;
        issueInt++;
        issueCode++;
    }
    if (self.isVisible) {
        
        [self.tableView reloadData];
    }
    
}


@end
