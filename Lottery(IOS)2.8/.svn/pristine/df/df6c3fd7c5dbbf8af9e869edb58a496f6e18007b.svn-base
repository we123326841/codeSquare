//
//  ToolBarPickerView.m
//  Caipiao
//
//  Created by Cyrus on 13-6-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "ToolBarPickerView.h"

@implementation ToolBarPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _selectedIndex = 0;
        _listArray = [[NSMutableArray alloc] init];
        [_listArray addObject:@"全部彩种"];
        NSArray *arr = [CDSSC all];
        for (CDSSC *obj in arr) {
            if ([obj.channelid intValue] == 4) {
                [_listArray addObject:obj];
            }
        }
        
        _backgroundButton = [[UIButton alloc] initWithFrame:self.bounds];
        [self addSubview:self.backgroundButton];
        
        UIImage *image = [UIImage imageNamed:@"green_bar_shadow.png"];
        UIImageView *toolbar = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 44-216, 320, 44)];
        toolbar.image = image;
        toolbar.userInteractionEnabled = YES;
        [self addSubview:toolbar];
        [toolbar release];
        
        self.confirmButton = [UIButton toolButtonWithTitle:@"确定"];
        self.confirmButton.frame = CGRectMake(toolbar.bounds.size.width - self.confirmButton.bounds.size.width - 20,
                                    (toolbar.bounds.size.height - self.confirmButton.bounds.size.height)/2 + 3.f,
                                    self.confirmButton.bounds.size.width, self.confirmButton.bounds.size.height);
//        [self.confirmButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [toolbar addSubview:self.confirmButton];
        
        self.picker = [[[UIPickerView alloc] initWithFrame:CGRectMake(0, toolbar.frame.origin.y + toolbar.frame.size.height, 320, 216)]autorelease]         ;
        self.picker.showsSelectionIndicator = YES;
        self.picker.dataSource = self;
        self.picker.delegate = self;
        [self addSubview:self.picker];
    }
    return self;
}

- (void)dealloc
{
    [_picker release];
    self.listArray=nil ;
//    [self.confirmButton release];
    Block_release(_selectRowBlock);
    [super dealloc];
}

- (void)toolBarDidSelectRowWithBlock:(void (^) (ToolBarPickerView *toolBar, CDSSC *model))block
{
    self.selectRowBlock = block;
}

- (void)dismiss
{
    if ([self.listArray count] != 0) {
        
        if (_selectedIndex ==0) {
            Echo(@"select | %@",@"全部彩种");
            _selectRowBlock(self, nil);
        }else {
            CDSSC *model = [self.listArray objectAtIndex:_selectedIndex];
            Echo(@"select | %@",model.abbreviation);
            _selectRowBlock(self, model);
        }
    }
        
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.frame.size.width, self.frame.size.height);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];    
}

#pragma mark - Picker Data & Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.listArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([self.listArray count] != 0) {
        if (row ==0) {
            return @"全部彩种";
        }else{
            CDSSC *model = [self.listArray objectAtIndex:row];
            return model.name;
        }
    }else {
        return @"";
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectedIndex = row;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
