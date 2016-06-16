//
//  MethodView.m
//  Caipiao
//
//  Created by danal-rich on 8/4/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "MethodView.h"
#import "MethodMenuItem.h"

@interface MethodView () <MethodItemClickDelegate>
@end

@implementation MethodView

- (void)dealloc{
    self.recentItemNames = nil;
    self.methodItems = nil;
    [super dealloc];
}

- (void)awakeFromNib{
    self.clipsToBounds = YES;
    _scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self insertSubview:_scroll atIndex:0];
    [_scroll release];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self awakeFromNib];
    }
    return self;
}

- (void)updateDisplay{
    for (UIView *v in _scroll.subviews){
        if (v.tag >= 100) [v removeFromSuperview];
    }
    
    CGFloat marY = 4.f, marX = 4.f, h = 24.f, w = 100.f , leftX=marX;
    if ( _recentItemNames.count*(marX+w) <= self.bounds.size.width) {
        marX = (self.bounds.size.width - _recentItemNames.count*w)/(_recentItemNames.count+1);
    }
    
    for (NSInteger i = 0; i < _recentItemNames.count; i++) {
        NSString *methodName_ = _recentItemNames[i];
        w = [methodName_ sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:CGSizeMake(MAXFLOAT, h)].width+15;
        UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.tag = 100+i;
        butt.frame = CGRectMake(leftX, marY, w, h);
        butt.layer.cornerRadius = butt.frame.size.height/2;
        butt.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [butt setTitle:methodName_ forState:UIControlStateNormal];
        [butt setTitleColor:Color(@"BetMethodTextColor") forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scroll addSubview:butt];
        leftX+=(w+marX);
        _scroll.contentSize = CGSizeMake((leftX+w), self.bounds.size.height);
        if ([methodName_ isEqualToString:_selectedMethodName]){
            [self selectItemAtIndex:i selected:YES];
            _lastSelected = butt;
        } else {
            [self selectItemAtIndex:i selected:NO];
        }
    }
    if (!_selectedMethodName){
        [self selectItemAtIndex:0 selected:YES];
        _lastSelected = [self viewWithTag:100+0];
    } else {
        
    }
}

- (UIButton *)selectItemAtIndex:(NSInteger)index selected:(BOOL)selected{
    if (index < _methodItems.count) {
        UIButton *butt = (id)[self viewWithTag:index+100];
        butt.backgroundColor =  selected ? Color(@"BetMethodMaskColor") : [UIColor whiteColor];
        [butt setTitleColor:selected ? [UIColor whiteColor] : Color(@"BetMethodTextColor") forState:UIControlStateNormal];

        return butt;
    }
    return nil;
}

- (void)buttonClick:(UIButton *)sender{
    [self selectItemAtIndex:_lastSelected.tag-100 selected:NO];
    NSInteger index = sender.tag - 100;
    NSString *methodName_ = _recentItemNames[index];
    [self selectItemAtIndex:index selected:YES];

    _curSelected = sender;
    if (_delegate) [_delegate onMethodItemClick:methodName_ view:self];
}

- (void)commit{
    _lastSelected = _curSelected;
}

- (void)rollback{
    [self selectItemAtIndex:_curSelected.tag-100 selected:NO];
    [self selectItemAtIndex:_lastSelected.tag-100 selected:YES];
    _curSelected = nil;
}
- (void)showItemHighlightAtIndex:(NSInteger)index
{
    [self selectItemAtIndex:_lastSelected.tag-100 selected:NO];
    [self selectItemAtIndex:index selected:YES];
    _curSelected = (id)[_scroll viewWithTag:index+100];
    CGRect frame = [UIView convertViewFrame:_curSelected toSuperview:_scroll];
//    NSLog(@"%@",NSStringFromCGRect(frame));
    if(frame.origin.x>_scroll.bounds.size.width)
    _scroll.contentOffset = CGPointMake(frame.origin.x-_scroll.bounds.size.width+frame.size.width+10, 0);
    else
        _scroll.contentOffset = CGPointZero;
}
- (BOOL)togglePanel{

    if (!_panelView){
        MethodPanelView *pv = [[MethodPanelView alloc] initWithFrame:self.bounds];
        pv.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, pv.frame.size.width, 0);
        pv.delegate = self;
        pv.methodItems = _methodItems;
        pv.selectedMethodName = self.selectedMethodName;
        [self.superview addSubview:pv];
        [pv updateDisplay];
        _panelView = pv;
        [pv release];
    }
    _panelView.opened = !_panelView.opened;
    return _panelView.opened;
}

- (void)onMethodItemClick:(NSString *)methodName view:(MethodView *)methodView{
    if (_delegate) [_delegate onMethodItemClick:methodName view:methodView];
}

@end


@implementation MethodPanelView

