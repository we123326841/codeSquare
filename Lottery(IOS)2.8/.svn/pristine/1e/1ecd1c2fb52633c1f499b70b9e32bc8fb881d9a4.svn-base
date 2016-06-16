//
//  Label+Factory.m
//  Caipiao
//
//  Created by danal on 13-10-10.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "View+Factory.h"
#import "Musou.h"

@implementation YellowLabel

- (void)setup{
    self.textColor = kYellowTextColor;
    self.font = [UIFont boldSystemFontOfSize:14.f];
    self.backgroundColor = [UIColor clearColor];
}

- (void)awakeFromNib{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setup];
    }
    return self;
}

@end


@implementation RoundedBlackView

- (void)setup{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3f];
    self.layer.cornerRadius = 4.f;
}

- (void)awakeFromNib{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setup];
    }
    return self;
}
@end


@implementation InRectTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

+ (BOOL)isAvailableAmount:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL isDecimal;
    
    if ([textField.text rangeOfString:@"."].location==NSNotFound) {
        isDecimal=NO;
    }
    if ([string length]>0)
    {
        unichar single=[string characterAtIndex:0];//当前输入的字符
        if ((single >='0' && single<='9') || single=='.')//数据格式正确
        {
            //首字母不能为小数点
            if([textField.text length]==0){
                if(single == '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            if (single=='.')
            {
                if(!isDecimal)//text中还没有小数点
                {
                    isDecimal=YES;
                    return YES;
                }else
                {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            else
            {
                if (isDecimal)//存在小数点
                {
                    //判断小数点的位数
                    NSRange ran=[textField.text rangeOfString:@"."];
                    int tt=range.location-ran.location;
                    if (tt <= 2){
                        return YES;
                    }else{
                        return NO;
                    }
                }
                else
                {
                    return YES;
                }
            }
        }else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
}

- (void)setup
{
    //self.bounds=CGRectMake(0, 0, 269, 45);
    self.backgroundColor=[UIColor clearColor];
    
    UIImageView *bg=[[UIImageView alloc] initWithFrame:self.bounds];
    bg.image=[UIImage imageNamed:@"input-rect.png"];
    [self addSubview:bg];
    [bg release];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(5, 14, self.bounds.size.width-10, self.bounds.size.height)];
    tf.borderStyle = UITextBorderStyleNone;
    tf.font=[UIFont systemFontOfSize:15.f];
    tf.clearButtonMode = UITextFieldViewModeNever;
    tf.textColor = [UIColor whiteColor];
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    [self addSubview:tf];
    self.textfield=tf;
    [tf release];
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clearButton.frame = CGRectMake(self.bounds.size.width - 20, self.bounds.size.height/2 - 12/2, 12, 12);
    self.clearButton.alpha = 0;
    [self.clearButton setImage:[UIImage imageNamed:@"clear.png"] forState:UIControlStateNormal];
    [self.clearButton addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.clearButton];
}

- (void)clearAction:(id)sender
{
    self.clearButton.alpha = 0;
    self.textfield.text=@"";
}

- (void)dealloc
{
    RELEASE(_textfield);
    RELEASE(_clearButton);
    [super dealloc];
}

@end

@implementation YellowButton

- (void)setup{
    [self setTitleColor:kDarkGreenColor forState:UIControlStateNormal];
}

- (void)awakeFromNib{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setup];
    }
    return self;
}

@end



@implementation RoundedBlackTextField

- (void)awakeFromNib{
    self.textColor = kYellowTextColor;
    self.background = [UIImage imageNamed:@"input-rect.png"];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)] autorelease];
    self.leftView.backgroundColor = [UIColor clearColor];

    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button setImage:[UIImage imageNamed:@"clear.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, (self.bounds.size.height-12)/2, 20, 12);
    [button addTarget:self action:@selector(clearText:) forControlEvents:UIControlEventTouchUpInside];
    self.rightView = button;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)removeFromSuperview{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super removeFromSuperview];
}

- (void)textDidChange{
    if (self.clearButtonMode == UITextFieldViewModeWhileEditing){
        self.rightViewMode = [self.text length] > 0 ? UITextFieldViewModeAlways : UITextFieldViewModeNever;
    }
}

