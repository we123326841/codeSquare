//
//  MSLoadingCell.h
//  Musou
//
//  Created by luo danal on 5/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define MSLoadingCellNotificationStartLoading @"LoadingCellNotificationStartLoading"
//#define MSLoadingCellNotificationFinishedLoading @"LoadingCellNotificationFinishedLoading"

typedef enum {
    MSLoadingCellTypeTapToLoad = 0,
    MSLoadingCellTypeAutoLoad,
    MSLoadingCellTypeReleaseToLoad
} MSLoadingCellType ;

typedef enum {
    MSLoadingCellStateNormal = 0,
    MSLoadingCellStateReadyToLoad,
    MSLoadingCellStateLoading
} MSLoadingCellState;

@protocol MSLoadingCellDelegate;

@interface MSLoadingCell : UITableViewCell
@property (assign,nonatomic) id<MSLoadingCellDelegate> delegate;
@property (nonatomic) MSLoadingCellType type;
@property (retain,nonatomic) UIActivityIndicatorView *indicator;
@property (retain,nonatomic) UIButton *tipButton;
@property (nonatomic) MSLoadingCellState state;

- (id)initWithType:(MSLoadingCellType)type reuseIdentifier:(NSString *)reuseIdentifier;

- (void)startLoad;

- (void)stopLoad;

@end


@protocol MSLoadingCellDelegate <NSObject>

- (void)loadingCellDidStartLoading:(MSLoadingCell *)cell;

@end