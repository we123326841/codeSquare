//
//  LotteryCustomController.m
//  Caipiao
//
//  Created by danal-rich on 7/17/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "LotteryCustomController.h"
#import "CD.h"


@interface LotteryCustomController ()

@end

@implementation LotteryCustomController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"自定义彩种";
    self.view.backgroundColor = Color(@"LotCustomBGColor");
    _textLbl.textColor = Color(@"LotCustomTextColor");
    
    UIButton *close = [UIButton barButtonWithTitle:@"关闭"];
    [close addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self setLeftBarButton:close];
    
    UIButton *done = [UIButton barButtonWithTitle:@"完成"];
    [done addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarButton:done];
    
    __block LotteryCustomController *self_ = self;
    
    NSMutableArray *hots = [CDHotLottery allSorted];
    LotteryNorthView *nv = (LotteryNorthView *)_northView;
    for (CDHotLottery *hot in hots){
        [nv addLottery:[hot toLottery]];
    }
    [nv update];
    [nv setOnLotteryGridClick:^BOOL(CDLottery *lot) {
        return [self_ onNorthLotteryGridClick:lot];
    }];
    
    LotterySouthView *sv = (LotterySouthView *)_southView;
    CGFloat y = _northView.frame.size.height + 30.f;
    sv.frame = CGRectMake(0, y, 320.f, self.view.frame.size.height - y);
//    sv.backgroundColor = self.view.backgroundColor;
    [[CDLottery allEnabledButHot] enumerateObjectsUsingBlock:^(CDLottery* obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@--%@",obj.name,obj.isNewLottery);

    }];
    [sv addLotterys:[CDLottery allEnabledButHot]];
    [sv update];
    [sv setOnLotteryGridClick:^BOOL(CDLottery *lot) {
        return [self_ onSouthLotteryGridClick:lot];
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)done{
    //Clear old hots and fill with new hots
    [CDHotLottery deleteAll];
    for (LotteryCircle *grid in _northView.grids){
        [CDHotLottery addFromLottery:grid.userData];
    }
    MSNotificationCenterPost(kNotificationHotLotterysUpdates);
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)onNorthLotteryGridClick:(CDLottery *)lot{
    [_southView addLottery:lot];
    return YES;
}

- (BOOL)onSouthLotteryGridClick:(CDLottery *)lot{
    if (_northView.lotteryCount < 6){
        [_northView addLottery:lot];
        return YES;
    }
    return NO;
}


@end



@implementation LotteryNorthView

- (void)dealloc{
    self.onLotteryGridClick = nil;
    self.grids = nil;
    [super dealloc];
}

- (void)awakeFromNib{
    _grids = [[NSMutableArray alloc] init];
    _rowCount = 2, _colCount = 3;
    _itemSize = CGSizeMake(106.f, 80.f); //CGSizeMake( 68.f, 68.f);
    _itemMargin = CGPointMake((self.bounds.size.width - _colCount*_itemSize.width)/(_colCount+1),
                              (self.bounds.size.height - _rowCount*_itemSize.height)/(_rowCount+1));
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self addGestureRecognizer:longPress];
    [longPress release];
}

- (CGRect)itemFrameAtRow:(NSInteger)row col:(NSInteger)col{
    return CGRectMake(_itemMargin.x+(_itemMargin.x+_itemSize.width)*col,
                      _itemMargin.y +(_itemMargin.y+_itemSize.height)*row,
                      _itemSize.width, _itemSize.height);
}

- (CGRect)itemFrameWithIndex:(NSInteger)index{
    NSInteger col = index%_colCount, row = index/_colCount;
    return [self itemFrameAtRow:row col:col];
}

