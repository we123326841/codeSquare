//
//  RQPlaySetting.m
//  Caipiao
//
//  Created by 王浩 on 15/10/26.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "RQPlaySetting.h"

@implementation RQPlaySetting
-(void)prepare
{
    //    self.url=kUrlOpenLinkDetail;
    self.url =kUrlPrizeDetail;
    //[self setValue:_linkid forField:@"id"];
    [super prepare];
}
- (void)parse:(NSDictionary*)result
{
    self.start = [result stringForKey:@"start"];
    self.end = [result stringForKey:@"end"];
    NSArray *keys = [result arrayForKey:@"key"];
    
    NSMutableArray *arr = @[@[].mutableCopy,@[].mutableCopy,@[].mutableCopy,@[].mutableCopy,@[].mutableCopy].mutableCopy;
    [keys enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
        PlaySettingObject *o = [[PlaySettingObject alloc]init];
        o.channelid = [obj intForKey:@"channelid"];
        o.cnname = [obj stringForKey:@"cnname"];
        o.indefinitePoint = [obj stringForKey:@"indefinitePoint"];
        o.lot_name = [obj stringForKey:@"lot_name"];
        o.lotteryid = [obj intForKey:@"lotteryid"];
        o.userpoint = [obj stringForKey:@"userpoint"];
        o.rows = 2;
        o.labels = @[@"直选返点",@"不定位返点"];
        
        if (o.channelid==1)
        {
            if (o.lotteryid==3) {
                o.rows = 1;
                o.labels = @[@"所有返点"];
                
            }
            [arr[3] addObject:o];
            
        }else if (o.lotteryid==9)
        {
            o.labels = @[@"任选型返点",@"趣味性返点"];
            
            [arr[2] addObject:o];
        }else if (o.lotteryid == 16 || o.lotteryid==17||o.lotteryid==18)
        {
            if (o.lotteryid==16||o.lotteryid==18) {
                o.rows = 1;
                o.labels = @[@"所有返点"];
            }else
            {
                o.labels = @[@"混选",@"直选"];
            }
            [arr[4]  addObject:o];
        }else if([o.lot_name rangeOfString:@"11"].location!=NSNotFound)
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
         [obj enumerateObjectsUsingBlock:^(PlaySettingObject* obj, NSUInteger idx, BOOL *stop)
          {
              if (obj.lot_name) {
                  NSMutableArray *array = md[obj.lot_name];
                  if (array==nil) {
                      array = [@[].mutableCopy autorelease] ;
                  }
                  [array addObject:obj];
                  md[obj.lot_name] = array;
              }
              
          }];
         [classArr[idx] addObject:[md allValues]];
         [md release];
     }];
    
    self.objects = classArr ;
    
    [arr makeObjectsPerformSelector:@selector(release)];
    [arr release];
    [classArr makeObjectsPerformSelector:@selector(release)];
    [classArr release];
}


@end

@implementation PlaySettingObject

-(void)dealloc
{
    [_cnname release];
    [_indefinitePoint release];
    [_lot_name release];
    [_userpoint release];
    [super dealloc];
}
@end
