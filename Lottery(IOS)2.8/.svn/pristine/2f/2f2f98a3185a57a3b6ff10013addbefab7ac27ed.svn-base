//
//  BetCell.m
//  Caipiao
//
//  Created by danal on 13-1-5.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BetCell.h"
#import <QuartzCore/QuartzCore.h>

#define BALL_TAG(number) (number+100)

#pragma mark - BetCell

@implementation BetCell
@synthesize betItems = _betItems;

+ (float)height{
    return 140.f;
}

+ (float)heightForBetItems:(NSArray *)betItems{
//    float h = [self height] * [betItems count];
    float h = 0;
    for (BetItem *one in betItems){
        h += [BetView heightForBetItem:one];
    }
    return h;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
#ifdef __IPHONE_7_0
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
#endif
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //All items in one cell
    //Removes
    for (UIView *view in self.contentView.subviews){
        if ([view isKindOfClass:[BetView class]]) {
            [view removeFromSuperview];
        }
    }
    //Adds
    int zorder = 10e5;
    float mar = 0.f, h = [BetView height], w = self.bounds.size.width, x = 0, y = mar;
    for (BetItem *item in self.betItems){
        h = [BetView heightForBetItem:item];
        BetView *bv = nil;
        if (item.type == kBetItemTypeWords){
            bv = [[[WordsBetView alloc] initWithFrame:CGRectMake(x, y, w, h) item:item] autorelease];
        } else {
            bv = [[[BetView alloc] initWithFrame:CGRectMake(x, y, w, h) item:item] autorelease];
        }
        bv.betItem = item;
        [self.contentView insertSubview:bv atIndex:zorder--];
        y += (h + mar);
    }
    
}

@end

#pragma mark - BetView

@interface BetView ()

@end

@implementation BetView
@synthesize weightMenu = _weightMenu;
@synthesize betItem = _betItem;


- (void)dealloc{
    [_weightMenu release];   _weightMenu = nil;
    [_betItem release];     _betItem = nil;
    [_ballList release];    _ballList = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame item:(BetItem *)item{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        item.attachedBetView = self;
        self.betItem = item;
        
        float mar = 7.5f, ymar = 4.f;
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, mar, ymar)];
        bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        bgView.layer.cornerRadius = 2.f;
        bgView.image = [ResImage(@"bet-unit-bg.png") resizableImageWithCapInsets:UIEdgeInsetsMake(40, 5, 5, 5)];
        bgView.clipsToBounds = YES;
        bgView.userInteractionEnabled = YES;
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        [bgView release];
        
        self.ballContainer = bgView;

        UILabel *weightLbl = [[UILabel alloc] initWithFrame:CGRectMake(3.f, 7.f, 50.f, 20.f)];
        weightLbl.font = [UIFont boldSystemFontOfSize:16];
        weightLbl.textAlignment = NSTextAlignmentCenter;
        weightLbl.textColor = Color(@"BetWeightColor");
//        weightLbl.adjustsFontSizeToFitWidth = YES;
        [self.ballContainer addSubview:weightLbl];
        _weightLbl = weightLbl;
        [weightLbl release];
        
        WeightMenu *weightMenu = [[WeightMenu alloc] initWithFrame:CGRectMake(0,3, 30.f, 30.f) weight:@"" parentView:self.ballContainer];
        weightMenu.delegate = self;
        weightMenu.layer.cornerRadius = 5.f;
        weightMenu.clipsToBounds = YES;
        [self.ballContainer addSubview:weightMenu];
        self.weightMenu = weightMenu;
        [weightMenu release];
//        weightMenu.hidden = YES;
//        weightMenu.frame = CGRectMake(0, 0, 0, 10.f);

        _ballList = [[NSMutableArray alloc] init];
        mar = 11;
        float w = 0, x = 15.f, y = weightMenu.frame.origin.y + weightMenu.frame.size.height+10;
        for (int i = 0; i < [item.ballItems count]; i++) {
            BallItem *ballItem = [item.ballItems objectAtIndex:i];
            w = ballItem.frameSize.width;
//            if (item.endBall > 9) w = 32.f;
            Ball *ball = [[Ball alloc] initWithFrame:CGRectMake(x, y, w, w) ballItem:ballItem];
            ball.tag = BALL_TAG(i);
            ball.selected = ballItem.selected;
            ball.delegate = self;
            [self.ballContainer addSubview:ball];
            [_ballList addObject:ball];
            [ball release];
            
            x += (w + mar);
            if ((x + w) >= self.ballContainer.bounds.size.width){
                x = 15.f;
                y += mar + w;
            }
        }
        
    }
    return self;
}