- (void)clearText:(id)sender{
    self.text = nil;
    [self textDidChange];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self awakeFromNib];
    }
    return self;
}

@end


@implementation YellowFrameTextField

- (void)awakeFromNib{
//    self.background = [UIImage imageNamed:@"input-rect.png"];
    self.layer.borderColor = kYellowTextColor.CGColor;
    self.layer.borderWidth = 1.f;
    self.layer.cornerRadius = 5.f;
    
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)] autorelease];
    self.leftView.backgroundColor = [UIColor clearColor];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self awakeFromNib];
    }
    return self;
}

@end

@implementation WhiteAlertView

- (id)initWithTitle:(NSString *)title titleIcon:(UIImage *)image contentView:(UIView *)contentView cancelButtonTitle:(NSString *)cancelButtonTitle
{
    self = [super init];
    if (self) {
        self.frame = [[UIScreen mainScreen] bounds];
        
        UIView *mask = [[UIView alloc] initWithFrame:self.bounds];
        mask.backgroundColor = [UIColor blackColor];
        mask.alpha = 0.7f;
        [self addSubview:mask];
        [mask release];
        
        _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 266)];
        _bgView.image = [UIImage imageNamed:@"alert_bg.png"];
        _bgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _bgView.userInteractionEnabled = YES;
        [self addSubview:_bgView];
//        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 266)];
//        bgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
//        bgView.backgroundColor = [UIColor whiteColor];
//        [self addSubview:bgView];
        
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, _bgView.bounds.size.width, 50)];
        _titleLbl.font = [UIFont systemFontOfSize:16.f];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.backgroundColor = [UIColor clearColor];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.text = title;
        [_bgView addSubview:_titleLbl];
        [_titleLbl sizeToFit];
        _titleLbl.frame = CGRectMake(_bgView.bounds.size.width/2 - _titleLbl.bounds.size.width/2, 2, _titleLbl.bounds.size.width, 50);
        
        if (image) {
            CGRect tRect = _titleLbl.frame;
            tRect.origin.x +=image.size.width - 10;
            _titleLbl.frame = tRect;
            
            _titleIcon = [[UIImageView alloc] initWithFrame:CGRectMake(_titleLbl.frame.origin.x - image.size.width - 10, _titleLbl.bounds.size.height/2 - image.size.height/2, image.size.width, image.size.height)];
            _titleIcon.image = image;
            [_bgView addSubview:[_titleIcon autorelease]];
        }
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 55, _bgView.bounds.size.width, _bgView.bounds.size.height - 120)];
        v.backgroundColor = [UIColor clearColor];
        [_bgView addSubview:[v autorelease]];
        
        _errorLbl = [[UILabel alloc] initWithFrame:CGRectMake(75, 0, 185, 20)];
        _errorLbl.textColor = [UIColor redColor];
        _errorLbl.font = [UIFont systemFontOfSize:13.f];
        _errorLbl.backgroundColor = [UIColor clearColor];
        [v addSubview:[_errorLbl autorelease]];
        
        contentView.frame = CGRectMake(v.bounds.size.width/2 - contentView.bounds.size.width/2, v.bounds.size.height/2 - contentView.bounds.size.height/2, contentView.bounds.size.width, contentView.bounds.size.height);
        [v addSubview:contentView];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        _cancelButton.frame = CGRectMake(_bgView.frame.size.width/2 - 189/2, _bgView.frame.size.height - 50, 189, 34);
        [_cancelButton setBackgroundImage:[UIImage imageNamed:@"alert_button_1.png"] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_cancelButton];
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)title titleIcon:(UIImage *)image contentView:(UIView *)contentView cancelButtonTitle:(NSString *)cancelButtonTitle isSingleButton:(BOOL)isSingleButton
{
    self = [self initWithTitle:title titleIcon:image contentView:contentView cancelButtonTitle:cancelButtonTitle];
    if (self) {
        [self.cancelButton setBackgroundImage:[UIImage imageNamed:isSingleButton ? @"alert_button_2.png" : @"alert_button_1.png"] forState:UIControlStateNormal];
        [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

+ (CGFloat)width
{
    return 300.f;
}

+ (CGFloat)height
{
    return 146.f;
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow insertSubview:self atIndex:999];
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    kfa.values = [NSArray arrayWithObjects:
                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.f)],
                  [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.f, 1.f, 1.f)],
                  nil];
    [self.layer addAnimation:kfa forKey:nil];
}

