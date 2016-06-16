//
//  RQManualSetting.h
//  Caipiao
//
//  Created by 王浩 on 15/10/30.
//  Copyright © 2015年 yz. All rights reserved.
//

#import "RQBase.h"
typedef enum{
    RadioButtonTypeGuiLin,
    RadioButtonTypeDefault,
    RadioButtonTypeAll
}RadioButtonType;


typedef enum{
    ManualSettingTypePlay,
    ManualSettingTypeAgent
}ManualSettingType;
@interface RQManualSetting : RQBase
@property (nonatomic,assign)NSInteger fastsetupreturnmax;
@property (nonatomic,retain)NSNumber *type;
@property (nonatomic,retain)NSArray *objects;
@property (nonatomic,retain)NSString*copyObjects;
@end


@interface UserAwardList : NSObject<NSCoding>

@property (nonatomic,assign)NSInteger lotterySeriesCode;
@property (nonatomic,copy)NSString *lotterySeriesName;
@property (nonatomic,assign)NSInteger awardGroupId;
@property (nonatomic,copy)NSString *awardName;
@property (nonatomic,copy)NSString* directRet;
@property (nonatomic,copy)NSString* directRet1;
@property (nonatomic,copy)NSString* guiLinDirectRet;
@property (nonatomic,copy)NSString* defaultDirectRet;
@property (nonatomic,copy)NSString* directRetReal;
@property (nonatomic,copy)NSString* threeoneRet;
@property (nonatomic,copy)NSString* threeoneRet1;
@property (nonatomic,copy)NSString* guiLinThreeoneRet;
@property (nonatomic,copy)NSString* defaultThreeoneRet;
@property (nonatomic,copy)NSString* threeoneRetReal;
//@property (nonatomic,assign)NSInteger status;
@property (nonatomic,assign)NSInteger directLimitRet;
@property (nonatomic,assign)RadioButtonType radioButtonType;
//@property (nonatomic,copy)NSString *groupChain;
@property (nonatomic,assign)NSInteger threeLimitRet;
@property (nonatomic,assign)NSInteger lotteryId;
//@property (nonatomic,assign)NSInteger betType;
//@property (nonatomic,assign)NSInteger sysAwardGrouId;
//@property (nonatomic,assign)NSInteger maxDirectRet;
//@property (nonatomic,assign)NSInteger maxThreeOneRet;
@property (nonatomic,assign)NSInteger channelId;
@property (nonatomic,copy)NSString *lotteryName;
@property (nonatomic,assign)NSInteger rows;
@property (nonatomic,copy)NSArray *labels;
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,assign)ManualSettingType manualType;
@end
