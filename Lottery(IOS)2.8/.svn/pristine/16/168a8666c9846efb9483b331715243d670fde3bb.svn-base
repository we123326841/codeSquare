//
//  MSTabBarController.m
//  VGirl
//
//  Created by danal-rich on 14-2-20.
//  Copyright (c) 2014年 danal. All rights reserved.
//

#import "MSTabBarController.h"

static CGFloat _tabBarHeight = 49.f;


#pragma mark - TabBarItem
@implementation MSTabBarItem

- (void)dealloc{
#if !__has_feature(objc_arc)
    [_image release];
    [_imageOn release];
    [_title release];
    [super dealloc];
#endif
}

+ (id)itemWithTitle:(NSString *)title image:(UIImage *)image imageOn:(UIImage *)imageOn{
    MSTabBarItem *item = [[self alloc] initWithTitle:title image:image imageOn:imageOn];
    return [item autorelease];
}

- (id)initWithTitle:(NSString *)title image:(UIImage *)image imageOn:(UIImage *)imageOn {
    self = [super initWithFrame:CGRectMake(0, 0, 40, 40)];
    if (self) {
        self.userInteractionEnabled = NO;
        
        //Title
        if (title) {
            _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 20, 40, 20)];
            _titleLbl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
            _titleLbl.text = title;
            _titleLbl.font = [UIFont boldSystemFontOfSize:11.f];
            _titleLbl.textAlignment = NSTextAlignmentCenter;
            _titleLbl.backgroundColor = [UIColor clearColor];
            [self addSubview:_titleLbl];
        }
        
        //Icon
        self.image = image;
        self.imageOn = imageOn;
        if (!self.imageOn) self.imageOn = self.image;
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.frame = CGRectMake(0, 5, 40, self.bounds.size.height - _titleLbl.bounds.size.height);
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _imageView.image = image;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self insertSubview:_imageView atIndex:0];
        
        //Badge
        _badgeView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 20, (self.bounds.size.height - 20)*0 + 10, 20, 20)];
        _badgeView.image = [UIImage imageNamed:@"cart_badge"];
        _badgeView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:_badgeView];
        
        UILabel *badgeLbl = [[UILabel alloc] initWithFrame:_badgeView.bounds];
        badgeLbl.textAlignment = NSTextAlignmentCenter;
        badgeLbl.backgroundColor = [UIColor clearColor];
        badgeLbl.font = [UIFont systemFontOfSize:10.f];
        badgeLbl.textColor = [UIColor whiteColor];
        badgeLbl.text = @"0";
        badgeLbl.tag = 0x1900;
        [_badgeView addSubview:badgeLbl];
        _badgeView.hidden = YES;
        
#if !__has_feature(objc_arc)
        [badgeLbl release];
        [_titleLbl release];
        [_badgeView release];
        [_imageView release];
#endif
        
    }
    return self;
}

- (void)setBadgeNumber:(NSInteger)badgeNumber{
    _badgeNumber = badgeNumber;
    UILabel *lbl = (UILabel *)[_badgeView viewWithTag:0x1900];
    lbl.text = [NSString stringWithFormat:@"%ld",(long)badgeNumber];
    _badgeView.hidden = badgeNumber == 0;
}

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    _imageView.image = selected ? self.imageOn : self.image;
    _titleLbl.textColor = selected ? [UIColor whiteColor] : [[UIColor whiteColor] colorWithAlphaComponent:.3f];
    [UIView animateWithDuration:.0f animations:^{
//        self.backgroundColor = selected ? [UIColor colorWithRed:0x96*1.f/255 green:0xc5*1.f/255 blue:0x64*1.f/255 alpha:1.f] :[UIColor clearColor];
        self.backgroundColor = !selected ? [UIColor clearColor] : [UIColor colorWithPatternImage:ResImage(@"tab-selected")];
    }];
}

@end

#pragma mark - TabBar
@implementation MSTabBar