- (void)dismiss
{
    [UIView animateWithDuration:.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)addAlertButtonWithTitle:(NSString *)title
                          frame:(CGRect)rect
                         target:(id)target
                         action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
    btn.frame = rect;
    [btn setBackgroundImage:[UIImage imageNamed:@"alert_button_1.png"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:_cancelButton];
}

@end

@implementation GreenAlertButton

- (void)setup{
    CGRect rect = self.frame;
    rect.size = CGSizeMake(189, 34);
    self.frame = rect;
    self.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"alert_button_2.png"] forState:UIControlStateNormal];
}

- (void)awakeFromNib{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setup];
    }
    return self;
}

@end

@implementation TiledImageView

- (void)dealloc{
    [_image release];
    [super dealloc];
}

- (void)drawRect:(CGRect)rect{
//    CGContextRef c = UIGraphicsGetCurrentContext();
    UIImage *image = self.image;
    //Draw the edge
    [image drawAtPoint:CGPointMake(0, 0)];
    
    //Spread
    int row = ceilf(rect.size.height/image.size.height);
    for (int i = 0; i < row; i++) {
        [image drawInRect:CGRectMake(0, _edge.top + i*image.size.height, rect.size.width, image.size.height)];
    }
}

@end

@implementation RoundedNumberCluster

- (void)awakeFromNib{
    self.backgroundColor = [UIColor clearColor];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self awakeFromNib];
    }
    return self;
}

- (void)setCount:(int)count
{
    _count = count;
    [self removeSubviews];
    for (int i = 0; i < self.count; ++i) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.tag = i + 1;
        item.frame = CGRectMake(20*i, 0, 18, 18);
        item.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        [item setTitleColor:kDarkGreenColor forState:UIControlStateNormal];
        [item setTitleColor:kDarkGreenColor forState:UIControlStateHighlighted];
        [item setBackgroundImage:[UIImage imageNamed:@"ball_yellow.png"] forState:UIControlStateNormal];
        [item setBackgroundImage:[UIImage imageNamed:@"ball_yellow.png"] forState:UIControlStateHighlighted];
        [self addSubview:item];
        item.hidden = YES;
    }
}

- (void)setSsqCount:(int)ssqCount
{
    _ssqCount = ssqCount;
    
    [self removeSubviews];
    for (int i = 0; i < self.ssqCount; ++i) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        item.tag = i + 1;
        item.frame = CGRectMake(20*i, 0, 18, 18);
        item.titleLabel.font = [UIFont boldSystemFontOfSize:12.f];
        [item setTitleColor:kWhiteTextColor forState:UIControlStateNormal];
        [item setTitleColor:kWhiteTextColor forState:UIControlStateHighlighted];
        UIImage *bgImage = [UIImage imageNamed: i == self.ssqCount - 1 ? @"ball_blue.png" : @"ball_red.png"];
        [item setBackgroundImage:bgImage forState:UIControlStateNormal];
        [item setBackgroundImage:bgImage forState:UIControlStateHighlighted];
        [self addSubview:item];
        item.hidden = YES;
    }
}

- (void)setNumber:(NSString *)number
{
    for (int i = 0; i < [number length]; ++i) {
        UIButton *button = (UIButton *)[self viewWithTag:i + 1];
        [button setTitle:[number substringWithRange:NSMakeRange(i, 1)] forState:UIControlStateNormal];
        button.hidden = NO;
    }
}

- (void)setSSQNumber:(NSString *)number
{
    for (int i = 0; i < [number length]; ++i) {
        UIButton *button = (UIButton *)[self viewWithTag:i + 1];
        [button setTitle:[number substringWithRange:NSMakeRange(3*i, 2)] forState:UIControlStateNormal];
        button.hidden = NO;
    }
}

