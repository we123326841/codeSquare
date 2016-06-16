//
//  WeightMenu.h
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WMButtonTag) {
    kWMTagClear = 0,
    kWMTagEven,
    kWMTagOdd,
    kWMTagAll,
    kWMTagSmall,
    kWMTagBig,
} ;

@protocol WeightMenuDelegate;

@interface WeightMenu : UIView {
    CGRect _origFrame;
    UIView *_optionView;
    NSMutableArray *_optionButtons;
    UIButton *_weightButton;
    UIImageView *_arrow;
    BOOL _opened;
}
@property (assign, nonatomic) id<WeightMenuDelegate> delegate;
@property (copy, nonatomic) NSString *weight;
@property (assign, nonatomic) NSInteger selectedOptionIndex;
@property (nonatomic) BOOL opened;
@property (nonatomic) BOOL enabled;

- (id)initWithFrame:(CGRect)frame weight:(NSString *)weight parentView:(UIView *)parent;
- (void)open:(BOOL)animated;
- (void)close:(BOOL)animated;
- (void)toggle:(id)sender;

@end


@protocol WeightMenuDelegate <NSObject>
- (void)weightMenuDidOptionButtonClick:(NSInteger)buttonTag;
@optional
- (void)weightMenuDidWeightButtonClick:(WeightMenu *)menu;
@end