- (void)selectBall:(NSString *)numberText{
    for (Ball *ball in self.ballContainer.subviews){
        if ([ball isKindOfClass:[Ball class]] && [ball.ballItem.value isEqualToString:numberText]){
            [ball setSelected:YES];
        }
    }
}

- (void)deselectBall:(NSString *)numberText{
    for (Ball *ball in self.ballContainer.subviews){
        if ([ball isKindOfClass:[Ball class]] && [ball.ballItem.value isEqualToString:numberText]){
            [ball setSelected:NO];
        }
    }
}

- (void)reload{
    for (int i = 0; i < [_betItem.ballItems count]; i++) {
        BallItem *ballItem = [_betItem.ballItems objectAtIndex:i];
        Ball *ball = [_ballList objectAtIndex:i];
        ball.selected = ballItem.selected;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //Weight Menu
    self.weightMenu.weight = self.betItem.weight;
    self.weightMenu.enabled = !self.betItem.disableWeightOption;
    self.weightMenu.userInteractionEnabled = !self.betItem.disableWeightOption;
    self.weightMenu.hidden = self.betItem.disableWeightOption;
    _weightLbl.hidden = !self.betItem.disableWeightOption;
    _weightLbl.text = self.betItem.weight;
}


#pragma mark --ballClick

- (void)ballDidClick:(Ball *)ball selected:(BOOL)selected{

    if (selected) {
        [self.betItem manuallySelectNumber:ball.ballItem.value];
    } else {
        [self.betItem manuallyDeselectNumber:ball.ballItem.value];
    }
}

#pragma mark --WeightMenuDelegate

- (void)weightMenuDidOptionButtonClick:(NSInteger)buttonTag{
    Echo(@"%ld",(long)buttonTag);
    switch (buttonTag) {
        case kWMTagAll:
            [self.betItem selectAll];
            break;
        case kWMTagBig:
            [self.betItem selectBig];
            break;
        case kWMTagSmall:
            [self.betItem selectSmall];
            break;
        case kWMTagOdd:
            [self.betItem selectOdd];
            break;
        case kWMTagEven:
            [self.betItem selectEven];
            break;
        case kWMTagClear:
            [self.betItem reset];
            break;
        default:
            Echo(@"button tag %ld not found",(long)buttonTag);
            break;
    }
    int number = self.betItem.startBall;
    for (Ball *ball in _ballList){
        ball.selected = [_betItem numberSelected:number];
        number++;
    }

}

- (void)weightMenuDidWeightButtonClick:(WeightMenu *)menu{
    [BetView removeMask];
/*
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    CGRect frame = menu.frame;
    frame = [menu convertRect:frame toView:win];
    frame.origin.x = 0;
    frame.size.height += 90.f;
    
    if (menu.opened) {
        CGRect rect = win.bounds;
        UIView *topView = [[UIView alloc] initWithFrame:rect];
        topView.tag = 0x1901;
        topView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.1f];
        topView.layer.anchorPoint = CGPointMake(0, 1);
        [win addSubview:topView];
        [topView release];
        topView.layer.position = frame.origin;
        
        UIView *bottomView = [[UIView alloc] initWithFrame:rect];
        bottomView.tag = 0x1902;
        bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.1f];
        bottomView.layer.anchorPoint = CGPointMake(0, 0);
        [win addSubview:bottomView];
        [bottomView release];
        bottomView.layer.position = CGPointMake(0, frame.origin.y + frame.size.height);
        
    }
 */
}

+ (void)removeMask{
/*
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    [[win viewWithTag:0x1901] removeFromSuperview];
    [[win viewWithTag:0x1902] removeFromSuperview];
 */
}

+ (float)height{
    return 140.f;
}

+ (float)heightForBetItem:(BetItem *)item{

    float h;
    float mar = 10.f;
    float w = kStandardBallWidth, x = 60.f, y = 10.f;   //30.f;
//    if (item.endBall > 9) w = 32.f;
   
    for (int i = 0; i < [item.ballItems count]; i++) {
        x += (w + mar);
        if ((x + w) >= 300){
            x = 60.f;
            y += mar + w;
        }
    }
    //x == 60说明最后一排刚好排满
    h = x > 60.f ? y +w +mar*2 : y + mar;
    
    NSInteger rowCount = [item.ballItems count]/6+ ([item.ballItems count]%6?1:0);
    CGFloat height = mar + (mar+w)*rowCount+mar+35;
    return MAX(height, h);
}

@end


#pragma mark - WordsBetView
@implementation WordsBetView

- (id)initWithFrame:(CGRect)frame item:(BetItem *)item{
    self = [super initWithFrame:frame];
    if (self){
        // Initialization code
        item.attachedBetView = self;
        self.betItem = item;
        
        float mar = 10.f, ymar = 4.f;
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, mar, ymar)];
        bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        bgView.layer.cornerRadius = 5.f;
        bgView.image = ResImage(@"bet-unit-bg.png");
        bgView.clipsToBounds = YES;
        bgView.userInteractionEnabled = YES;
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        [bgView release];
        
        self.ballContainer = bgView;
        
        UILabel *weightLbl = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 20.f, 40.f, 20.f)];
        weightLbl.font = [UIFont systemFontOfSize:16.f];
        weightLbl.textAlignment = NSTextAlignmentCenter;
        weightLbl.textColor = [UIColor darkGrayColor];
        weightLbl.adjustsFontSizeToFitWidth = YES;
        [self.ballContainer addSubview:weightLbl];
        _weightLbl = weightLbl;
        [weightLbl release];
        
        WeightMenu *weightMenu = [[WeightMenu alloc] initWithFrame:CGRectMake(0, 3, 30.f, 30.f) weight:@"" parentView:self.ballContainer];
        weightMenu.delegate = self;
        weightMenu.layer.cornerRadius = 5.f;
        weightMenu.clipsToBounds = YES;
        [self.ballContainer addSubview:weightMenu];
        self.weightMenu = weightMenu;
        [weightMenu release];
