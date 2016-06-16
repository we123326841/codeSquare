//
//  AlertHUD.m
//  Caipiao
//
//  Created by danal on 13-3-26.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "AlertHUD.h"

@implementation AlertHUD

- (void)dealloc{
    [_timer invalidate];    _timer = nil;
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

- (void)show{
    [super show];
    self.bounds = CGRectMake(0, 0, 300, 80);
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(removeMe) userInfo:nil repeats:NO];
    [_timer fire];
}

- (void)removeMe{
    [_timer invalidate];    _timer = nil;
    self.delegate  = nil;
    [self dismissWithClickedButtonIndex:0 animated:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (void)showMessage:(NSString *)message{
    AlertHUD *alert = [[AlertHUD alloc] initWithTitle:@""
                                              message:message
                                             delegate:nil
                                    cancelButtonTitle:nil
                                    otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

@end


@implementation AlertView
@synthesize completeBlock = _completeBlock;

- (void)dealloc{
    Block_release(_completeBlock);
    [super dealloc];
}

- (id)initWithTitle:(NSString *)title msg:(NSString *)msg okButton:(NSString *)okTitle cancelButton:(NSString *)cancelTitle{
    
    UIView *contentView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 146)] autorelease];
    contentView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 260, 120)];
    label.text = msg;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14.f];
    label.numberOfLines = 0;
    label.textAlignment = UITextAlignmentCenter;
    [contentView addSubview:label];
    
    GreenAlertButton *okButton = [[GreenAlertButton alloc] initWithFrame:CGRectMake(56, 112, 189, 34)];
    [okButton setTitle:okTitle forState:UIControlStateNormal];
    [contentView addSubview:okButton];
    _okButton = okButton;
    
    self = [super initWithTitle:title titleIcon:nil contentView:contentView cancelButtonTitle:cancelTitle];
    self = [super initWithFrame:CGRectMake(0, 0, 200, 100)];
    if (self){
        self.okButton.tag = 1;
        self.cancelButton.tag = 0;
        [self.cancelButton removeTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.okButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (IBAction)buttonAction:(UIButton *)sender{
    if (_completeBlock){
        _completeBlock(self, sender.tag == 1);
    }
    [self dismiss];
}

@end



@implementation WhiteAlert

- (void)dealloc{
    self.completeBlock = nil;
    [super dealloc];
}

- (IBAction)onButtonClick:(UIButton *)sender{
    if (_completeBlock){
        _completeBlock(self, sender.tag);
    }
    [self dismiss];
}

- (void)show{
    _titleLbl.textColor = Color(@"AlertTextColor");
    _msgLbl.textColor = Color(@"AlertTextColor");
    _detailLbl.textColor = Color(@"AlertTextColor");
    _detailLbl1.textColor = Color(@"AlertTextColor");
    [_button setTitleColor:Color(@"AlertButtonTextColor") forState:UIControlStateNormal];
    [_button1 setTitleColor:Color(@"AlertButtonTextColor") forState:UIControlStateNormal];
    UIImage *bg = ResImage(@"alert-bg.png");
    _background.frame = self.bounds;
    _background.image = [bg resizableImageWithCapInsets:UIEdgeInsetsMake(bg.size.height/3, bg.size.width/3, bg.size.height/3, bg.size.width/3)];
    
    UIView *win = [[UIApplication sharedApplication] keyWindow];
    _mask = [[UIView alloc] initWithFrame:win.bounds];
    _mask.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.2f];
    [win addSubview:_mask];
    
    [win addSubview:self];
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake((win.bounds.size.width - self.bounds.size.width)/2+2.f,
                           (win.bounds.size.height - self.bounds.size.height)/2,
                           self.bounds.size.width, self.bounds.size.height);

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = @[
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2f, 1.2f, 1.f)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.f, 1.f, 1.f)]
                         ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.duration = .1f;
    animation.removedOnCompletion = YES;
    [self.layer addAnimation:animation forKey:@"alert"];
}