@end


@implementation YellowDropBox

- (void)dealloc
{
    [_boxButton release];
    Block_release(_selectNumberBlock);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame startNumber:(int)sNum endNumber:(int)eNum
{
    self = [super initWithFrame:frame];
    if (self) {
        _startNumber = sNum;
        _endNumber = eNum;
        
        [self awakeFromNib];
        
        for (int i = _startNumber; i <= _endNumber; ++i) {
            UIButton *button = (UIButton *)[self viewWithTag:i];
            [button removeFromSuperview];
        }
        
        int x = 0;
        for (int i = _startNumber; i <= _endNumber; ++i) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(x%2 == 0 ? 0 : self.frame.size.width/2, x/2 * _height + _height, self.frame.size.width/2, _height);
            button.titleLabel.font = [UIFont boldSystemFontOfSize:12.f];
            button.tag = i;
            button.hidden = YES;
            [button setTitle:[NSString stringWithFormat:@"%d个",i] forState:UIControlStateNormal];
            [button setTitleColor:kDarkGreenColor forState:UIControlStateNormal];
            [button addTarget:self action:@selector(selectRandom:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            ++x;
        }
    }
    return self;
}

- (void)awakeFromNib
{
    _height = self.frame.size.height;
    self.backgroundColor = [UIColor rgbColorWithHex:@"ffc410"];
    self.selectedNumber = 1;
    
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 18, self.frame.size.height/2 - 5/2, 9, 5)];
    arrow.image = [UIImage imageNamed:@"arrow_down.png"];
    [self addSubview:arrow];
    [arrow release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12.f];
    button.frame = self.bounds;
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    [button setTitle:@"机选" forState:UIControlStateNormal];
    [button setTitleColor:kDarkGreenColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dropAction:) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:button atIndex:999];
    self.boxButton = button;
}

- (void)selectRandom:(UIButton *)sender
{
    self.selectedNumber = sender.tag;
    [self dropAction:nil];
    self.selectNumberBlock(self, self.selectedNumber);
}

- (void)dropAction:(UIButton *)sender
{
    CGRect rect = self.frame;
    if (_isSelected) {
        rect.size.height = _height;
        for (int i = _startNumber; i <= _endNumber; ++i) {
            UIButton *button = (UIButton *)[self viewWithTag:i];
            button.hidden = YES;
        }
    }else {
        int row = (_endNumber - _startNumber + 1)%2 == 0 ? (_endNumber - _startNumber + 1)/2 : (_endNumber - _startNumber + 1)/2 + 1;
        rect.size.height += row*rect.size.height;
        for (int i = _startNumber; i <= _endNumber; ++i) {
            UIButton *button = (UIButton *)[self viewWithTag:i];
            button.hidden = NO;
        }
    }
    self.frame = rect;
    _isSelected = !_isSelected;
    [self setNeedsDisplay];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = 4.f;
}

@end


//TableView Cell
@implementation Line

- (void)awakeFromNib{
    self.backgroundColor = [UIColor colorWithRed:0xd1/255.f green:0xd1/255.f blue:0xd1/255.f alpha:1.f];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self awakeFromNib];
    }
    return self;
}

@end


@implementation PlainCellView

- (void)dealloc{
    self.lineColor = nil;
    self.lineImage = nil;
    [super dealloc];
}

