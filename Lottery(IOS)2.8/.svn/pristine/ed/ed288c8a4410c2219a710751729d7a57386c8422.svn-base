//
//  LinkTabBar.m
//  Caipiao
//
//  Created by danal-rich on 4/1/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "LinkTabBar.h"

@interface LinkTabBar ()
@property (strong, nonatomic) UIImageView *arrowBlack;
@property (strong, nonatomic) UIImageView *arrowYellow;
@end

@implementation LinkTabBar

- (void)dealloc{
    [_titleItems release];
    [super dealloc];
}

- (void)setup{
    // Initialization code
    UIImage *bgImage = [UIImage imageNamed:@"tab_backgroud"];
    UIImageView *bg = [[UIImageView alloc] initWithImage:bgImage];
    bg.frame = self.bounds;
    bg.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:bg];
    [bg release];
    
    _scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scroll.showsHorizontalScrollIndicator = NO;
    _scroll.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:_scroll];
    _scroll.clipsToBounds = NO;
    
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [_scroll addGestureRecognizer:g];
    [g release];

}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setTitleItems:(NSArray *)titleItems{
    [_titleItems release];
    _titleItems = [titleItems retain];
    _selectedIndex = 0;
    float w = 78, h = 50, mar = 5;
    float x = mar, y = mar;
    for (int i = 0; i < [titleItems count]; i++) {
        LinkTabBarSegment *seg = [[LinkTabBarSegment alloc] initWithFrame:CGRectMake(x, y, w, h)];
        seg.tag = i+10;
        seg.titleLbl1.text = [NSString stringWithFormat:@"链接%d",i+1];
        seg.titleLbl2.text = [titleItems objectAtIndex:i];
        seg.selected = i == _selectedIndex;
        if (seg.selected){
            [self showArrowBelowSegment:seg];
        }
        
        [_scroll addSubview:seg];
        [seg release];
        x += w+mar;
    }
    _scroll.contentSize = CGSizeMake(x, self.bounds.size.height);
}

- (void)showArrowBelowSegment:(LinkTabBarSegment *)seg{
    if (!_arrowYellow){
        _arrowYellow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_arrow"]];
        [_scroll addSubview:_arrowYellow];
    }
    _arrowYellow.frame = CGRectMake(seg.frame.origin.x + (seg.bounds.size.width - _arrowYellow.bounds.size.width)/2, seg.frame.origin.y + seg.bounds.size.height,
                                    _arrowYellow.bounds.size.width, _arrowYellow.bounds.size.height);
    
    if (!_arrowBlack){
        _arrowBlack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_arrow_2"]];
        [_scroll addSubview:_arrowBlack];
    }
    _arrowBlack.frame = CGRectMake(seg.frame.origin.x + (seg.bounds.size.width - _arrowBlack.bounds.size.width)/2,
                                   _scroll.bounds.size.height,
                                   _arrowYellow.bounds.size.width, _arrowYellow.bounds.size.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)handleTap:(UITapGestureRecognizer *)g{
    CGPoint pos = [g locationOfTouch:0 inView:_scroll];
    for (UIView *v in _scroll.subviews){
        if ([v isKindOfClass:[LinkTabBarSegment class]]){
            if (CGRectContainsPoint(v.frame, pos)){
                _selectedIndex = v.tag-10;
                [(LinkTabBarSegment *)v setSelected:YES];
                [self showArrowBelowSegment:(LinkTabBarSegment *)v];
                [self sendActionsForControlEvents:UIControlEventValueChanged];
                
            } else {
                [(LinkTabBarSegment *)v setSelected:NO];
            }
        }
    }

}


@end


@implementation LinkTabBarSegment

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.selected = NO;
        _titleLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, frame.size.width, 20)];
        [self addSubview:_titleLbl1];
        _titleLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height/2, frame.size.width, 20)];
        [self addSubview:_titleLbl2];
        _titleLbl1.textAlignment = _titleLbl2.textAlignment = UITextAlignmentCenter;
        _titleLbl1.backgroundColor = _titleLbl2.backgroundColor = [UIColor clearColor];
        _titleLbl1.font = [UIFont boldSystemFontOfSize:13.f];
        _titleLbl2.font = [UIFont boldSystemFontOfSize:17.f];
    }
    return self;
}

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    self.image = _selected ? [UIImage imageNamed:@"tab_highlighted"] : [UIImage imageNamed:@"tab_normal"];
    _titleLbl1.textColor = _titleLbl2.textColor = _selected ? kGreenBGColor : kYellowTextColor;
}
@end