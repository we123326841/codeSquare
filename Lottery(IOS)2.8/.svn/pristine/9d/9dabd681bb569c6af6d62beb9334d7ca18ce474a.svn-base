//
//  BetItem.m
//  Caipiao
//
//  Created by danal on 13-1-21.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import "BetItem.h"
#import "BetCell.h"

@interface BetItem ()
@end

@implementation BetItem
@synthesize ballCount = _ballCount;
@synthesize weight = _weight;
@synthesize numberFormat = _numberFormat;

- (void)dealloc{
    [_lastBall release];
    [_ballItems release];
    [_weight release];
    [_numberFormat release];
    [super dealloc];
}

- (id)init{
    self = [super init];
    if (self) {
        _type = kBetItemTypeNumber;
        _ballCount = MaxNumber;
    }
    return self;
}

- (id)initWithWeight:(NSString *)weight ballItems:(NSArray *)ballItems minimumBallCount:(int)minimum{
    self = [super init];
    if (self){
        self.weight = weight;
        self.ballItems = ballItems;
        _ballCount = [ballItems count];
        _minimumBallCount = minimum;
        _historyNumberList = [[NSMutableArray alloc] init];
    }
    return self;
}
- (id)initWithWeight:(NSString *)weight startBall:(int)startBall endBall:(int)endBall numberFormat:(NSString *)format minimumBallCount:(int)minimum maxBallCount:(int)maxCount
{
    self = [self initWithWeight:weight startBall:startBall endBall:endBall numberFormat:format minimumBallCount:minimum];
    self.maxBallCount = maxCount;
    return self;
}
- (id)initWithWeight:(NSString *)weight startBall:(int)startBall endBall:(int)endBall numberFormat:(NSString *)format minimumBallCount:(int)minimum{
    self = [super init];
    if (self){
        self.weight = weight;
        self.numberFormat = format;
        _startBall = startBall;
        _endBall = endBall;
        _ballCount = endBall - startBall + 1;
        _minimumBallCount = minimum;
        _historyNumberList = [[NSMutableArray alloc] init];
        
        NSMutableArray *ballItems = [NSMutableArray array];
        for (int i = startBall; i <= endBall; i++) {
            NSString *ball = format != nil ? [NSString stringWithFormat:format,i] : MSIntToStr(i);
            [ballItems addObject:[[[BallItem alloc] initWithStyle:kBallStyleDefault text:ball value:ball] autorelease]];
        }
        self.ballItems = ballItems;
    }
    return self;
}

- (void)onChanges:(BetItemOption)option{
    if ( _delegate ){
        if ([_delegate respondsToSelector:@selector(onBetItemChanges:option:)]){
            [_delegate onBetItemChanges:self option:option];
        }
    }
}

- (void)onChanges{
    [self onChanges:kBetItemOptionNone];
}

- (void)selectNumber:(NSUInteger)number{
    NSString *format = self.numberFormat ? self.numberFormat : @"%d";
    [self _selectNumber:[NSString stringWithFormat:format,number]];
}

- (void)deselectNumber:(NSUInteger)number{
    NSString *format = self.numberFormat ? self.numberFormat : @"%d";
    [self _deselectNumber:[NSString stringWithFormat:format,number]];
}

- (void)selectNumberS:(NSString *)number{
    //为了兼容整型number
    if ([number isKindOfClass:[NSString class]]){
        [self _selectNumber:number];
    } else {
            NSAssert(0, @"number is not a nsstring object!");
    }
    [self onChanges];
}

- (void)deselectNumberS:(NSString*)number{
    //为了兼容整型number
    if ([number isKindOfClass:[NSString class]]){
        [self _deselectNumber:number];
    } else {
        NSAssert(0, @"number is not a nsstring object!");
    }
    [self onChanges];
}

- (void)_selectNumber:(NSString *)number{
    //    if (number <= _endBall && number >= _startBall) {
    for (BallItem *one in self.ballItems){
        if ([one.value isEqualToString:number]){
            self.selectedBallCount++;
            [_lastBall release];
            _lastBall = [number copy];
            [self.attachedBetView selectBall:number];
            [_historyNumberList addObject:number];
            one.selected = YES;
            break;
        }
    }
    /*    if ([_numbers objectForKey:number]){
     [_lastBall release];
     _lastBall = [number copy];
     [_numbers setValue:@"1" forKey:number];
     [self.attachedBetView selectBall:number];
     
     _selectedBallCount++;
     [_historyNumberList addObject:number];
     }
     */
    //    }
}

- (void)_deselectNumber:(NSString *)number{
//    if (number <= _endBall && number >= _startBall) {
    for (BallItem *one in self.ballItems){
        if ([one.value isEqualToString:number]){
            one.selected = NO;
            self.selectedBallCount--;
            [self.attachedBetView deselectBall:number];
            for (int i = 0; i < [_historyNumberList count]; i++) {
                NSString *numberText = [_historyNumberList objectAtIndex:i];
                if ([numberText isEqualToString:number]){
                    [_historyNumberList removeObjectAtIndex:i];
                    break;
                }
            }
            break;
        }
    }
/*
    if ([_numbers objectForKey:number]){
        [_numbers setValue:@"0" forKey:number];
        [self.attachedBetView deselectBall:number];
        
        _selectedBallCount--;
        for (int i = 0; i < [_historyNumberList count]; i++) {
            NSString *numberText = [_historyNumberList objectAtIndex:i];
            if ([numberText isEqualToString:number]){
                [_historyNumberList removeObjectAtIndex:i];
                break;
            }
        }
    }
 */
//    }
}

