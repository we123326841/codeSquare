//
//  SelectSecurityIsussesVC.h
//  Caipiao
//
//  Created by GroupRich on 14-11-12.
//  Copyright (c) 2014年 yz. All rights reserved.
//

#import "BaseViewController.h"

typedef enum {
    SelectTypeDefault,
    SelectTypeAuthentication ,
    
}SelectType;

typedef void (^CompleteBlock)(QuestEntity * issue);

@interface SelectSecurityIsussesVC : BaseViewController
PCOPY CompleteBlock completeBlock;
@property (retain, nonatomic) IBOutlet UITableView *table;
PSTRONG NSMutableArray *issues;
PSTRONG NSIndexPath *lastIndexPath;
PASSIGN SelectType type;
@end
