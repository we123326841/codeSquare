//
//  SheetPicker.h
//
//
//  Created by danal.luo on 7/12/14.
//  Copyright (c) 2014 danal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SheetPicker : UIView <UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIView *_mask;
    NSInteger _curRow;
}
@property (assign, nonatomic) IBOutlet UIPickerView *picker;
@property (assign, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) NSArray *titles;
@property (assign, nonatomic) id userData;
@property (copy, nonatomic) void(^confirmBlock)(SheetPicker *p,NSInteger row);

- (void)showInView:(UIView *)parent;

- (IBAction)confirm;
- (IBAction)cancel;

@end
