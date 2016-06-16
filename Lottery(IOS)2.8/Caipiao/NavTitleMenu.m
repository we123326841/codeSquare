//
//  NavTitleMenu.m
//  Caipiao
//
//  Created by danal on 13-1-7.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "NavTitleMenu.h"
#import "View+Factory.h"

@interface NavTitleMenu ()
@property (assign, nonatomic) UIScrollView *container;
@end

@implementation NavTitleMenu
@synthesize delegate = _delegate;
@synthesize titles = _titles;
@synthesize opened = _opened;
@synthesize lastIndex = _lastIndex;
@synthesize selectedIndex = _selectedIndex;

static inline CGRect rectForTitles(NSArray *titles, float width){
    CGRect rect = CGRectZero;
    rect = CGRectMake(0, 0, width, 100);
    return rect;
}

- (void)dealloc{
    [_titles release]; _titles = nil;
    [_mask release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
//    frame = rectForTitles(titles,frame.size.width);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titles = titles;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor blackColor];
        _selectedIndex  = _lastIndex = -1;
        
//        UIImage *bgImage = [UIImage imageNamed:@"game_switch_bg_long.jpg"];
//        _bg = [[UIImageView alloc] initWithImage:bgImage];
//        [self addSubview:_bg];
        
        _container = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_container];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_container addGestureRecognizer:tap];
        [tap release];
        [_container release];
        
        int maxColumn = [titles count] > 10 ? 3 : 2;
        float mar = 0.f, x = mar, y = mar + 8.f, expand = 10.f;
        float w = (frame.size.width - (maxColumn+1)*mar)/maxColumn, h = 35.f;
        UIFont *fnt = [UIFont boldSystemFontOfSize:maxColumn == 3 ? 12.f : 14.f];
        
        for (int i = 0; i < [titles count]; i++) {
            NSString *text = [self.titles objectAtIndex:i];
            CGSize size = [text sizeWithFont:fnt];
            size.width += expand;
            //最小宽度计算
            float w1 = size.width < w ? w : (size.width);
            //计算下一个位置是否会超出边界,出界则换到下一行
//            float x1 = x + w1 + mar;
//            if (x1 > frame.size.width) {
//                x = mar;
//                y = y + h + mar;
//            }
            if (i > 0 && i %maxColumn==0) {
                x = mar;
                y = y + h + mar;
            }
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w1, h-3)];
            lbl.tag = i;
            lbl.font = fnt;
            lbl.textColor= [UIColor yellowColor];
            lbl.textAlignment = UITextAlignmentCenter;
            lbl.backgroundColor = [UIColor clearColor];
            lbl.text = text;
            [_container addSubview:lbl];
            [lbl release];
            x += (w1 + mar);
        }
        frame.size.height = y + h + 2*mar;
        self.frame = frame;
        _container.frame = self.bounds;
        _container.contentSize = _container.frame.size;
        _origFrame = frame;
        
        TiledImageView *tiv = [[TiledImageView alloc] initWithFrame:CGRectMake(0, 0, _container.contentSize.width, _container.contentSize.height)];
        tiv.edge = UIEdgeInsetsMake(8, 0, 0, 0);
        tiv.image = [UIImage imageNamed:@"game_switch_bg_cell.jpg"];
        [_container insertSubview:tiv atIndex:0];
        [tiv release];
        
        _mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 1000.f)];
        _mask.backgroundColor = [UIColor blackColor];
        _mask.alpha = 0.3f;
        UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskTapped:)];
        [_mask addGestureRecognizer:g];
        [g release];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code

    [kYellowColor set];
    float mar = 10.f,x = mar, y = mar;
    float w = rect.size.width/3, h = 20.f;
    UIFont *fnt = [UIFont boldSystemFontOfSize:14.f];
    for (int i = 0; i < [self.titles count]; i++) {
        NSString *text = [self.titles objectAtIndex:i];
        CGSize size = [text sizeWithFont:fnt];
        //计算是否会超出边界
        float x1 = x + size.width + mar;
        //计算是否是换到新一行
        if (x1 >= rect.size.width) {
            x = mar;
            y = y + h + mar;
        }
        NSLog(@"%f,%f",x,y);
        //最小宽度计算
        float w1 = size.width < w ? w : size.width;
        [text drawInRect:CGRectMake(x, y, w1, h) withFont:fnt];
        x += (w1 + mar);

    }
}
*/

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
//    _lastIndex = selectedIndex;
    if (self.delegate && [self.delegate respondsToSelector:@selector(navTitleMenuSelectedIndexUpdated:)]) {
        [self.delegate navTitleMenuSelectedIndexUpdated:selectedIndex];
    }

}

