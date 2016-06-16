//
//  LinkDetailViewController.h
//  Caipiao
//  链接管理详情
//  Created by danal-rich on 4/1/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "BaseViewController.h"

@class LinkItem;

@interface LinkDetailViewController : BaseLoadingViewController
{
    IBOutlet UILabel *_accountTypeLbl;
    IBOutlet UILabel *_expireLbl;
    IBOutlet UILabel *_pointSettingLbl;
    IBOutlet UILabel *_introLbl;
}
@property (strong, nonatomic) LinkItem *linkItem;
@end
