//
//  OADeatilView.h
//  Caipiao
//
//  Created by GroupRich on 15/8/5.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RQOpenLinkDetail.h"
#import "RQManualSetting.h"
#import "OADeatilCell.h"

@interface OADeatilView : NSObject
+(UIView*)oadetailviewwithobject:(OpenLinkDetailObject*)object;
+(UIView*)oadetailviewwithobjectForManaul:(UserAwardList*)object;
+(CGFloat)oaheight:(OpenLinkDetailObject*)object;
+(CGFloat)oaheightForManaul:(UserAwardList *)object;
@end

@interface OADeatilViewOne : UIView

@property (retain, nonatomic) IBOutlet UILabel *titleL;
@property (retain, nonatomic) IBOutlet UILabel *rowL;
@property (retain, nonatomic) IBOutlet UILabel *rowV;
@property (retain, nonatomic) IBOutlet UIButton *radioBtn;
@property (assign ,nonatomic) BOOL isSelected;
@property (retain,nonatomic) OpenLinkDetailObject *obj;
@property (retain,nonatomic) UserAwardList*listObj;
@property (retain,nonatomic) NSArray* listObjs;
@property (retain,nonatomic)OADeatilCell *cell;
+(CGFloat)oaheight:(OpenLinkDetailObject*)object;
+(CGFloat)oaheightForManaul:(UserAwardList*)object;
-(void)click:(UIButton*)btn;
@end

@interface OADeatilViewTwo: UIView
@property (retain, nonatomic) IBOutlet UILabel *titleL;
@property (retain, nonatomic) IBOutlet UILabel *row1L;
@property (retain, nonatomic) IBOutlet UILabel *row1V;
@property (retain, nonatomic) IBOutlet UILabel *row2L;
@property (retain, nonatomic) IBOutlet UILabel *row2V;
@property (retain, nonatomic) IBOutlet UIButton *radioBtn;
@property (assign ,nonatomic) BOOL isSelected;
@property (retain,nonatomic) OpenLinkDetailObject *obj;
@property (retain,nonatomic) UserAwardList*listObj;
@property (retain,nonatomic) NSArray* listObjs;
@property (retain,nonatomic)OADeatilCell *cell;
+(CGFloat)oaheight:(OpenLinkDetailObject*)object;
+(CGFloat)oaheightForManaul:(UserAwardList*)object;
-(void)click:(UIButton*)btn;
@end