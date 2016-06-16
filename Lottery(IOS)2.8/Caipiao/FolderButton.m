//
//  FolderButton.m
//  Caipiao
//
//  Created by danal on 13-1-15.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "FolderButton.h"
#import "IconTextButton.h"
#import "TouchLabel.h"

#define kDiff 0.f

@implementation FolderButton
@synthesize items = _items;
@synthesize folderView = _folderView;
@synthesize selectedIndex = _selectedIndex;

- (void)dealloc{
    [_arrow release];
    [_folderView release];
    [_items release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        CGRect rect = self.bounds;
//        rect.size.width -= 30.f;
        IconTextButton *rightButton = [IconTextButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = rect;    //CGRectMake(170, 10, 110, 36);
        rightButton.backgroundColor = [UIColor clearColor];
        rightButton.layer.cornerRadius = 5.f;
        rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
        rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [rightButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        [rightButton setTitle:@"机选" forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightButton];
        
        _arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_sj_highyellow.png"]];
        _arrow.frame = CGRectMake(frame.size.width - 30, (frame.size.height - _arrow.bounds.size.height)/2,
                                  _arrow.bounds.size.width, _arrow.bounds.size.height);
        [self addSubview:_arrow];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(c, .5f);
    [[UIColor blackColor] set];
    float corner = 5.f;
    if (_opened) {
        float x = rect.origin.x, y = rect.origin.y;
        float w = rect.size.width, h = rect.size.height;
        CGContextMoveToPoint(c, x, y + h/2);
        //left-top
        CGContextAddArcToPoint(c, x, y, x+w/2, y, corner);
        //right-top
        CGContextAddArcToPoint(c, x+w, y, x + w, y+h/2, corner);
        //right-bottom
        CGContextAddLineToPoint(c, x+w, y + h);
        //left-bottom
        CGContextAddLineToPoint(c, x, y + h);
        CGContextClosePath(c);
    } else{
        CGRectAddRoundedCornerPath(rect, corner, kRounderCornerPostionAll, c);
    }
    
    CGContextFillPath(c);
}

- (void)open{
    if (_folderView == nil) {
        CGRect rect = CGRectMake(self.frame.origin.x,
                                 self.frame.origin.y + self.bounds.size.height - kDiff,
                                 self.bounds.size.width, 100.f);
        self.items = [NSArray arrayWithObjects:@"1注",@"2注",@"5注",@"10注",@"15注",@"20注", nil];
        _folderView = [[FolderView alloc] initWithFrame:rect items:self.items];
        _origFrame = _folderView.frame;
        [_folderView setSelectorForItemClick:@selector(itemSelectAction:) target:self];
        [self.superview insertSubview:_folderView atIndex:100];
    }
    _folderView.hidden = NO;
    CGRect frame = _origFrame;
    CGRect rect = frame;
    rect.size.height = 0;
    _folderView.frame = rect;
    _opened = YES;
    _arrow.transform = CGAffineTransformMakeScale(1.f, -1.f);
    [self setNeedsDisplay];
    [UIView animateWithDuration:.2f
                     animations:^{
                         _folderView.frame = frame;
                     }
                     completion:^(BOOL b){
                     }];
    //Mask
    UIView *mask = [[UIView alloc] initWithFrame:self.superview.bounds];
    [self.superview insertSubview:mask belowSubview:self];
    _maskView = mask;
    [mask release];
    
    //Tap gesture
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskTapAction:)];
    [mask addGestureRecognizer:g];
    [g release];
}

- (void)close{
    [_maskView removeFromSuperview];
    [UIView animateWithDuration:.2f
                     animations:^{
                         CGRect frame = _folderView.frame;
                         CGRect rect = frame;
                         rect.size.height = 0;
                         _folderView.frame = rect;
                     }
                     completion:^(BOOL b){
                         _folderView.hidden = YES;
                         _opened = NO;
                         _arrow.transform = CGAffineTransformMakeScale(1.f, 1.f);
                         [self setNeedsDisplay];
                     }];

}

- (void)maskTapAction:(UITapGestureRecognizer *)g{
    [self close];
}

- (void)buttonAction:(UIButton *)sender{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    if (_opened) {  //close
        [self close];
    } else {    //open
        [self open];
    }
    
}

- (void)itemSelectAction:(FolderView *)sender{
    self.selectedIndex = sender.selectedIndex;
    [self buttonAction:nil];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end

#pragma mark -

#define kItemHeight 30.f

@implementation FolderView
@synthesize selectedIndex = _selectedIndex;
@synthesize items = _items;

- (void)dealloc{
    [_items release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items{
    frame.size.height = ceilf([items count]*1.f/2) * kItemHeight + kDiff;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        float w = frame.size.width/2, h = kItemHeight;
        float x = 0, y = kDiff;
        int i = 0;
        for (NSString *title in items){
            TouchLabel *lbl = [[TouchLabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
            lbl.backgroundColor = [UIColor clearColor];   //[UIColor randomColor];
            lbl.textColor = kYellowTextColor;
            lbl.font = [UIFont boldSystemFontOfSize:14.f];
            lbl.textAlignment = UITextAlignmentCenter;
            lbl.text = title;
            lbl.tag = i;
            [lbl addTarget:self selector:@selector(touchAction:)];
            [self addSubview:lbl];
            [lbl release];
            
            x += w;
            if (x == 2*w) x = 0, y += h;
            i++;
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    UIImage *grid = [UIImage imageNamed:@"game_ramdom_line.png"];
    [grid drawInRect:CGRectInset(rect, 5.f, 5.f) blendMode:kCGBlendModeNormal alpha:.5f];
    
    CGContextSetAlpha(c, .5f);
    [[UIColor blackColor] set];

    float corner = 5.f;
    float x = rect.origin.x, y = rect.origin.y;
    float w = rect.size.width, h = rect.size.height;
    CGContextMoveToPoint(c, x, y + h/2);
    //left-top
    CGContextAddLineToPoint(c, x, y);
    //right-top
    CGContextAddLineToPoint(c, x + w, y);
    //right-bottom
    CGContextAddArcToPoint(c, x+w, y+h, x+w/2, y+h, corner);
    //left-bottom
    CGContextAddArcToPoint(c, x, y+h, x, y, corner);
    CGContextClosePath(c);
//    CGContextAddRect(c, rect);
    CGContextFillPath(c);
}

- (void)setSelectorForItemClick:(SEL)selector target:(id)target{
    _selector = selector;
    _target = target;
}

- (void)touchAction:(TouchLabel *)sender{
    self.selectedIndex = sender.tag;
    if (_target && _selector) {
        [_target performSelector:_selector withObject:self];
    }
}

@end