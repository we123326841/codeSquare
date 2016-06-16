//
//  SiteNoticeCell.m
//  Caipiao
//
//  Created by danal-rich on 3/27/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "SiteNoticeCell.h"

@implementation SiteNoticeCell

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}

- (void)setup
{
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    for (UIView *v in self.contentView.subviews){
        if ([v isKindOfClass:[UILabel class]]){
            UILabel *l = (UILabel *)v;
            l.enabled = NO;
        }
    }
    
    CheckBox *box = [[CheckBox alloc] initWithFrame:CGRectMake(-20, (self.contentView.bounds.size.height- 20)/2, 20, 20)];
    box.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    __block __weak SiteNoticeCell *self_ = self;
    [box setOnStateChanged:^(CheckBox *sender) {
        if (self_.delegate){
            [self_.delegate onSiteNoticeCellCheckBoxValueChanged:self_];
        }
    }];
    [self.contentView addSubview:box];
    self.checkbox = box;
}

- (void)setEditingCell:(BOOL)editing animated:(BOOL)animated{

    if (self.editingCell != editing){
        _editingCell = editing;
        
        [super setEditing:editing animated:animated];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animated ? .1f : .0f];
        CGRect frame;
        for (UIView *view in self.contentView.subviews){
            frame = view.frame;
            if ([view isKindOfClass:[CheckBox class]]){
                frame.origin.x = editing ? 15.f : -20.f;
            } else {
                frame.origin.x += editing ? 25.f : -25.f;
            }
            view.frame = frame;
        }
        [UIView commitAnimations];
    }
}

@end