- (void)manuallySelectNumber:(NSString *)number{
    [self _selectNumber:number];
    [self onChanges];
}

- (void)manuallyDeselectNumber:(NSString *)number{
    [self _deselectNumber:number];
    [self onChanges];
}

- (BOOL)numberSelected:(NSUInteger)number{
//    if (number <= _endBall) {
//        return [[_numbers objectForKey:MSIntToStr(number)] boolValue];
//    }
    NSString *strNumber = self.numberFormat ? [NSString stringWithFormat:self.numberFormat,number] : MSIntToStr(number);
    for (BallItem *one in self.ballItems){
        if ([one.value isEqualToString:strNumber]){
            return one.selected;
        }
    }
    return NO;
}

- (BOOL)numberSelectedS:(NSString *)numberText{
    for (BallItem *one in self.ballItems){
        if ([one.value isEqualToString:numberText]){
            return one.selected;
            break;
        }
    }
    return NO;
//    NSString *s = [_numbers objectForKey:numberText];
//    return s != nil ? [s boolValue] : NO;
}

- (void)reset{
    [self clear];
    [self onChanges];
}

- (void)selectAll{
    [self clear];
    NSString *format = self.numberFormat ? self.numberFormat : @"%d";
    for (int i = self.startBall; i <= self.endBall ;  i++) {
        [self _selectNumber:[NSString stringWithFormat:format,i]];
    }
    [self onChanges:kBetItemOptionQuan];
}

- (void)selectBig{
    [self clear];
    NSString *format = self.numberFormat ? self.numberFormat : @"%d";
   
//    for (int i = (self.endBall-self.startBall)/2+1; i <= self.endBall;  i++) {
//        [self _selectNumber:[NSString stringWithFormat:format,i]];
//    }
//    [self onChanges:kBetItemOptionDa];
    int  start = (self.endBall-self.startBall)/2 + ((self.endBall-self.startBall)%2?1:0);
    for (int i = self.startBall+start; i <= self.endBall;  i++) {
        [self _selectNumber:[NSString stringWithFormat:format,i]];
    }
    [self onChanges:kBetItemOptionDa];
}

- (void)selectSmall{
    [self clear];
    NSString *format = self.numberFormat ? self.numberFormat : @"%d";
//    for (int i = self.startBall; i < (self.endBall-self.startBall)/2+1;  i++) {
//        [self _selectNumber:[NSString stringWithFormat:format,i]];
//    }
//    [self onChanges:kBetItemOptionXiao];
    int  start = (self.endBall-self.startBall)/2 + ((self.endBall-self.startBall)%2?1:0);

    for (int i = self.startBall; i <self.startBall+start;  i++) {
        [self _selectNumber:[NSString stringWithFormat:format,i]];
    }
    [self onChanges:kBetItemOptionXiao];
}

- (void)selectOdd{
    [self clear];
    NSString *format = self.numberFormat ? self.numberFormat : @"%d";
    for (int i = 1; i <= self.endBall;  i+=2) {
        [self _selectNumber:[NSString stringWithFormat:format,i]];
    }
    [self onChanges:kBetItemOptionDan];
}

- (void)selectEven{
    [self clear];
    NSString *format = self.numberFormat ? self.numberFormat : @"%d";
    for (int i = self.startBall == 0 ? 0 : 2; i <= self.endBall;  i+=2) {
        [self _selectNumber:[NSString stringWithFormat:format,i]];
    }
    [self onChanges:kBetItemOptionShuang];
}

- (void)clear{
    for (BallItem *one in self.ballItems){
        one.selected = NO;
        [self.attachedBetView deselectBall:one.value];
    }

    [_historyNumberList removeAllObjects];
    self.selectedBallCount = 0;
}

//可传入需要排除的号码
- (NSArray *)randomNumbers:(int)count exceptedNumbers:(NSArray *)exceptedNumbers
{
    NSMutableArray *numbers = [NSMutableArray array];
    for (int i = 0; i < count; i++)
    {
        while (1)
        {
            BOOL added = NO;
            BallItem *ballItem  = [self.ballItems objectAtIndex:arc4random_uniform([self.ballItems count])];
            for (NSString *number in numbers)
            {
                if ([number isEqualToString:ballItem.value])
                {
                    added = YES;
                    break;      //added in, ignore it
                }
            }

            for (id number in exceptedNumbers)
            {
                if ([number isKindOfClass:[NSNumber class]] && [number intValue] == [ballItem.value intValue])
                {
                    added = YES;
                    break;      //excepted, ignore it
                }
                else if ([number isKindOfClass:[NSString class]] && [number isEqualToString:ballItem.value])
                {
                    added = YES;
                    break;      //excepted, ignore it
                }
            }
            
            if (added == NO) {  //then add in,and break the while loop,start next loop
                [numbers addObject:ballItem.value];
                break;
            }
        }
    }
    return [NSArray arrayWithArray:numbers];
}

