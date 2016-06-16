//
//  ColorCell.h
//  Caipiao
//
//  Created by danal on 13-8-27.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorCellStateDelegate;

@interface ColorCell : UITableViewCell
@property (assign, nonatomic) id<ColorCellStateDelegate> stateDelegate;
@property (strong, nonatomic) UIColor *tintColor;
@property (assign, nonatomic) float tintAlpha;
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

+ (ColorCell *)blackColorCell:(NSString *)identifier;
+ (ColorCell *)greenColorCell:(NSString *)identifier;

@end

@protocol ColorCellStateDelegate <NSObject>
@optional
- (void)onCellSelected:(BOOL)selected animated:(BOOL)animated cell:(ColorCell *)cell;
- (void)onCellHighlighted:(BOOL)highlighted animated:(BOOL)animated cell:(ColorCell *)cell;
@end