- (void)awakeFromNib{
    self.lineColor = [UIColor colorWithRed:0xd1/255.f green:0xd1/255.f blue:0xd1/255.f alpha:1.f];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self awakeFromNib];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 1.0);
    CGContextSetAllowsAntialiasing(c, false);
    CGContextSetShouldAntialias(c, false);
    
    [self.lineColor set];
    switch (_linePos) {
        case LineAtTop:
        {
            if (_lineImage) {
                [_lineImage drawAtPoint:CGPointZero];
            }
            else {
                CGContextMoveToPoint(c, 0, 0);
                CGContextAddLineToPoint(c, rect.size.width, 0);
                CGContextStrokePath(c);
            }
        }
            break;
        case LineAtBottom:
        {
            if (_lineImage){
                [_lineImage drawAtPoint:CGPointMake(0, rect.size.height)];
            }
            else {
                CGContextMoveToPoint(c, 0, rect.size.height);
                CGContextAddLineToPoint(c, rect.size.width, rect.size.height);
                CGContextStrokePath(c);
            }
        }
            break;
        case LineAtTopAndBottom:
        {
            if (_lineImage){
                [_lineImage drawAtPoint:CGPointZero];
                [_lineImage drawAtPoint:CGPointMake(0, rect.size.height-1)];
            } else {
                CGContextMoveToPoint(c, 0, 0);
                CGContextAddLineToPoint(c, rect.size.width, 0);
                CGContextMoveToPoint(c, 0, rect.size.height);
                CGContextAddLineToPoint(c, rect.size.width, rect.size.height);
                CGContextStrokePath(c);
            }
        }
            break;
        default:
            break;
    }
}

@end


@implementation PlainCellViewBottom

- (void)awakeFromNib{
    [super awakeFromNib];
    self.linePos = LineAtBottom;
}

@end


@implementation PlainCellViewBoth

- (void)awakeFromNib{
    [super awakeFromNib];
    self.linePos = LineAtTopAndBottom;
}

@end


@implementation BadgeIconButton

- (void)setBadge:(NSInteger)badge{
    _badge = badge;

    if (!_badgeIcon){
        _badgeIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        _badgeIcon.layer.anchorPoint = CGPointMake(0.5, 0.5);
        _badgeIcon.frame = CGRectMake(self.bounds.size.width-10, -10, 28, 28);
        _badgeIcon.titleLabel.font = [UIFont systemFontOfSize:10];
        _badgeIcon.titleEdgeInsets = UIEdgeInsetsMake(-2, -2, 0, 0);
        [_badgeIcon setBackgroundImage:ResImage(@"basket-badge.png") forState:UIControlStateNormal];
        [_badgeIcon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _badgeIcon.userInteractionEnabled = NO;
        [self addSubview:_badgeIcon];
    }
    _badgeIcon.hidden = badge == 0;
    if (badge <= 100){
        _badgeIcon.titleLabel.font = [UIFont systemFontOfSize:10];
        [_badgeIcon setTitle:[@(badge) stringValue] forState:UIControlStateNormal];
    }
    else {
        _badgeIcon.titleLabel.font = [UIFont systemFontOfSize:8];
        [_badgeIcon setTitle:@"99+" forState:UIControlStateNormal];
    }
}

- (void)setBadgeOffset:(CGPoint)badgeOffset{
    _badgeOffset = badgeOffset;
    _badgeIcon.frame = CGRectMake(self.bounds.size.width+badgeOffset.x, badgeOffset.y, 20, 20);
}
@end


@implementation GridLayer

- (void)dealloc{
    self.gridColor = nil;
    [super dealloc];
}

- (void)displayAsRow:(NSInteger)numOfRow andColumn:(NSInteger)numOfCol{
    _row = numOfRow;
    _col = numOfCol;
    if (!_gridColor) {
        self.gridColor = [UIColor colorWithRed:0xE3/255.f green:0xE3/255.f blue:0xE3/255.f alpha:1.f];
    }
    self.contentsScale = [UIScreen mainScreen].scale;
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)ctx{
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    CGFloat w = rect.size.width/_col, h = rect.size.height/_row;
    CGContextSetStrokeColorWithColor(ctx, self.gridColor.CGColor);
    //    CGContextSetAllowsAntialiasing(ctx, false);
    CGContextSetLineWidth(ctx, .5f);
    for (NSInteger row = 0; row < _row+1; row++) {
        CGContextMoveToPoint(ctx, 0, row*h-.5f);
        CGContextAddLineToPoint(ctx, rect.size.width, row*h-.5f);
    }
    for (NSInteger col = 0; col < _col; col++) {
        CGContextMoveToPoint(ctx, col*w, 0);
        CGContextAddLineToPoint(ctx, col*w, rect.size.height);
    }
    CGContextStrokePath(ctx);
}

@end

