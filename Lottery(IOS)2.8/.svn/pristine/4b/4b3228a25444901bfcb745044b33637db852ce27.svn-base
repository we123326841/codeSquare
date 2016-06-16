//
//  LinkLabel.m
//  Musou
//
//  Created by luo danal on 8/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LinkLabel.h"

@implementation LinkLabel
@synthesize url;

- (void)dealloc{
    [url release];
    [_invocations release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        self.highlightedTextColor = [UIColor orangeColor];
        self.textAlignment = UITextAlignmentRight;
        _invocations = [[NSMutableArray alloc] init];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    CGSize size = [self.text sizeWithFont:self.font constrainedToSize:rect.size];
    CGRect lineRect = CGRectMake(0, rect.size.height - 1, size.width, 1);
    if (self.textAlignment == UITextAlignmentCenter) {
        if (size.width < rect.size.width) {
            lineRect.origin.x = (rect.size.width - size.width)/2;
        }
    } else if(self.textAlignment == UITextAlignmentRight) {
        if (size.width < rect.size.width) {
            lineRect.origin.x = rect.size.width - size.width;
        }
    }
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 1);
    UIRectFrame(lineRect);
    
//    CGContextMoveToPoint(c, 0, rect.size.height -1);
//    CGContextAddLineToPoint(c, rect.size.width, rect.size.height - 1);
//    [[UIColor blueColor] setStroke];
//    CGContextStrokePath(c);
}


#pragma mark - Actions

- (void)recoverTextColor{
    self.highlighted = NO;
}

- (void)addTarget:(id)target action:(SEL)selector{
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    if (signature == nil) {
        NSLog(@"signature is null");
        return;
    }
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = target;
    invocation.selector = selector;
    [_invocations addObject:invocation];
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!self.highlighted) {
        self.highlighted = YES;
        for (NSInvocation *invocation in _invocations){
            if (invocation.methodSignature.numberOfArguments == 3) {
                [invocation setArgument:self atIndex:2];
            }
            [invocation invoke];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self performSelector:@selector(recoverTextColor) withObject:nil afterDelay:0.2f];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self performSelector:@selector(recoverTextColor) withObject:nil afterDelay:0.2f];
}

@end