//        weightMenu.hidden = YES;
//        weightMenu.frame = CGRectMake(0, 0, 0, 10.f);
        
        _ballList = [[NSMutableArray alloc] init];
        BallItem *first = [item.ballItems objectAtIndex:0];
        float offsetX = 20.f, w = first.frameSize.width, h = first.frameSize.height;
        float margin = (self.ballContainer.bounds.size.width - offsetX*2 - w*item.ballItems.count)/(item.ballItems.count+1);
        float x = offsetX+margin, y = (self.ballContainer.bounds.size.height - h)/2;

        for (int i = 0; i < [item.ballItems count]; i++) {
            BallItem *ballItem = [item.ballItems objectAtIndex:i];
            Ball *ball = [[Ball alloc] initWithFrame:CGRectMake(x, y, w, h) ballItem:ballItem];
            ball.tag = BALL_TAG(i);
            ball.textLbl.font = [UIFont boldSystemFontOfSize:18.f];
            ball.selected = ballItem.selected;
            ball.shouldShowIndicator = NO;
            ball.delegate = self;
            [self.ballContainer addSubview:ball];
            [_ballList addObject:ball];
            [ball release];
            x += (w + margin);
        }

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //Weight Menu
    self.weightMenu.enabled = NO;
    self.weightMenu.userInteractionEnabled = NO;
}

@end

#pragma mark - SSQBetView

@implementation SSQBetView

- (void)dealloc
{
    [self.betItem removeObserver:self forKeyPath:@"selectedBallCount"];
    [_numLbl release];
    [_dropBox release];
    [super dealloc];
}

+ (float)heightForBetItem:(BetItem *)item{
    float h;
    float mar = 10.f;
    float w = kStandardBallWidth, x = 60.f, y = 20.f;
//    if (item.endBall > 9) w = 32.f;
    for (int i = 0; i < [item.ballItems count]; i++) {
        x += (w + mar);
        if ((x + w) >= 300){
            x = 60.f;
            y += mar/2 + w;
        }
    }
    //x == 60说明最后一排刚好排满
    h = x > 60.f ? y +w +mar*2 : y + mar;
    return h;
}

