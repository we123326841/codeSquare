//
//  RQManualSetting.m
//  Caipiao
//
//  Created by 王浩 on 15/10/30.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "RQManualSetting.h"

@implementation RQManualSetting
-(void)prepare
{
    

    self.url=kurlSetInitCreateUrl;
    //    self.url =kUrlPrizeDetail;
    //1玩家 0代理
   // [self setValue:@"0" forField:@"type"];
    [super prepare];
}
- (void)parse:(NSDictionary*)result
{
    
//    self.start = [result stringForKey:@"start"];
//    self.end = [result stringForKey:@"end"];
    NSArray *userAwardLists = [result arrayForKey:@"userAwardList"];
    self.fastsetupreturnmax =[result intForKey:@"fastsetupreturnmax"];
    NSMutableArray *arr = @[@[].mutableCopy,@[].mutableCopy,@[].mutableCopy,@[].mutableCopy,@[].mutableCopy].mutableCopy;
    [userAwardLists enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
        UserAwardList *o = [[UserAwardList alloc]init];
        if ([_type intValue]==1) {
            o.manualType =ManualSettingTypeAgent;
        }else if ([_type intValue]==0){
            o.manualType =ManualSettingTypePlay;
        }
        o.radioButtonType =RadioButtonTypeDefault;
        o.lotterySeriesCode = [obj intForKey:@"lotterySeriesCode"];
        o.lotterySeriesName = [obj stringForKey:@"lotterySeriesName"];
        o.awardGroupId =[obj intForKey:@"awardGroupId"];
        o.awardName = [obj stringForKey:@"awardName"];
        o.defaultDirectRet=@"未设置";
        o.guiLinDirectRet =@"0";
        o.directRet =[obj stringForKey:@"directRet"];
        o.directRet1 =[obj stringForKey:@"directRet"];
        o.directRetReal=o.defaultDirectRet;
        o.defaultThreeoneRet=@"未设置";
        o.guiLinThreeoneRet=@"0";
        o.threeoneRet =[obj stringForKey:@"threeoneRet"];
        o.threeoneRet1 =[obj stringForKey:@"threeoneRet"];
        o.threeoneRetReal =o.defaultThreeoneRet;
        //o.status =[obj intForKey:@"status"];
        o.directLimitRet =[obj intForKey:@"directLimitRet"];
      //  o.groupChain = [obj stringForKey:@"groupChain"];
        o.threeLimitRet =[obj intForKey:@"threeLimitRet"];
        o.lotteryId = [obj intForKey:@"lotteryId"];
       // o.betType =[obj intForKey:@"betType"];
       // o.sysAwardGrouId =[obj intForKey:@"sysAwardGrouId"];
       // o.maxDirectRet =[obj intForKey:@"maxDirectRet"];
      //  o.maxThreeOneRet =[obj intForKey:@"maxThreeOneRet"];
        o.channelId =[obj intForKey:@"channelId"];
        o.lotteryName =[obj stringForKey:@"lotteryName"];
        //o.userpoint = [obj stringForKey:@"userpoint"];
        o.rows = 2;
        o.labels = @[@"直选返点",@"不定位返点"];
        
        if (o.channelId==1)
        {
            if (o.lotteryId==3) {
                o.rows = 1;
                o.labels = @[@"所有返点"];
                
            }
            [arr[3] addObject:o];
            
        }else if (o.lotteryId==9)
        {
            o.labels = @[@"任选型返点",@"趣味性返点"];
            
            [arr[2] addObject:o];
        }else if (o.lotteryId == 16 || o.lotteryId==17||o.lotteryId==18)
        {
            if (o.lotteryId==16||o.lotteryId==18) {
                o.rows = 1;
                o.labels = @[@"所有返点"];
            }else
            {
                o.labels = @[@"混选",@"直选"];
            }
            [arr[4]  addObject:o];
        }else if([o.lotteryName rangeOfString:@"11"].location!=NSNotFound)
        {
            o.rows = 1;
            o.labels = @[@"所有返点"];
            
            [arr[1] addObject:o];
        } else{
            [arr[0] addObject:o];
        }
        
    }];

    NSMutableArray *classArr = @[@[].mutableCopy,@[].mutableCopy,@[].mutableCopy,@[].mutableCopy,@[].mutableCopy].mutableCopy;
    [arr enumerateObjectsUsingBlock:^(NSMutableArray* obj, NSUInteger idx, BOOL *stop)
     {
         NSMutableDictionary *md = @{}.mutableCopy;
         [obj enumerateObjectsUsingBlock:^(UserAwardList* obj, NSUInteger idx, BOOL *stop)
          {
              if (obj.lotteryName) {
                  NSMutableArray *array = md[obj.lotteryName];
                  if (array==nil) {
                      array = [@[].mutableCopy autorelease] ;
                  }
                  [array addObject:obj];
                  md[obj.lotteryName] = array;
              }
              
          }];
         [classArr[idx] addObject:[md allValues]];
         [md release];
     }];
//
    self.objects = classArr ;
   // self.copyObjects= [classArr copy];
//    NSString *strType=nil;
//    if ([_type intValue]==0) {//代理
//    strType =@"agentType";
//    }else if ([_type intValue]==1){
//       strType =@"playType";
//    }

   // NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
     //   NSString *path=[docPath stringByAppendingPathComponent:strType];
        // NSLog(@"path=%@",path);
    
         //3.将自定义的对象保存到文件中
       //  [NSKeyedArchiver archiveRootObject:classArr toFile:path];
    
//
    [arr makeObjectsPerformSelector:@selector(release)];
    [arr release];
    [classArr makeObjectsPerformSelector:@selector(release)];
    [classArr release];

}


@end

@implementation UserAwardList

-(void)dealloc
{

       [super dealloc];

}

@end
