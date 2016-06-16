//
//  GreenBar.m
//  Caipiao
//
//  Created by Cyrus on 13-6-14.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "GreenBar.h"

#pragma mark - GBScrollView

@implementation GBScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    [_customDelegate gbScrollView:self touchLocationX:point.x];
}

@end

#pragma mark - GreenBar

@implementation GreenBar
@synthesize numberOfButton = _numberOfButton;
@synthesize selectedImageView = _selectedImageView;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *background = [[UIImageView alloc] initWithFrame:self.bounds];
        background.image = [UIImage imageNamed:@"greenbar_bg.png"];
        [self addSubview:background];
        [background release];
        
        _scroll = [[GBScrollView alloc] initWithFrame:self.bounds];
        _scroll.customDelegate = self;
        _scroll.scrollEnabled = YES;
        _scroll.showsHorizontalScrollIndicator = NO;
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        [self addSubview:_scroll];
    }
    return self;
}

- (void)dealloc
{
    [_scroll release];
    [super dealloc];
}

- (void)setNumberOfButton:(int)numberOfButton
{
    _numberOfButton = numberOfButton;
    
    float w = 0;
    if (_numberOfButton <5) {
        w = self.frame.size.width/_numberOfButton;
    }else {
        w = self.frame.size.width/3.5;
    }
    
    for (int i = 0; i <= _numberOfButton; ++i) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(w * i, 0, 2, 45)];
        iv.image = [UIImage imageNamed:@"greenbar_spt.png"];
        [_scroll insertSubview:iv atIndex:1];
        [iv release];
    }
    _scroll.contentSize = CGSizeMake(w*_numberOfButton, self.bounds.size.height);
    
    _selectedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, w, self.bounds.size.height)];
    _selectedImageView.image = [UIImage imageNamed:@"button_greenbar_2.png"];
    [_scroll insertSubview:_selectedImageView atIndex:99];
}

//- (UIButton *)greenBarButtonWithTitle:(NSString *)title addTarget:(id)target selector:(SEL)selector isSelected:(BOOL)isSelected byIndex:(int)index
//{
//    float w = self.frame.size.width/_numberOfButton;
//    float x = index * w;
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, w, self.bounds.size.height)];
//    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    button.selected = isSelected;
//    [button setTitleColor:[UIColor rgbColorWithR:255 G:196 B:16 alpha:1] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor rgbColorWithHex:@"#002F1C"] forState:UIControlStateSelected];
//    [button setBackgroundImage:[UIImage imageNamed:@"button_greenbar_2.png"] forState:UIControlStateHighlighted];
//    [button setBackgroundImage:[UIImage imageNamed:@"button_greenbar_2.png"] forState:UIControlStateSelected];
//    [button setTitle:title forState:UIControlStateNormal];
//    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:button];
//    
//    return [button autorelease];
//}

- (void)greenBarLabelWithTitle:(NSString *)text isSelected:(BOOL)isSelected byIndex:(NSInteger)index
{
    float w = 0;
    if (_numberOfButton <5) {
        w = self.frame.size.width/_numberOfButton;
    }else {
        w = self.frame.size.width/3.5;
    }
    float x = index * w;
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, w, self.bounds.size.height)];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont boldSystemFontOfSize:16];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = isSelected ? COLOR_HIGHLIGHTED : COLOR_NORMAL;
    lbl.text = text;
    lbl.tag = 10+index;
    [_scroll addSubview:lbl];
    [lbl release];
    
    //Show the triangle if has data source supported
    if (_dataSource){
        NSArray *titles = [_dataSource greenBar:self subtitlesForItemAtIndex:index];
        if (titles){
            UIImage *triangle = [UIImage imageNamed:@"arrow_down"];
            UIImageView *icon = [[UIImageView alloc] initWithImage:triangle];
            icon.frame = CGRectMake(lbl.bounds.size.width - 30.f, (lbl.bounds.size.height - triangle.size.height)/2, triangle.size.width, triangle.size.height);
            [lbl addSubview:icon];
            [icon release];
        }
    }
}

- (UIView *)getItemViewAtIndex:(NSInteger)index{
    UIView *view = [_scroll viewWithTag:index+10];
    return view;
}

- (void)showPopMenuAtIndex:(NSInteger)itemIndex{
    if (_dataSource){
        if (_popMenu){
            [self removePopMenu];
            
        } else {
            NSArray *titles = [_dataSource greenBar:self subtitlesForItemAtIndex:itemIndex];
            if (titles){
                PopMenu *menu = [[PopMenu alloc] initWithFrame:CGRectMake(0, 0, 100, 100) titles:titles];
                [menu setTarget:self selector:@selector(onPopMenuClick:)];
                [menu showBelowView:self alignFrame:[self getItemViewAtIndex:itemIndex].frame];
                [menu release];
                _popMenu = menu;
                [_dataSource greenBar:self didShowSubmenu:menu];
            }
        }
    }
}

- (void)removePopMenu{
    if (_popMenu)
        [_popMenu removeFromSuperview];
    _popMenu = nil;
}

- (void)closeSubmenu{
    [self removePopMenu];
}

- (void)onPopMenuClick:(PopMenu *)menu{
    if (_dataSource){
        UILabel *lbl = (UILabel *)[self getItemViewAtIndex:self.selectedIndex];
        lbl.text = [menu.titles objectAtIndex:menu.selectedIndex];
        [_dataSource greenBar:self didSelectSubtitleAtIndex:menu.selectedIndex];
        if (_submenuMask) [_submenuMask removeFromSuperview], _submenuMask = nil;
    }
    _popMenu = nil;
}

#pragma mark - GBScrollViewDelegate

- (void)gbScrollView:(id)scroll touchLocationX:(float)x
{
    float w = 0;
    if (_numberOfButton <5) {
        w = self.frame.size.width/_numberOfButton;
    }else {
        w = self.frame.size.width/3.5;
    }
    int index = x/w;
    //Tap twice,Show pop subtitles
    if (index == _selectedIndex){
        [self showPopMenuAtIndex:index];
    }
    else {
        [self removePopMenu];

        for (UIView *view in [_scroll subviews]) {
            if ([view isKindOfClass:[UILabel class]]) {
                UILabel *lbl = (UILabel *)view;
                if (lbl.tag == 10+index) {
                    lbl.textColor = COLOR_HIGHLIGHTED;
                }else {
                    lbl.textColor = COLOR_NORMAL;
                }
            }
        }

        _selectedImageView.frame = CGRectMake(index*w, 0, w, self.bounds.size.height);
        if (_selectedIndex != index) {
            [_delegate greenBar:self didSelectedAtIndex:index];
        }
        _selectedIndex = index;
    }
}

@end