- (id)initWithFrame:(CGRect)frame item:(BetItem *)item{
    self = [super initWithFrame:frame];
    if (self){
        
        item.attachedBetView = self;
        self.betItem = item;
//        self.weightMenu.hidden = YES;

        float mar = 10.f, ymar = 4.f;
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, mar, ymar)];
        bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        bgView.layer.cornerRadius = 5.f;
        bgView.image = ResImage(@"bet-unit-bg_shuang.png");
        bgView.clipsToBounds = YES;
        bgView.userInteractionEnabled = YES;
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        [bgView release];
        
//        UIView *view = [[UIView alloc] initWithFrame:bgView.frame];
//        view.autoresizingMask = bgView.autoresizingMask;
//        view.backgroundColor = bgView.backgroundColor;
//        [self addSubview:view];
//        [view release];
//        self.ballContainer = view;
        self.ballContainer = bgView;
        
        UILabel *weightLbl = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 20.f, 40.f, 20.f)];
        weightLbl.font = [UIFont systemFontOfSize:16.f];
        weightLbl.textAlignment = NSTextAlignmentCenter;
        weightLbl.textColor = Color(@"BetWeightColor");
        weightLbl.adjustsFontSizeToFitWidth = YES;
        [self.ballContainer addSubview:weightLbl];
        _weightLbl = weightLbl;
        [weightLbl release];
        
        _numLbl = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, 111, 20)];
        _numLbl.textColor = [UIColor whiteColor];
        _numLbl.backgroundColor = [UIColor clearColor];
        _numLbl.font = [UIFont boldSystemFontOfSize:12.f];
        _numLbl.text = [NSString stringWithFormat:@"%@区已选%d个", self.betItem.weight, self.betItem.count];
        [self addSubview:_numLbl];
        _numLbl.frame = CGRectMake(30, 15, 0, 0);
        
        SSQBetView *self_ = self;
        _dropBox = [[YellowDropBox alloc] initWithFrame:CGRectMake(200, 15, 80, 20)
                                            startNumber:self.betItem.startRandomNum
                                              endNumber:self.betItem.endRandomNum];
        [_dropBox setSelectNumberBlock:^(YellowDropBox *dropBox, int number) {
            [self_.betItem randomN:number];
            [self_.betItem onChanges];
            self_.numLbl.text = [NSString stringWithFormat:@"%@区已选%d个", self.betItem.weight, self.betItem.count];
        }];
        [self addSubview:_dropBox];
        _dropBox.hidden = YES;
        
        [self.betItem addObserver:self forKeyPath:@"selectedBallCount" options:NSKeyValueObservingOptionNew context:@"selectedBallCount"];
        
        mar = 12.f;
        _ballList = [[NSMutableArray alloc] init];
        float w = 0, x = 60.f, y = _numLbl.frame.origin.y + _numLbl.frame.size.height + 5;
        for (int i = 0; i < [item.ballItems count]; i++) {
            BallItem *ballItem = [item.ballItems objectAtIndex:i];
            w = ballItem.frameSize.width;
//            if (item.endBall > 9) w = 32.f;
            
            Ball *ball = nil;
            if (ballItem.style == kBallStyleBlue) {
                ball = [[BlueBall alloc] initWithFrame:CGRectMake(x, y, w, w) ballItem:ballItem];
            }else {
                ball = [[RedBall alloc] initWithFrame:CGRectMake(x, y, w, w) ballItem:ballItem];
            }

            ball.tag = BALL_TAG(i);
            ball.selected = ballItem.selected;
            ball.shouldShowIndicator = NO;
            ball.delegate = self;
            [self.ballContainer addSubview:ball];
            [_ballList addObject:ball];
            [ball release];
            
            x += (w + mar);
            if ((x + w) >= self.ballContainer.bounds.size.width){
                x = 60.f;
                y += mar/2 + w;
            }
        }
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _weightLbl.hidden = NO;

}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"selectedBallCount"]){
        int count = [[change objectForKey:@"new"] intValue];
        _numLbl.text = [NSString stringWithFormat:@"%@区已选%d个", self.betItem.weight, count];
    }
}

