//
//  PopMenu.m
//  Caipiao
//
//  Created by danal on 13-1-7.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PopMenu.h"
#import "TouchLabel.h"

#define kMargin 10.f
#define kTitleRowHeight 30.f

static PopMenu *_currentPopMenu = nil;

@implementation PopMenu
@synthesize titles = _titles;
@synthesize selectedIndex;

- (void)dealloc{
    [_titles release];  _titles = nil;
    [_bgView release];  _bgView = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _origFrame = frame;
        self.layer.cornerRadius = 5.f;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles{
    frame.size.width = frame.size.width + kMargin;  //plus margin for right shadow
    frame.size.height = kMargin + kTitleRowHeight*[titles count] + 1.5f*kMargin; //plus margin for bottom shadow
    self = [self initWithFrame:frame];
    if (self) {
        self.titles = titles;
        for (int i = 0; i < [titles count]; i++) {
            TouchLabel *lbl = [[TouchLabel alloc] initWithFrame:CGRectMake(0, kMargin+kTitleRowHeight*i, frame.size.width, kTitleRowHeight)];
            lbl.text = [titles objectAtIndex:i];
            lbl.tag = i;
            lbl.font = [UIFont boldSystemFontOfSize:15.f];
            lbl.textColor = [UIColor blackColor];
            lbl.textAlignment = UITextAlignmentCenter;
            lbl.backgroundColor = [UIColor clearColor];
            [lbl addTarget:self selector:@selector(lblTouch:)];
            [self addSubview:lbl];
            
            if (i < [titles count] - 1) {
                
                UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dialog_line.png"]];
                line.frame = CGRectMake(5, lbl.frame.origin.y + lbl.frame.size.height, frame.size.width - 20.f, 2);
                [self addSubview:line];
                [line release];
            }
        }
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//    [[UIColor whiteColor] set];
//    UIRectFill(rect);
    float mar = kMargin;
    NSString *path = [NSBundle pathForRes:@"dialog.png"];
    UIImage *dialog = [UIImage imageWithContentsOfFile:path];
    [dialog drawInRect:rect];
    return;
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(c, 1.f);
    CGContextSetFillColorWithColor(c, kYellowTextColor.CGColor);
    
    CGContextMoveToPoint(c, _offset.x - 0.5*mar, mar);
    CGContextAddLineToPoint(c, _offset.x, mar*0.5);
    CGContextAddLineToPoint(c, _offset.x + 0.5*mar, mar);
    CGContextClosePath(c);
    CGContextFillPath(c);
    
    float x = rect.origin.x, y = rect.origin.y + mar;
    float w = rect.size.width, h = rect.size.height;
    CGContextMoveToPoint(c, x, y + h/2);
    //left-top
    CGContextAddArcToPoint(c, x, y, x+w/2, y, 5.f);
    //right-top
    CGContextAddArcToPoint(c, x+w, y, x + w, y+h/2, 5.f);
    //right-bottom
    CGContextAddArcToPoint(c, x+w, y+h, x+w/2, y+h, 5.f);
    //left-bottom
    CGContextAddArcToPoint(c, x, y+h, x, y, 5.f);
//    CGContextClosePath(c);
    CGContextFillPath(c);
    
}


- (void)showInView:(UIView *)view atAnchor:(CGPoint)anchor{

    CGRect frame = _origFrame;
    float ratio = anchor.x/view.bounds.size.width;
    _offset = CGPointMake(frame.size.width*ratio, _origFrame.size.height);
    frame.origin.x = anchor.x - _offset.x;
    frame.origin.y = anchor.y + _offset.y + 5.f;
    self.frame = frame;
    
    [self setNeedsDisplay];
    [view addSubview:self];
    
    CGRect rect = frame;
    rect.size.height = 40.f;
    self.frame = rect;
    [UIView beginAnimations:nil context:nil];
    self.frame = frame;
    [UIView commitAnimations];
    
    _currentPopMenu = self;
}

- (void)showBelowView:(UIView *)view alignFrame:(CGRect)alignFrame{
    UIView *superView = view.superview;
    CGRect rect = view.frame;
    rect.origin.y += rect.size.height + 5.f;
    rect.origin.x = alignFrame.origin.x + MAX((alignFrame.size.width - self.frame.size.width)/2,0.f);
    self.frame = CGRectMake(rect.origin.x, rect.origin.y, self.frame.size.width, self.frame.size.height);
    [superView addSubview:self];
    _currentPopMenu = self;
}

- (void)showBelowNavbar:(UINavigationBar *)navbar position:(PopNavbarPosition)pos{
    CGRect rect = self.frame;
    float x = 0, y = 0;
    if (pos == kPopNavbarPositionRight) {
        x = navbar.frame.size.width - self.bounds.size.width;
        y = navbar.frame.size.height;
    }
    _offset = CGPointMake(self.bounds.size.width - 20.f, 10.f);  //CGPointMake(frame.size.width*ratio, _origFrame.size.height);
    rect.origin = CGPointMake(x, y + 5.f);
    CGRect frame = rect;
    self.frame = rect;
 
    //add mask
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskTapAction:)];
    UIView *mask = [[UIView alloc] initWithFrame:navbar.superview.bounds];
    mask.tag = 0xefef;
    [mask addGestureRecognizer:g];
    [navbar.superview addSubview:mask];
    [mask release];
    [g release];
    
    //add self
    [navbar.superview addSubview:self];
    
    rect.size.height = 10.f;
    self.frame = rect;
    [UIView beginAnimations:nil context:nil];
    self.frame = frame;
    [UIView commitAnimations];
    
    _currentPopMenu = self;
    
}

- (void)showAtBarButtonItem:(UIBarButtonItem *)barButtonItem{
    NSLog(@"%@,%@",barButtonItem,barButtonItem.customView);
    
//    CGRect rect = barButtonItem.customView.frame;
//    CGRect frame = _origFrame;
  
    _currentPopMenu = self;
}

- (void)dismiss{
    [[self.superview viewWithTag:0xefef] removeFromSuperview];
    [self removeFromSuperview];
    _currentPopMenu = nil;
}

- (void)maskTapAction:(id)sender{
    [self dismiss];
}

- (void)setTarget:(id)target selector:(SEL)selector{
    _target = target;
    _selector = selector;
}

- (void)lblTouch:(TouchLabel *)sender{
    int index = sender.tag;
    self.selectedIndex = index;
    if (_target && _selector) {
        [_target performSelector:_selector withObject:self];
    }
    [self dismiss];
}

+ (void)dismissCurrent{
    [_currentPopMenu dismiss];
}

@end
