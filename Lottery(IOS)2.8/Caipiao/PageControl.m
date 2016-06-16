//
//  PageControl.m
//  Caipiao
//
//  Created by danal on 13-3-25.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "PageControl.h"

@implementation PageControl
@synthesize pointSize,pointMargin,currentIndex,numberOfPages;

- (void)dealloc{
    [_normalImage release];
    [_currentImage release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame normalImage:(UIImage *)normalImage currentImage:(UIImage *)currentImage{
    self = [self initWithFrame:frame];
    if (self) {
        _normalImage = [normalImage retain];
        _currentImage = [currentImage retain];
        self.backgroundColor = [UIColor clearColor];
        self.pointMargin = 5.f;
        self.pointSize = _normalImage.size;
        self.numberOfPages = 1;
        self.currentIndex = 0;
    }
    return self;
}

- (void)setCurrentIndex:(NSInteger)currentIndex_{
    currentIndex = currentIndex_;
    [self setNeedsDisplay];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages_{
    numberOfPages = numberOfPages_;
    
    CGRect rect = self.frame;
    rect.size.width = self.numberOfPages * self.pointSize.width + (self.numberOfPages + 1) * self.pointMargin;
    self.frame = rect;
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    float mar = self.pointMargin, x = mar, y = (rect.size.height - pointSize.height)/2;
    for (int i = 0; i < self.numberOfPages; i++) {
        CGRect rect = CGRectMake(x, y, pointSize.width, pointSize.height);
        if (i == self.currentIndex) {
            [_currentImage drawInRect:rect];
        } else {
            [_normalImage drawInRect:rect];
        }
        x += (pointSize.width + mar);
    }
}


@end
