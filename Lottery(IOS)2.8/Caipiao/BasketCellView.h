//
//  BasketCellView.h
//  Caipiao
//
//  Created by danal-rich on 8/4/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasketCellView : UIView
@property (nonatomic, assign) IBOutlet UILabel *textLabel;
@property (nonatomic, assign) IBOutlet UILabel *methodLabel;
@property (nonatomic, assign) IBOutlet UILabel *detailLabel;
@property (nonatomic, assign) IBOutlet UIButton *deleteButton;

- (void)update;
@end