- (void)random{
    [self clear];
    BallItem *ballItem = [self.ballItems objectAtIndex:arc4random_uniform([self.ballItems count])];
    [self _selectNumber:ballItem.value];
}

- (void)randomN:(int)count{
    [self randomN:count exceptedNumbers:nil];
}

- (void)randomN:(int)count exceptedNumbers:(NSArray *)exceptedNumbers{
    [self clear];
    NSArray *numbers = [self randomNumbers:count exceptedNumbers:exceptedNumbers];
    Echo(@"randomN:%@",[numbers componentsJoinedByString:@"-"]);
    for (int i = 0; i < [numbers count]; i++) {
        if (self.numberFormat){
            int n = [[numbers objectAtIndex:i] intValue];
            NSString *s = [NSString stringWithFormat:self.numberFormat,n];
            [self _selectNumber:s];
        } else {
            [self _selectNumber:[numbers objectAtIndex:i]];
        }
    }
}
//对于最多只能选择某个数量的BetItem 用这个去掉超出的选择
- (void)trimSelectionsToLength:(int)length{
    NSInteger count = [_historyNumberList count];
    if (count > length) {
        NSArray *numbers = [_historyNumberList subarrayWithRange:NSMakeRange(length, count - length)];
        for (NSInteger i = 0; i != [numbers count]; i++) {
            NSString *number = [numbers objectAtIndex:i];
            [self _deselectNumber:number];
        }
        [self onChanges];
    }
}



//格式化该位选的号码
- (NSString *)serialize{
    NSMutableString *str = [NSMutableString string];
    BOOL multi = NO;
//    for (int i = self.startBall; i <= self.endBall;  i++) {
    for (BallItem *ballItem in self.ballItems){
        if ([self numberSelectedS:ballItem.value]) {
//            NSString *format = multi == NO ? self.numberFormat : [NSString stringWithFormat:@"&%@",self.numberFormat];
//            [str appendFormat:format, i];
            if (!multi){
                [str appendString:ballItem.value];
            } else {
                [str appendFormat:@"&%@",ballItem.value];
            }
            multi = YES;
        }
    }
    return str;
}

- (int)count{
    return [self selectedBallCount];
}

- (void)compareTo:(BetItem *)another
          isEqual:(BOOL *)equ
      isIntersect:(BOOL *)intersect
        sameCount:(NSInteger *)sameCount
   differentCount:(NSInteger *)differentCount {
    
    int equCount = 0, count = 0, anotherCount = 0;
    for (int n = self.startBall; n <= self.endBall; n++) {
        
        if ([self numberSelected:n]) count++;
        if ([another numberSelected:n]) anotherCount++;
        if ([self numberSelected:n] && [another numberSelected:n]) equCount++;
    }
    
    if(equCount > 0 && equCount == count && equCount == anotherCount) {
        if (equ != NULL) *equ = YES;
    } else if(equCount > 0){
        if(intersect != NULL) *intersect = YES;
    }
    
    if (sameCount != NULL) *sameCount = equCount;                     //相同的数
    if(differentCount !=NULL ) *differentCount = count - equCount;     //与another中不同的数
}

+ (BetItem *)randomBetItem{
    //机选每位只选择一个号码？
    BetItem *item = [[[BetItem alloc] init] autorelease];
    [item random];
    return item;
}

+ (NSArray *)makeBetItemsForWeights:(NSArray *)weights{
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < [weights count]; i++) {
        BetItem *item = [[BetItem alloc] init];
        item.weight = [weights objectAtIndex:i];
        [items addObject:item];
        [item release];
    }
    return items;
}

+ (int)sameCountInBetItems:(NSArray *)items{
    int sameCount = 0;
    if ([items count] > 0){
        BetItem *first = [items objectAtIndex:0];
        for (int n = first.startBall; n <= first.endBall; n++) {
            int same = 1;
            for (BetItem *one in items){
                same *= (int)[one numberSelected:n];
            }
            if (same == 1) {
                sameCount++;
            }
            same = 1;
        }
    }
    return sameCount;
}

@end


@implementation BetItem (NSStringExtended)

- (void)selectNumberStr:(NSString *)numberStr{
    NSArray *numbers = [numberStr componentsSeparatedByString:@"&"];
    for (NSString *nStr in numbers){
        if ([nStr length] > 0)
            [self selectNumberS:nStr];
    }
}

- (NSArray *)selectedNumbers{
    NSMutableArray *numbers = [NSMutableArray array];
    /*
    for (int n = _startBall; n <= _endBall; n++) {
        if ([self numberSelected:n]){
            [numbers addObject:[NSNumber numberWithInt:n]];
        }
    }
     */
    for (BallItem *one in self.ballItems){
        if(one.selected){
            [numbers addObject:one.value];
        }
    }
    return numbers ;
}

@end