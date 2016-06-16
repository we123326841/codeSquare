//
//  BetCell+JSKS.h
//  Caipiao
//
//  Created by GroupRich on 15/6/23.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "BetCell.h"

@interface BetCell (JSKS)

@end

@interface JSKSBetView : BetView

@end

@interface JSKSWordsBetView : JSKSBetView
- (id)initWithFrame:(CGRect)frame item:(BetItem *)item;
@end

@interface JSKSImageBetView : JSKSBetView
- (id)initWithFrame:(CGRect)frame item:(BetItem *)item;
@end

@interface JSKSInfoBetView : JSKSBetView
- (id)initWithFrame:(CGRect)frame item:(BetItem *)item;
@end


#import "MethodMenuItem.h"
#import "BetItem.h"
typedef void(^SwitchMethodMenuBlock) (MethodMenuItem*item);
@interface JSKSSwitchView : UIView
@property (nonatomic,copy)NSArray*items;
@property (nonatomic,retain)MethodMenuItem*mmItem;
@property (nonatomic,retain)UIImageView*bgView;
@property (nonatomic,retain)NSArray *betViews;
@property (nonatomic,copy)SwitchMethodMenuBlock switchBlock;
@property (nonatomic,retain)NSMutableArray*weightBtns;
- (id)initWithFrame:(CGRect)frame item:(NSArray*)items withTitles:(NSArray*)titles;

@end