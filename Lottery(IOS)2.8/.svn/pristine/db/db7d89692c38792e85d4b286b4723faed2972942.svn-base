//
//  BetCell+JSKS.m
//  Caipiao
//
//  Created by GroupRich on 15/6/23.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import "BetCell+JSKS.h"
#define BALL_TAG(number) (number+100)

@implementation BetCell (JSKS)

@end

@implementation JSKSBetView

- (id)initWithFrame:(CGRect)frame item:(BetItem *)item
{
    self = [super initWithFrame:frame item:item];
    if (self) {
        self.ballContainer.image = nil;
    }
    return self;
}
@end

@implementation JSKSWordsBetView

- (id)initWithFrame:(CGRect)frame item:(BetItem *)item{
    self = [super initWithFrame:frame];
    if (self){
        // Initialization code
        item.attachedBetView = self;
        self.betItem = item;
        
        float mar = 7.5f, ymar = 4.f;
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, mar, ymar)];
        bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        bgView.layer.cornerRadius = 2.f;
        //        bgView.image = ResImage(@"bet-unit-bg.png");
        bgView.clipsToBounds = YES;
        bgView.userInteractionEnabled = YES;
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        [bgView release];
        
        self.ballContainer = bgView;
        
        UILabel *weightLbl = [[UILabel alloc] initWithFrame:CGRectMake(3.f, 7.f, 40.f, 20.f)];
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
        float margin = (self.ballContainer.bounds.size.width - offsetX*2 - w*3)/(3+1);
        float x = offsetX+margin, y = weightMenu.frame.origin.y + weightMenu.frame.size.height+10;
        
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
            if ((x + w) >= self.ballContainer.bounds.size.width){
                x = offsetX+margin;
                y += mar + h;
            }
            
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

@implementation JSKSImageBetView

- (id)initWithFrame:(CGRect)frame item:(BetItem *)item{
    self = [super initWithFrame:frame];
    if (self){
        // Initialization code
        item.attachedBetView = self;
        self.betItem = item;
        
        float mar = 7.5f, ymar = 4.f;
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, mar, ymar)];
        bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        bgView.layer.cornerRadius = 2.f;
        //        bgView.image = ResImage(@"bet-unit-bg.png");
        bgView.clipsToBounds = YES;
        bgView.userInteractionEnabled = YES;
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        [bgView release];
        
        self.ballContainer = bgView;
        
        UILabel *weightLbl = [[UILabel alloc] initWithFrame:CGRectMake(3.f, 7.f, 40.f, 20.f)];
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
        float  w = first.frameSize.width, h = first.frameSize.height;
        float margin = (self.ballContainer.bounds.size.width  - w)/(2);
        float x = margin, y = weightMenu.frame.origin.y + weightMenu.frame.size.height+50;
        
        for (int i = 0; i < [item.ballItems count]; i++) {
            BallItem *ballItem = [item.ballItems objectAtIndex:i];
            Ball *ball = [[Ball alloc] initWithFrame:CGRectMake(x, y, w, h) ballItem:ballItem];
            ball.tag = BALL_TAG(i);
            ball.normalImage = ResImage(ballItem.text);
            ball.selectedImage = ResImage(ballItem.value);
            ball.textLbl.text = @"";
            ball.selected = ballItem.selected;
            ball.shouldShowIndicator = NO;
            ball.delegate = self;
            [self.ballContainer addSubview:ball];
            [_ballList addObject:ball];
            [ball release];
            x += (w + margin);
            if ((x + w) >= self.ballContainer.bounds.size.width){
                x = margin;
                y += mar + h;
            }
            
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

@implementation JSKSInfoBetView

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
        
        UILabel *weightLbl = [[UILabel alloc] initWithFrame:CGRectMake(3.f, 7.f, 40.f, 20.f)];
        weightLbl.font = [UIFont boldSystemFontOfSize:16];
        weightLbl.textAlignment = NSTextAlignmentCenter;
        weightLbl.textColor = Color(@"BetWeightColor");
        weightLbl.adjustsFontSizeToFitWidth = YES;
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
            
            UILabel *textL = [[UILabel alloc] initWithFrame:CGRectMake(x+3,y+w+5,w+10, 15)];
            textL.backgroundColor = [UIColor clearColor];
            switch (ballItem.text.integerValue) {
                case 3:
                case 18:
                    textL.text = @"奖金360";
                    break;
                case 4:
                case 17:
                    textL.text = @"奖金120";
                    break;
                case 5:
                case 16:
                    textL.text = @"奖金60";
                    break;
                case 6:
                case 15:
                    textL.text = @"奖金36";
                    break;
                case 7:
                case 14:
                    textL.text = @"奖金24";
                    break;
                case 13:
                case 8:
                    textL.text = @"奖金17";
                    break;
                case 9:
                case 12:
                    textL.text = @"奖金14";
                    break;
                case 10:
                case 11:
                    textL.text = @"奖金13";
                    break;
                default:
                    break;
            }
            textL.textAlignment = NSTextAlignmentCenter;
            textL.textColor = [UIColor lightGrayColor];
            textL.font = [UIFont systemFontOfSize:10.0f];
            [self addSubview:textL];
            
            x += (w + mar);
            if ((x + w) >= self.ballContainer.bounds.size.width){
                x = 15.f;
                y += mar + w +15;
            }
        }
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //Weight Menu
    self.weightMenu.enabled = YES;
    self.weightMenu.userInteractionEnabled = YES;
}
@end