- (void)dealloc{
#if !__has_feature(objc_arc)
    [_items release];
    [super dealloc];
#endif
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect rect = self.bounds;
        UIImageView *bg = [[UIImageView alloc] initWithFrame:rect];
        bg.image = ResImage(@"tabbar");
        bg.backgroundColor = [UIColor blackColor];
        [self insertSubview:bg atIndex:0];
        _background = bg;
#if !__has_feature(objc_arc)
        [bg release];
#endif
        
//        self.layer.shadowColor = [UIColor blackColor].CGColor;
//        self.layer.shadowOpacity = 0.4f;
//        self.layer.shadowOffset = CGSizeMake(0, -1);
//        self.layer.shadowRadius = 1.f;
//        CGMutablePathRef path = CGPathCreateMutable();
//        CGPathAddRect(path, NULL, CGRectMake(0, -1, frame.size.width, 2));
//        self.layer.shadowPath = path;
//        CGPathRelease(path);
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items{
    self = [self initWithFrame:frame];
    if (self) {
        self.items = items;
        CGFloat w = frame.size.width/items.count, x = 0;
        for (NSInteger i = 0; i < items.count; i++) {
            MSTabBarItem *item = [items objectAtIndex:i];
            item.frame = CGRectMake(x, 0, w, frame.size.height);
            item.tag = i+1;
            [self addSubview:item];
            item.selected = i == 0;
            x += w;
        }
        _selectedIndex = 0;
    }
    return self;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    for (NSInteger i = 0; i < self.items.count; i++) {
        MSTabBarItem *item = [self.items objectAtIndex:i];
        item.selected = i == selectedIndex;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *t = [touches anyObject];
    CGPoint pos = [t locationInView:self];
    
    NSInteger index = 0;
    for (NSInteger i = 0; i < self.items.count; i++) {
        MSTabBarItem *item = [self.items objectAtIndex:i];
        if (CGRectContainsPoint(item.frame, pos)) {
            item.selected = YES;
            index = i;
            if (item.specialItem) return;
        } else {
            item.selected = NO;
        }
    }
    
    if (_selectedIndex != index) {
        _selectedIndex = index;
        //Callback
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end

#pragma mark - TabBarController

@interface MSTabBarController()
@end

@implementation MSTabBarController

- (void)dealloc{
#if !__has_feature(objc_arc)
    [_controllers release];
    [super dealloc];
#endif
}

- (void)setControllers:(NSArray *)controllers tabBarItems:(NSArray *)items{
#if !__has_feature(objc_arc)
    [_controllers release];
    _controllers = [controllers retain];
#else
    _controllers = controllers;
#endif
    
    //Remove old bar if exists
    if (_tab){
        [_tab removeFromSuperview];
        _tab = nil;
    }
    CGRect rect = self.tabBar.frame;
    rect.origin.y += rect.size.height - _tabBarHeight;
    rect.size.height = _tabBarHeight;
    _tab = [[MSTabBar alloc] initWithFrame:rect items:items];
    _tab.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _tab.backgroundColor = [UIColor blackColor];
    [_tab addTarget:self action:@selector(onTabBarClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_tab];
    
#if !__has_feature(objc_arc)
    [_tab release];
#endif
    
    [self setTabBarHidden:YES];
    [self setTabSelectedIndex:0];
    
}

- (void)setTabSelectedIndex:(NSInteger)index{
    NSAssert([self.controllers count] > 0, @"index %ld is beyound bounds",(long)index);
    self.tab.selectedIndex = index;
    UIViewController *controller = [self.controllers objectAtIndex:index];
    self.viewControllers = [NSArray arrayWithObject:controller];
    
    self.navigationItem.title = controller.title;
    self.navigationItem.titleView = controller.navigationItem.titleView;
    self.navigationItem.leftBarButtonItem = controller.navigationItem.leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = controller.navigationItem.rightBarButtonItem;
}

- (void)setTabBarHidden:(BOOL)hidden{
    self.tabBar.hidden = YES;
    
    UIView *wrapView = [[self.view subviews] objectAtIndex:0];
    CGRect frame = wrapView.frame;
    if (hidden){
        frame.size.height = self.view.bounds.size.height;
    } else {
        frame.size.height = self.view.bounds.size.height - _tabBarHeight;
    }
    wrapView.frame = frame;
    
}


- (IBAction)onTabBarClick:(MSTabBar *)sender{
    [self setTabSelectedIndex:sender.selectedIndex];
}

+ (void)setTabBarHeight:(CGFloat)height{
    _tabBarHeight = height;
}

+ (CGFloat)tabBarHeight{
    return _tabBarHeight;
}

@end
