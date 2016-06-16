//
//  CardCellView.h
//  Caipiao
//
//  Created by danal-rich on 13-12-2.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCellView : PlainCellView
@property (assign, nonatomic) IBOutlet UIImageView  *iconView;
@property (assign, nonatomic) IBOutlet UILabel      *bankLbl;
@property (assign, nonatomic) IBOutlet UILabel      *detailLbl;
@property (assign, nonatomic) IBOutlet UIButton     *deleteButton;

+ (NSString *)secrectCard:(NSString *)cardNumber;
@end
