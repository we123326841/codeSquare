//
//  MenuCell.h
//  Caipiao
//
//  Created by danal on 13-1-4.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconLabelView.h"

@interface MenuCell : UITableViewCell {
    UIImageView *_indicatorView;
    UIView *_selectedMask;
    UILabel *_badgeLbl;
}
@property (assign, nonatomic) IconLabelView *iconLblView;
@property (assign, nonatomic) UIImageView *indicatorView;
@property (assign, nonatomic) NSInteger badgeNumber;
@property (nonatomic) BOOL showIndicator;
@end
