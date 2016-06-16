//
//  Label+Factory.h
//  Caipiao
//
//  Created by danal on 13-10-10.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YellowLabel : UILabel

@end

@interface RoundedBlackView : UIControl

@end

@interface InRectTextField : UIView

@property (strong, nonatomic) UITextField *textfield;
@property (strong, nonatomic) UIButton *clearButton;

+ (BOOL)isAvailableAmount:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

@interface YellowButton : UIButton

@end


@interface RoundedBlackTextField : UITextField
@property (nonatomic) BOOL enableClearButton;
@end

@interface YellowFrameTextField : UITextField

@end

@interface WhiteAlertView : UIView

@property (strong, nonatomic) UIImageView *bgView;
@property (strong, nonatomic) UIImageView *titleIcon;
@property (strong, nonatomic) UILabel *titleLbl;
@property (assign, nonatomic) UILabel *errorLbl;
@property (strong, nonatomic) UIButton *cancelButton;

+ (CGFloat)width;
+ (CGFloat)height;
- (id)initWithTitle:(NSString *)title titleIcon:(UIImage *)image contentView:(UIView *)contentView cancelButtonTitle:(NSString *)cancelButtonTitle;
- (id)initWithTitle:(NSString *)title titleIcon:(UIImage *)image contentView:(UIView *)contentView cancelButtonTitle:(NSString *)cancelButtonTitle isSingleButton:(BOOL)isSingleButton;
- (void)show;
- (void)dismiss;
- (void)addAlertButtonWithTitle:(NSString *)title
                          frame:(CGRect)rect
                         target:(id)target
                         action:(SEL)selector;

@end

@interface GreenAlertButton : UIButton

@end

@interface TiledImageView : UIView
@property (strong, nonatomic) UIImage *image;
@property (nonatomic) UIEdgeInsets edge;
@end

@interface RoundedNumberCluster : UIView

@property (assign, nonatomic) int count;
@property (assign, nonatomic) int ssqCount;

- (void)setNumber:(NSString *)number;
- (void)setSSQNumber:(NSString *)number;

@end

@interface YellowDropBox : UIView {
    CGFloat _height;
}

@property (assign, nonatomic) int selectedNumber;
@property (assign, nonatomic) BOOL isSelected;
@property (strong, nonatomic) UIButton *boxButton;
@property (assign, nonatomic) int startNumber;
@property (assign, nonatomic) int endNumber;
@property (copy, nonatomic) void(^selectNumberBlock)(YellowDropBox *dropBox, int number);

- (id)initWithFrame:(CGRect)frame startNumber:(int)sNum endNumber:(int)eNum;

@end


//TableView Cell
@interface Line : UIImageView
@end

enum {
    LineAtTop = 0,
    LineAtBottom = 1,
    LineAtTopAndBottom = 2,
};

@interface PlainCellView : UIView
@property (assign, nonatomic) NSInteger linePos;    //0-top, 1-bottom, 2-top&bottom
@property (strong, nonatomic) UIColor *lineColor;
@property (strong, nonatomic) UIImage *lineImage;
@end

@interface PlainCellViewBottom : PlainCellView
@end


@interface PlainCellViewBoth : PlainCellView
@end


@interface BadgeIconButton : UIButton
{
    UIButton *_badgeIcon;
}
@property (assign, nonatomic) NSInteger badge;
@property (assign, nonatomic) CGPoint badgeOffset;
@end


@interface GridLayer : CALayer {
    NSInteger _row, _col;
}
@property (nonatomic, strong) UIColor *gridColor;

- (void)displayAsRow:(NSInteger)numOfRow andColumn:(NSInteger)numOfCol;
@end

