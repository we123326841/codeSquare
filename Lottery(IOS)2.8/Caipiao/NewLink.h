//
//  NewLink.h
//  Caipiao
//
//  Created by 王浩 on 15/10/20.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RQManualSetting.h"
typedef enum{
NewLinkSettingTypeManual,
    NewLinkSettingTypeFast

}NewLinkSettingType;
@interface NewLink : BaseViewController
@property (nonatomic,strong)RQManualSetting*rq;

@property(nonatomic,strong)NSMutableArray *lists;
@property (nonatomic,assign)NewLinkSettingType type;
@end