#pragma mark --ballClick

- (void)ballDidClick:(Ball *)ball selected:(BOOL)selected{
    
    if (selected) {
        [self.betItem manuallySelectNumber:ball.ballItem.value];
    } else {
        [self.betItem manuallyDeselectNumber:ball.ballItem.value];
    }
    _numLbl.text = [NSString stringWithFormat:@"%@区已选%d个", self.betItem.weight, self.betItem.count];
}

@end



#pragma mark - SSQBetCell

@implementation SSQBetCell

+ (float)height{
    return 140.f;
}

+ (float)heightForBetItems:(NSArray *)betItems{
    //    float h = [self height] * [betItems count];
    float h = 0;
    for (BetItem *one in betItems){
        h += [BetView heightForBetItem:one];
    }
    return h;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
#ifdef __IPHONE_7_0
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
#endif
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //All items in one cell
    //Removes
    for (UIView *view in self.contentView.subviews){
        if ([view isKindOfClass:[SSQBetView class]]) {
            [view removeFromSuperview];
        }
    }
    //Adds
    int zorder = 10e5;
    float mar = 0.f, h = [SSQBetView height], w = self.bounds.size.width, x = 0, y = mar;
    for (BetItem *item in self.betItems){
        item.disableWeightOption = YES;
        h = [SSQBetView heightForBetItem:item];
        SSQBetView *bv = nil;
        bv = [[[SSQBetView alloc] initWithFrame:CGRectMake(x, y, w, h) item:item] autorelease];
        bv.betItem = item;
        //红球胆码区机选暂时隐藏
        if ([item.weight isEqualToString:@"红球胆码"]) {
            bv.dropBox.hidden = YES;
        }
        [self.contentView insertSubview:bv atIndex:zorder--];
        y += (h + mar);
    }
}

@end

#pragma mark - BetScrollView
@implementation BetScrollView

- (void)awakeFromNib{
    _bottomY = 0.f;
}

- (void)addBetView:(BetView *)betView{
    float mar = 0.f, h = betView.bounds.size.height, w = self.bounds.size.width, x = 0, y = _bottomY;
    /*
    BetItem *item = betView.betItem;
    h = [BetView heightForBetItem:item];
    BetView *bv = nil;
    if (item.type == kBetItemTypeWords){
        bv = [[WordsBetView alloc] initWithFrame:CGRectMake(x, y, w, h) item:item];
    } else {
        bv = [[BetView alloc] initWithFrame:CGRectMake(x, y, w, h) item:item];
    }
    bv.betItem = item;
    [self addSubview:bv];
    [bv release];
     */
    betView.frame = CGRectMake(x, y, w, h);
    [self addSubview:betView];
    y += (h + mar);
    _bottomY = y;
    
    self.contentSize = CGSizeMake(self.bounds.size.width, _bottomY);

}

- (void)clear{
    for (UIView *v in self.subviews){
        if ([v isKindOfClass:[BetView class]]){
            [v removeFromSuperview];
        }
    }
    _bottomY = 0.f;
}

- (void)reload{
    for (UIView *v in self.subviews){
        if ([v isKindOfClass:[BetView class]]){
            [(BetView *)v reload];
        }
    }
}

@end

@interface JSKSBetScrollView ()
@end
@implementation JSKSBetScrollView
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setUpSubView];

}
-(instancetype)initWithFrame:(CGRect)frame
{
    self  =[super initWithFrame:frame];
    if (self) {
        [self setUpSubView];
    }
    return self;
}
-(void)setUpSubView
{
    if (_bgView==nil) {
        float mar = 7.5f, ymar = 4.f;
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, mar, ymar)];
        bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        bgView.layer.cornerRadius = 2.f;
        bgView.image = [ResImage(@"js_bg1.png") resizableImageWithCapInsets:UIEdgeInsetsMake(40, 5, 5, 5)];
        bgView.clipsToBounds = YES;
        bgView.userInteractionEnabled = YES;
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        self.bgView = bgView;
        [bgView release];
    }
}
@end