- (void)dismiss{
    [_mask removeFromSuperview];
    self.completeBlock = nil;
    [self removeFromSuperview];
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)msg detail:(NSString *)detail buttons:(NSString *)button0Title, ...{
    WhiteAlert *a = [[self class] loadFromNib:@"AlertHUD"];
    a.titleLbl.text = title;
    a.msgLbl.text = msg;
    a.detailLbl.text = a.detailLbl1.text = @"";
    CGRect rect;
    if (detail){
        NSArray *details = [detail componentsSeparatedByString:@"\n"];
        a.detailLbl.text = details[0];
        if ([details count] > 1){
            a.detailLbl1.text = details[1];
        } else {
            rect = a.detailLbl.frame;
            rect.size.height *= 2;
            a.detailLbl.frame = rect;
            a.detailLbl.numberOfLines = 0;
        }
    } else {
        rect = a.msgLbl.frame;
        rect.size.height *= 3;
        a.msgLbl.frame = rect;
        a.msgLbl.numberOfLines = 0;
    }
    
    NSMutableArray *buttonTitles = [[NSMutableArray alloc] init];
    va_list ap;
    va_start(ap, button0Title);
    NSString *buttonTitle = button0Title;
    while (buttonTitle) {
        [buttonTitles addObject:buttonTitle];
        buttonTitle = va_arg(ap, NSString *);
    }
    if ([buttonTitles count] == 1){
        [a.button setTitle:buttonTitles[0] forState:UIControlStateNormal];
        a.button.center = CGPointMake(a.bounds.size.width/2, a.button.center.y);
        a.button1.hidden = YES;
    } else {
        [a.button setTitle:buttonTitles[0] forState:UIControlStateNormal];
        [a.button1 setTitle:buttonTitles[1] forState:UIControlStateNormal];
    }
    [buttonTitles release];
    return a;
}

@end

@implementation BettingAlert

+ (instancetype)alertWithTitle:(NSString *)title
                       lottery:(NSString *)lottname
                        amount:(CGFloat)amount
                   minusAmount:(CGFloat)minusAmount
                         issue:(NSString *)issue
                       toIssue:(NSString *)toIssue
                    issueCount:(NSInteger)issueCount
                        detail:(NSString *)detail
                         limit:(NSString *)limit
                           fee:(CGFloat)fee
                       buttons:(NSString *)button0Title,...{
    
    BettingAlert *a = [[self class] loadFromNib:@"AlertHUD"];
    
    NSMutableArray *buttonTitles = [[[NSMutableArray alloc] init] autorelease];
    va_list ap;
    va_start(ap, button0Title);
    NSString *buttonTitle = button0Title;
    while (buttonTitle) {
        [buttonTitles addObject:buttonTitle];
        buttonTitle = va_arg(ap, NSString *);
    }

    [a initWithTitle:title lottery:lottname amount:amount minusAmount:minusAmount issue:issue toIssue:toIssue issueCount:issueCount detail:detail limit:limit fee:fee buttons:buttonTitles];
    return a;
}

