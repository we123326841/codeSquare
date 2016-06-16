//
//  HistoryView.h
//  Caipiao
//
//  Created by danal-rich on 8/8/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryView : UIView <UITableViewDataSource,UITableViewDelegate>
{
    IBOutletCollection(UILabel) NSArray *_lbls;
    IBOutlet UIImageView *_lineV, *_lineH;
}
@property (nonatomic, assign) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *issueItems;
@end
