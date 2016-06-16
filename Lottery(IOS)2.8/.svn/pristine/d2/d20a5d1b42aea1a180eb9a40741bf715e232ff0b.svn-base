//
//  DropDownBox.h
//  Caipiao
//
//  Created by danal on 13-5-23.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DropDownBoxDelegate;

@interface DropDownBox : UIControl
<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UILabel *_titleLbl;
    UIColor *_normalColor;
    UIView *_pickerView;
    NSString *_oldTitle;
//    UIImageView *_rightView;
}
@property (readonly, nonatomic) UILabel *titleLbl;
@property (strong, nonatomic) UIColor *highlightColor;
@property (assign, nonatomic) UIImageView *background;
@property (assign, nonatomic) UIImageView *rightView;
@property (strong, nonatomic) UIPickerView *picker;
@property (strong, nonatomic) NSArray *titleList;
@property (assign, nonatomic) id<DropDownBoxDelegate> delegate;

- (void)prepareFinished;
- (void)adjustToFit;
@end


@interface DropDownBoxBlack : DropDownBox
@end

@protocol DropDownBoxDelegate <NSObject>
@optional
- (BOOL)dropDownBoxShouldShowPicker:(DropDownBox *)box;
- (void)dropDownBoxBeginPrepare:(DropDownBox *)box; //实现此委托必须调用prepareFinished;
- (void)dropDownBox:(DropDownBox *)box didSelectTitle:(NSString *)title;
- (void)dropDownBox:(DropDownBox *)box didSelectAtIndex:(NSInteger)index;
- (void)dropDownBoxWillShow:(DropDownBox *)box;
- (void)dropDownBoxWillHide:(DropDownBox *)box;
- (void)dropDownBoxDidShow:(DropDownBox *)box;
- (void)dropDownBoxDidHide:(DropDownBox *)box;

@end