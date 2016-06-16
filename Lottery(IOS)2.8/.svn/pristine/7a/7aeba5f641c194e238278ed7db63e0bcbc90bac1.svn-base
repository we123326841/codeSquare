//
//  SiteNoticeCell.h
//  Caipiao
//
//  Created by danal-rich on 3/27/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "CheckBox.h"

@protocol SiteNoticeCellDelegate;

@interface SiteNoticeCell : BaseCell
@property (assign, nonatomic) id <SiteNoticeCellDelegate> delegate;
@property (assign, nonatomic) IBOutlet UILabel *typeLbl;
@property (assign, nonatomic) IBOutlet UILabel *titleLbl;
@property (assign, nonatomic) IBOutlet UILabel *datetimeLbl;
@property (assign, nonatomic) IBOutlet UIImageView *iconNew;
@property (assign, nonatomic) IBOutlet CheckBox *checkbox;
@property (readonly, nonatomic) BOOL editingCell;

- (void)setEditingCell:(BOOL)editingCell animated:(BOOL)animated;
@end


@protocol  SiteNoticeCellDelegate <NSObject>
- (void)onSiteNoticeCellCheckBoxValueChanged:(SiteNoticeCell *)cell;
@end