- (id)initWithTitle:(NSString *)title
             lottery:(NSString *)lottname
              amount:(CGFloat)amount
         minusAmount:(CGFloat)minusAmount_
               issue:(NSString *)issue
             toIssue:(NSString *)toIssue
          issueCount:(NSInteger)issueCount
              detail:(NSString *)detail
               limit:(NSString *)limit
                 fee:(CGFloat)fee
             buttons:(NSArray *)buttonTitles{
    
    self.titleLbl.text = title;
    //Buttons
    if ([buttonTitles count] == 1){
        [self.button setTitle:buttonTitles[0] forState:UIControlStateNormal];
        self.button.center = CGPointMake(self.bounds.size.width/2, self.button.center.y);
        self.button1.hidden = YES;
    } else {
        [self.button setTitle:buttonTitles[0] forState:UIControlStateNormal];
        [self.button1 setTitle:buttonTitles[1] forState:UIControlStateNormal];
    }
    
    //Limits
    CGRect rect = _limitView.frame;
    _limitView.clipsToBounds = YES;
    if (limit){
        _limitLbl.text = limit;
        _limitLbl.numberOfLines = 0;
        _limitLbl.textColor = [UIColor grayColor];
        _limitLbl.backgroundColor = [UIColor clearColor];
        CGSize size = CGSizeMake(_limitLbl.frame.size.width, 1000.f);
        size = [limit sizeWithFont:_limitLbl.font constrainedToSize:size];
        rect = _limitLbl.frame;
        rect.size.height = size.height;
        _limitLbl.frame = rect;
        rect = _limitView.frame;
        rect.size.height = _limitLbl.frame.size.height + 10.f;
        _limitView.frame = rect;
        
        [_infoButton setImage:ResImage(@"info.png") forState:UIControlStateNormal];
        _infoButton.center = CGPointMake(_infoButton.center.x, _limitView.bounds.size.height/2);
        _limitLbl.center = CGPointMake(_limitLbl.center.x, _infoButton.center.y);
        
    } else {
        rect.size.height = 0.f;
        _limitView.frame = rect;
    }
    
    rect.origin.x = 10.f;
    rect.size.width = self.titleLbl.frame.size.width;
    
    //Lottery & amount
    rect.origin.y += rect.size.height + 10.f;
    NSString *betAmout = [NSString stringWithFormat:@"<font color=gray>%@</font> 投注金额 <font color=gray>%.2f元</font>",lottname,amount];
    rect.size.height = 20.f;
    RCLabel *lottLbl = [[RCLabel alloc] initWithFrame:rect];
    lottLbl.textAlignment = RTTextAlignmentCenter;
    lottLbl.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:lottLbl];
    [lottLbl setText:betAmout];
    rect.size.height = lottLbl.optimumSize.height;
    lottLbl.frame = rect;
    
    if (minusAmount_ > 0.f){
        rect.origin.y += rect.size.height + 2.f;
        NSString *minusAmount = [NSString stringWithFormat:@"<font color=clear>%@</font> 减少金额 <font color=gray>%.2f元</font>",lottname,minusAmount_];
        NSInteger diff = [@(amount) stringValue].length - [@(minusAmount_) stringValue].length;
        diff = MAX(diff, 0);
        if (diff > 0){
            minusAmount = [minusAmount stringByAppendingString:@"<font color=clear>"];
        }
        for (NSInteger i = 0;  i < diff; i++) { //Fill spaces
            minusAmount = [minusAmount stringByAppendingString:@"0"];
        }
        if (diff > 0){
            minusAmount = [minusAmount stringByAppendingString:@"</font>"];
        }
        RCLabel *minusLbl = [[RCLabel alloc] initWithFrame:rect];
        minusLbl.textAlignment = RTTextAlignmentCenter;
        minusLbl.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:minusLbl];
        [minusLbl setText:minusAmount];
        rect.size.height = minusLbl.optimumSize.height;
        minusLbl.frame = rect;
    }
    
    //Issue
    rect.origin.y += rect.size.height + 10.f;
    if (issueCount > 0 && toIssue != nil){
        NSString *issueStr = [NSString stringWithFormat:@"<font color=gray>追号：</font>从第%@期",issue];
        NSString *toissueStr = [NSString stringWithFormat:@"<font color=clear>追号：</font>至第%@期 <font color=gray>(共%ld期)</font>",toIssue,(long)issueCount];
        RCLabel *issueLbl = [[RCLabel alloc] initWithFrame:rect];
        issueLbl.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:issueLbl];
        [issueLbl setText:issueStr];
        rect.size.height = issueLbl.optimumSize.height;
        issueLbl.frame = rect;

        rect.origin.y += rect.size.height + 2.f;
        RCLabel *toIssueLbl = [[RCLabel alloc] initWithFrame:rect];
        toIssueLbl.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:toIssueLbl];
        [toIssueLbl setText:toissueStr];
        rect.size.height = toIssueLbl.optimumSize.height;
        toIssueLbl.frame = rect;
        
    } else {
        NSString *issueStr = [NSString stringWithFormat:@"<font color=gray>期号：</font>第%@期",issue];
        RCLabel *issueLbl = [[RCLabel alloc] initWithFrame:rect];
        issueLbl.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:issueLbl];
        [issueLbl setText:issueStr];
        rect.size.height = issueLbl.optimumSize.height;
        issueLbl.frame = rect;
    }
    
    //Detail
    rect.origin.y += rect.size.height + 2.f;
    NSString *detailStr = [NSString stringWithFormat:@"<font color=gray>详情：</font>%@",detail];
    RCLabel *detailLbl = [[RCLabel alloc] initWithFrame:rect];
    detailLbl.font = [UIFont systemFontOfSize:14.f];
    [self addSubview:detailLbl];
    [detailLbl setText:detailStr];
    rect.size.height = detailLbl.optimumSize.height;
    detailLbl.frame = rect;

    //Fee
    if (fee > 0.f){
        NSString *feeStr = [NSString stringWithFormat:@"请您尽量避免撤单，撤单将收取手续费%.2f元",fee];
        rect.origin.y += rect.size.height + 10.f;
        UIButton *feebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        feebtn.userInteractionEnabled = NO;
        feebtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
        feebtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [feebtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self addSubview:feebtn];
        rect.size.height = 30.f;
        feebtn.frame = rect;
        feebtn.backgroundColor = [UIColor clearColor];
        [feebtn setTitle:feeStr forState:UIControlStateNormal];
        [feebtn setBackgroundImage:ResImage(@"tips-bg2.png") forState:UIControlStateNormal];
        feebtn.frame = CGRectMake(_feeButton.frame.origin.x, rect.origin.y,
                                      _feeButton.bounds.size.width, _feeButton.bounds.size.height);
        rect = feebtn.frame;
        _feeButton.frame = rect;
        _feeButton.hidden = YES;
    }
    
    //Buttons
    rect.origin.y += rect.size.height + 10.f;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, rect.origin.y + self.button.frame.size.height + 20.f);
    
    CGRect tmpRect = self.button.frame;
    tmpRect.origin.y = rect.origin.y;
    self.button.frame = tmpRect;
    tmpRect = self.button1.frame;
    tmpRect.origin.y = rect.origin.y;
    self.button1.frame = tmpRect;
    
    return self;
}