- (LotteryCircle *)gridButtonAtIndex:(NSInteger)index{
    LotteryCircle *butt = nil;
    if (index < _grids.count){  //reuse a exist one
        butt = [_grids objectAtIndex:index];
    } else {                    //create a new one
        butt = [LotteryCircle buttonWithType:UIButtonTypeCustom];
        butt.layer.cornerRadius = butt.frame.size.width/2;
        [butt addTarget:self action:@selector(gridClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:butt];
        [_grids addObject:butt];
    }
    butt.frame = [self itemFrameWithIndex:index];
    return butt;
}

- (void)update{
    NSInteger i = 0;
    for (i = 0; i < _grids.count; i++) {
        LotteryCircle *grid = [self gridButtonAtIndex:i];
        grid.tag = i;
        CDLottery *lot = (CDLottery *)grid.userData;
        grid.isNewLottery = lot.isNewLottery.boolValue;
        [grid setImage:ResImage(lot.logoHot) forState:UIControlStateNormal];
    }
    //Remove tails
    for (NSInteger j = i; j < _grids.count; j++) {
        LotteryCircle *grid = [self gridButtonAtIndex:i];
        [grid removeFromSuperview];
    }
    [_grids removeObjectsInRange:NSMakeRange(i, _grids.count-i)];
    
}

- (NSInteger)lotteryCount{
    return _grids.count;
}

- (void)addLottery:(CDLottery *)lot{
    if (!_grids) _grids = [[NSMutableArray alloc] init];
    if (!lot) NSLog(@"lot cannot be null");
    LotteryCircle *grid = [self gridButtonAtIndex:_grids.count];
    grid.style = kLotteryCircleStyleDelete;
    grid.isNewLottery=lot.isNewLottery.boolValue;
    grid.userData = lot;
    [self update];
}

- (void)addLotterys:(NSArray *)lots{
    for (id lot in lots){
        [self addLottery:lot];
    }
}

- (void)gridClick:(LotteryCircle *)sender{
    if (_onLotteryGridClick){
        CDLottery *lot = sender.userData;
        _onLotteryGridClick(lot);
        
        [sender removeFromSuperview];
        [_grids removeObject:sender];
        
        [self update];
        
    }
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)g{

    CGPoint loc = [g locationInView:self];
  
    switch (g.state) {
        case UIGestureRecognizerStateBegan:
        {
            for (LotteryCircle *item in _grids) {
                if (CGRectContainsPoint(item.frame, loc)){
                    [item removeFromSuperview];
                    [self addSubview:item];
                    _movingItem = item;
                    break;
                }
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            _movingItem.frame = [self itemFrameWithIndex:_movingItem.tag];
            _movingItem = nil;
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            _movingItem.frame = [self itemFrameWithIndex:_movingItem.tag];
            _movingItem = nil;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (_movingItem){
                _movingItem.frame = CGRectMake(loc.x-_itemSize.width/2, loc.y-_itemSize.height/2,
                                               _itemSize.width, _itemSize.height);
                
                //Resort
                _tick += 0.01f;
                for (LotteryCircle *item in _grids) {
                    if (CGRectIntersectsRect(item.frame, _movingItem.frame)){
                        //If at left, resort them
                        if (_movingItem.frame.origin.x < item.frame.origin.x &&
                                fabsf(_movingItem.frame.origin.x - item.frame.origin.x) < item.frame.size.width/2){

                                if (_tick < 0.2f) break;
                                else _tick = 0.f;
                            
                                NSInteger destTag = item.tag;
                                _movingItem.tag = destTag;
                                
                                //Resort with the tag
                                [_grids sortUsingComparator:^NSComparisonResult(LotteryCircle *obj1, LotteryCircle *obj2) {
                                    if (obj1.tag < obj2.tag){
                                        return NSOrderedAscending;
                                    } else {
                                        return NSOrderedDescending;
                                    }
                                }];
                                
                                //Animated move and set new a tag
                                [UIView beginAnimations:nil context:nil];
                                NSInteger iTag = 0;
                                for (LotteryCircle *lc in _grids){
                                    lc.tag = iTag++;
                                    if (lc != _movingItem){
                                        lc.frame = [self itemFrameWithIndex:lc.tag];
                                    }
                                }
                                [UIView commitAnimations];
                                break;
                        }
                    }
                }
            }
        }
            break;
        default:
            break;
    }
}

@end



@implementation LotterySouthView

- (void)dealloc{
    self.onLotteryGridClick = nil;
    [_grids release];
    [super dealloc];
}

- (void)update{
  
    NSInteger i = 0;
    for (i = 0; i < _grids.count; i++) {
        LotteryCircle *grid = [self gridButtonAtIndex:i];
        grid.tag = i;
        CDLottery *lot = (CDLottery *)grid.userData;
        grid.isNewLottery = lot.isNewLottery.boolValue;
        [grid setImage:ResImage(lot.logoHot) forState:UIControlStateNormal];
    }
    //Remove tails
    for (NSInteger j = i; j < _grids.count; j++) {
        LotteryCircle *grid = [self gridButtonAtIndex:i];
        [grid removeFromSuperview];
    }
    [_grids removeObjectsInRange:NSMakeRange(i, _grids.count-i)];
    
    CGFloat w = self.bounds.size.width/3, h = w;
    self.contentSize = CGSizeMake(self.bounds.size.width, ceilf(i/3.f)*h);
    self.clipsToBounds = YES;
    
    if (!_gridLayer){
        GridLayer *l = [[GridLayer alloc] init];
        _gridLayer = l;
        [self.layer insertSublayer:l atIndex:0];
        [l release];
    }
    _gridLayer.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    [(GridLayer *)_gridLayer displayAsRow:ceilf(i/3.f) andColumn:3];
}

- (LotteryCircle *)gridButtonAtIndex:(NSInteger)index{
    CGFloat w = self.bounds.size.width/3, h = w;
    LotteryCircle *grid = nil;
    if (index < _grids.count){  //reuse a exist one
        grid = [_grids objectAtIndex:index];
    } else {                    //create a new one
        grid = [LotteryCircle buttonWithType:UIButtonTypeCustom];
        [grid addTarget:self action:@selector(gridClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:grid];
        
        if (!_grids) _grids = [[NSMutableArray alloc] init];
        [_grids addObject:grid];
    }
    grid.frame = CGRectMake(index%3*w, index/3*h, w, h);
    return grid;
}

- (void)addLottery:(CDLottery *)lot{
    if (!_grids) _grids = [[NSMutableArray alloc] init];
    
    LotteryCircle *grid = [self gridButtonAtIndex:_grids.count];
    grid.style = kLotteryCircleStyleAdd;
    grid.isNewLottery = lot.isNewLottery.boolValue;
    grid.userData = lot;
    
    [self update];
}

- (void)addLotterys:(NSArray *)lots{
    for (id lot in lots){
        [self addLottery:lot];
    }
}

- (void)gridClick:(LotteryCircle *)sender{
    if (_onLotteryGridClick){
        CDLottery *lot = sender.userData;
        if (_onLotteryGridClick(lot)){
            
            [sender removeFromSuperview];
            [_grids removeObject:sender];
            
            [self update];
        }
        
    }
}

@end



@implementation LotteryCircle

- (void)dealloc{
    self.userData = nil;
    [super dealloc];
}

- (void)setStyle:(NSInteger)style{
    _style = style;
    if (!_cornerButton){
        _cornerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cornerButton.frame = CGRectMake(self.bounds.size.width-20, 0, 20, 20);
        _cornerButton.userInteractionEnabled = NO;
        [self addSubview:_cornerButton];
    }
    _cornerButton.hidden = NO;
    switch (style) {
        case kLotteryCircleStyleAdd:
            [_cornerButton setImage:ResImage(@"lot-add.png") forState:UIControlStateNormal];
            break;
        case kLotteryCircleStyleDelete:
            [_cornerButton setImage:ResImage(@"lot-delete.png") forState:UIControlStateNormal];
            break;
        case kLotteryCircleStyleDefault:
            _cornerButton.hidden = YES;
        default:
            break;
    }
}
-(void)setIsNewLottery:(BOOL)isNewLottery
{
    _isNewLottery = isNewLottery;
    if (_isNewLottery)
    {
        if (!_newImageView) {
            _newImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)] autorelease];
            _newImageView.backgroundColor=[UIColor clearColor];
            [self addSubview:_newImageView];
        }
        [_newImageView setImage:ResImage(@"new.png")];
    }else
    {
        [_newImageView setImage:ResImage(@"")];
    }
}
@end