- (void)dealloc{
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)updateDisplay{
    for (UIView *v in self.subviews){
        if (v.tag >= 100) [v removeFromSuperview];
    }
    /*
    CGFloat marY = 4.f, marX = 4.f, h = 24.f, w = 102.f;
    CGFloat x = marX, y = marY;
    for (NSInteger i = 0; i < _methodItems.count; i++) {
        MethodMenuItem *item = _methodItems[i];
        UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
        butt.tag = 100+i;
        
        if (i > 0 && i%3 == 0) x = marX, y += h+ marY;
        butt.frame = CGRectMake(x,y,w,h);
        x += w + marX;
        butt.layer.cornerRadius = butt.frame.size.height/2;
        butt.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [butt setTitle:item.methodName forState:UIControlStateNormal];
        [butt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scroll insertSubview:butt atIndex:0];

        [self selectItemAtIndex:i selected:i == 0];

    }
    _scroll.contentSize = CGSizeMake(self.bounds.size.width, ceilf(_methodItems.count/3.f)*(marY+h)+marY);
     */
    CGFloat marY = 6.f, marX = 5.f, h = 26.f, w = 100.f, x = marX, y = marY;
    for (MethodMenuItemCategory *cat in _methodItems){
        UILabel *cateLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.f, y, 86.f, h)];
        cateLbl.text = cat.categoryName;
        cateLbl.textColor = Color(@"BetMethodTextColor");
        cateLbl.textAlignment = NSTextAlignmentCenter;
        cateLbl.font = [UIFont systemFontOfSize:13.f];
        [_scroll addSubview:cateLbl];
        [cateLbl release];

        x = cateLbl.frame.origin.x + cateLbl.frame.size.width;
        CGSize size;
        for (NSInteger i = 0; i < [cat.methodMenuItems count]; i++) {
            MethodMenuItem *item = cat.methodMenuItems[i];
            MethodButton *butt = [MethodButton buttonWithType:UIButtonTypeCustom];
            butt.tag = 100+i;
            butt.methodMenuItem = item;
            butt.titleLabel.font = [UIFont systemFontOfSize:13.f];
            butt.backgroundColor = self.backgroundColor;
            butt.layer.cornerRadius = 2.f;
            [butt setTitle:item.simpleName forState:UIControlStateNormal];
            [butt setTitleColor:Color(@"BetMethodTextColor") forState:UIControlStateNormal];
            [butt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_scroll insertSubview:butt atIndex:0];

            size = [item.simpleName sizeWithFont:butt.titleLabel.font];
            w = size.width + 10.f;
            if (x + w >= self.bounds.size.width){
                x = cateLbl.frame.origin.x + cateLbl.frame.size.width;
                y += h + marY;
            }
            butt.frame = CGRectMake(x,y,w,h);
            x += w + 15.f;      //the next start x
            
//            [self selectItemAtIndex:i selected:i == 0];
            if ([item.methodName isEqualToString:self.selectedMethodName]){
                [self selectButtonItem:butt selected:YES];
                _lastSelected = butt;
            } else {
                [self selectButtonItem:butt selected:NO];
            }
        }
        x = 0.f;
        y += h + marY;
        CALayer *line = [CALayer layer];
        line.frame = CGRectMake(0, y-marY/2.f, self.bounds.size.width, 0.5f);
        line.backgroundColor = [UIColor lightGrayColor].CGColor;
        [_scroll.layer addSublayer:line];
    }
     _scroll.contentSize = CGSizeMake(self.bounds.size.width, y+marY);
    _actualHeight = MIN(_scroll.contentSize.height, 200.f);
}

- (void)selectButtonItem:(UIView *)button selected:(BOOL)selected{
    if (selected){
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
        button.layer.borderWidth = 1.f;
    } else {
        button.layer.borderWidth = 0.f;
    }
}
                          
- (void)buttonClick:(MethodButton *)sender{
    _curSelected = sender;
    [self selectButtonItem:_lastSelected selected:NO];
    [self selectButtonItem:_curSelected selected:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CGRect rect = self.frame;
        rect.size.height = 0;
        self.frame = rect;
        self.opened = NO;
        
        if (self.delegate) [self.delegate onMethodItemClick:sender.methodMenuItem.methodName view:self];
    });
}

- (void)commit{
    _lastSelected = _curSelected;
}

- (void)rollback{
    [self selectButtonItem:_lastSelected selected:YES];
    [self selectButtonItem:_curSelected selected:NO];
    _curSelected = nil;
}

- (void)setOpened:(BOOL)opened{
    _opened = opened;
    
    CGRect rect = self.frame;
    rect.size.height = _opened ? ([self actualHeight]) : 0.f;
    [UIView animateWithDuration:.25f animations:^{
        self.frame = rect;
    } completion:^(BOOL finished) {
        if (self.maskView){
            [self.maskView removeFromSuperview];
            self.maskView = nil;
        } else {
            self.maskView = [[UIControl alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y,
                                                                           self.superview.frame.size.width, self.superview.frame.size.height)];
            self.maskView.userInteractionEnabled = YES;
            self.maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3f];
            [self.superview insertSubview:self.maskView belowSubview:self];
            [self.maskView release];
            [(UIControl *)self.maskView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        }
    }];
}

- (void)close{
    self.opened = NO;
}

//- (UIButton *)selectItemAtIndex:(NSInteger)index selected:(BOOL)selected{
//    UIButton *butt = [super selectItemAtIndex:index selected:selected];
//    [butt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    butt.backgroundColor = self.backgroundColor;
//    butt.layer.cornerRadius = 2.f;
//    if (selected){
//        butt.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        butt.layer.borderWidth = 1.f;
//    } else {
//        butt.layer.borderWidth = 0.f;
//    }
//    return butt;
//}

@end


@implementation MethodButton

@end