#pragma mark - Actions

- (void)selectItemAtIndex:(NSInteger)index{
    for (UIView *view in _container.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            //view is a Label
            view.layer.borderWidth = 0.f;
            if (view.tag == index) {
                view.layer.borderColor = kYellowTextColor.CGColor;
                view.layer.borderWidth = 2.f;
                _selectedIndex = view.tag;
                [self commit];
                break;
            }
        }
    }

}

- (void)selectItemForTitle:(NSString *)title{
    for (UIView *view in _container.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            //view is a Label
            view.layer.borderWidth = 0.f;
//            if (view.tag == index) {
            if ([[(UILabel *)view text] isEqualToString:title]){
                view.layer.borderColor = kYellowTextColor.CGColor;
                view.layer.borderWidth = 2.f;
                _selectedIndex = view.tag;
                [self commit];
                break;
            }
        }
    }
}

- (void)commit{
    self.selectedIndex = _selectedIndex;
    _lastIndex = _selectedIndex;
}

- (void)rollback{
    if (_lastIndex > 0) {
        self.selectedIndex = _lastIndex;
        for (UIView *view in _container.subviews) {
            if ([view isKindOfClass:[UILabel class]]) {
                //view is a Label
                view.layer.borderWidth = 0.f;
                if (view.tag == _lastIndex) {
                    view.layer.borderColor = kYellowTextColor.CGColor;
                    view.layer.borderWidth = 2.f;
                }
            }
        }
    }
}

- (void)addTarget:(id)target selector:(SEL)selector{
//Use assign not retain
    _target = target;
    _selector = selector;
}

- (void)showInView:(UIView *)view{
    if (_origFrame.size.height > view.bounds.size.height){
        _origFrame.size = view.bounds.size;
        _container.frame = CGRectMake(0, 0, _origFrame.size.width, _origFrame.size.height);
    }
    CGRect frame = _origFrame;  //self.frame;
    CGRect rect = frame;
    rect.size.height = 20.f;
    [view addSubview:self];
    self.frame = rect;
    [UIView beginAnimations:nil context:nil];
    self.frame = frame;
    [UIView commitAnimations];
    
    _opened = YES;
    
    [view insertSubview:_mask belowSubview:self];
}

- (void)dismiss{
    [UIView animateWithDuration:.2f
                     animations:^{
                         CGRect frame = self.frame;
                         CGRect rect = frame;
                         rect.size.height = 0.f;
                         self.frame = rect;
                     }
                     completion:^(BOOL b){
        [self removeFromSuperview];
    }];
    _opened = NO;
    [_mask removeFromSuperview];
}

- (void)maskTapped:(UITapGestureRecognizer *)g{
    if (_target && _selector) {
        [_target performSelector:_selector withObject:self afterDelay:.1f];
    }
}

#pragma mark - Touches
- (void)tapAction:(UITapGestureRecognizer *)g{
    [self handleTouchAt:[g locationInView:_container]];
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *t = [touches anyObject];
//    CGPoint loc = [t locationInView:_container];
- (void)handleTouchAt:(CGPoint)loc{
    for (UIView *view in _container.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            //view is a Label
            view.layer.borderWidth = 0.f;
            if (CGRectContainsPoint(view.frame, loc)) {
                view.layer.borderColor = kYellowTextColor.CGColor;
                view.layer.borderWidth = 2.f;
                _selectedIndex = view.tag;
                if (_target && _selector) {
                    [_target performSelector:_selector withObject:self afterDelay:.3f];
                }
            }
        }
    }
}

@end


@implementation NavTitleControl
@synthesize opened,hideIcon;

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.hideIcon) {
        
        UIImage *down = [UIImage imageNamed:@"ico_down.png"];
        UIGraphicsBeginImageContext(down.size);
        CGContextRef c = UIGraphicsGetCurrentContext();
        if (!self.opened) {
            CGContextTranslateCTM(c, 0, down.size.height);
            CGContextScaleCTM(c, 1, -1);
        }
        CGContextDrawImage(c, CGRectMake(0, 0, down.size.width, down.size.height), down.CGImage);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        CGSize size = [self.text sizeWithFont:self.font];
        //The frame of the center aligned text
        CGRect frame = CGRectMake((rect.size.width - size.width)/2, (rect.size.height - size.height), size.width, size.height);
        [image drawInRect:CGRectMake(frame.origin.x + size.width, (rect.size.height - down.size.height)/2, down.size.width, down.size.height)];
    }
}

- (void)setOpened:(BOOL)opened_{
    opened = opened_;
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    self.opened = !self.opened;
}
@end