@implementation JSKSSwitchView

- (id)initWithFrame:(CGRect)frame item:(NSArray*)items withTitles:(NSArray*)titles
{
    self = [super initWithFrame:frame];
   
    if (self) {
        
        [self setUpSubView];
        
        self.items = items;
        float w =40, x = 25.f, y = 12.f,h=20.f;
        UIButton *btn = nil;
        self.weightBtns  = [NSMutableArray array];
        for (NSInteger i=0; i<items.count; i++)
        {
            UIButton *weightBtn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, w, h)];
            weightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            weightBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [weightBtn setTitle:titles[i] forState:UIControlStateNormal];
            [weightBtn setTitleColor:Color(@"BetWeightColor") forState:UIControlStateNormal];
            weightBtn.tag = i;
            [weightBtn addTarget:self action:@selector(switchItem:) forControlEvents:UIControlEventTouchUpInside];
            weightBtn.backgroundColor = [UIColor clearColor];
            weightBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
            [self addSubview:weightBtn];
            [self.weightBtns addObject:weightBtn];
            [weightBtn release];
            x +=w+10;
            if (i==0) {
                btn = weightBtn;
            }
        }
        
        NSMutableArray *bvs = [NSMutableArray array];

        for (MethodMenuItem *model in _items)
        {
            JSKSBetScrollView *betView = [[JSKSBetScrollView alloc]initWithFrame:CGRectMake(0, 30, self.bounds.size.width, self.bounds.size.height-30)];
            betView.bgView.image=nil;
            CGFloat h = 0.f, w = self.bounds.size.width;
            for (BetItem*item in model.betItems) {
                BetView *bv= nil;
                h = [BetView heightForBetItem:item];
                bv = [[[JSKSBetView alloc]initWithFrame:CGRectMake(0, 0, w, h)  item:item]autorelease];
                bv.betItem=item;
                [betView addBetView:bv];
            }
            
            [self addSubview:betView];
            betView.hidden=YES;
            [bvs addObject:betView];
            self.betViews=bvs;
        }
     
        [self switchItem:btn];
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
-(void)switchItem:(UIButton*)btn
{
    [_weightBtns enumerateObjectsUsingBlock:^(UIButton* obj, NSUInteger idx, BOOL *stop) {
        [obj setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }];
    [btn setTitleColor:Color(@"BetWeightColor") forState:UIControlStateNormal];

    [_betViews enumerateObjectsUsingBlock:^(UIView* obj, NSUInteger idx, BOOL *stop) {
        if (idx==btn.tag) {
            obj.hidden=NO;
        }else
        {
            obj.hidden=YES;
        }
    }];
    self.mmItem = self.items[btn.tag];
    if (_switchBlock) {
        _switchBlock(self.mmItem);
    }
}
-(void)dealloc
{
    self.items=nil;
    self.mmItem=nil;
    self.betViews=nil;
    self.betViews=nil;
    self.switchBlock=nil;
    self.weightBtns=nil;
    [super dealloc];
}
@end