@end


@implementation OverMultipleAlert

+ (instancetype)alertWithTitle:(NSString *)title msg:(NSString *)msg details:(NSArray *)details button:(NSString *)buttonTitle{
    OverMultipleAlert *a = [[self class] loadFromNib:@"AlertHUD"];
    [a initWithTitle:title msg:msg details:details button:buttonTitle];
    return a;
}

- (id)initWithTitle:(NSString *)title msg:(NSString *)msg details:(NSArray *)details button:(NSString *)buttonTitle{
    self.titleLbl.text = title;
    self.msgLbl.text = msg;
    CGRect rect = self.msgLbl.frame;
    rect.origin.y += rect.size.height + 10.f;
    for (NSInteger i = 0; i < details.count; i++) {
        rect.size.height = 20.f;
        NSDictionary *d = details[i];
        UILabel *left = [[UILabel alloc] initWithFrame:rect];
        UILabel *right = [[UILabel alloc] initWithFrame:rect];
        right.textAlignment = NSTextAlignmentRight;
        left.font = right.font = [UIFont systemFontOfSize:14.f];
        left.backgroundColor = right.backgroundColor = [UIColor clearColor];
        right.textColor = [UIColor grayColor];
        [self addSubview:right];
        [self addSubview:left];
        NSInteger max = [d intForKey:@"multiple"];
        NSString *numbers = [d stringForKey:@"betDetail"];
        left.text = [NSString stringWithFormat:@"[%@]%@",[d stringForKey:@"betMethod"],numbers];
        right.text = [NSString stringWithFormat:@"最多投%ld倍",(long)max];
        rect.origin.y += rect.size.height;
    }
    rect.origin.y += 10.f;
    self.button1.hidden = YES;
    self.button.frame = CGRectMake((self.bounds.size.width-self.button.frame.size.width)/2, rect.origin.y, self.button.frame.size.width, self.button.frame.size.height);
    [self.button setTitle:buttonTitle forState:UIControlStateNormal];
    rect.origin.y += self.button.frame.size.height + 20.f;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, rect.origin.y);
    return self;
}

@end


@implementation HighChaseNumAlert

@end
@implementation IssueChangeAlert
@end