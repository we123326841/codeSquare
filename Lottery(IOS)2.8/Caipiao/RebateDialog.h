//
//  RebateDialog.h
//  Caipiao
//
//  Created by 王浩 on 15/10/26.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RQManualSetting.h"
@interface RebateDialog : UIView<UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UILabel *zhiXuan;
@property (retain, nonatomic) IBOutlet UILabel *buDingWei;
@property (retain,nonatomic) NSString *zhiXuanStr;
@property (retain,nonatomic) NSString *buDingWeiStr;
@property (retain, nonatomic) IBOutlet UIButton *sure;
@property (retain, nonatomic) IBOutlet UIButton *cancel;
@property (retain, nonatomic) IBOutlet UILabel *LotName;
@property (retain, nonatomic) IBOutlet UILabel *awardGroup;
@property (retain, nonatomic) IBOutlet UITextField *ZhiXuanField;
@property (retain, nonatomic) IBOutlet UITextField *buDingWeiField;
@property (retain,nonatomic) UserAwardList *userAwardList;
@property (nonatomic,assign)BOOL isHaveDian;
+(instancetype)rebate;
@end
