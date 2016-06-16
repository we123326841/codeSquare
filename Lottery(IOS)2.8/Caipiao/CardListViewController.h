//
//  CardListViewController.h
//  Caipiao
//
//  Created by danal-rich on 13-11-28.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BaseViewController.h"

@interface CardListViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UILabel        *_tipsLbl;
    IBOutlet UILabel        *_descriptionLbl;
    IBOutlet UIButton       *_bindButton;
    IBOutlet UIView         *_footerView;
    IBOutlet UITableView    *_tableView;
    
    BOOL    _editing;
}

- (IBAction)bindAction:(id)sender;

@end
