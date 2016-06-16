//
//  HomeViewController.h
//  Caipiao - 精彩推荐
//
//  Created by danal-rich on 7/17/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "BaseViewController.h"

@class OpenBallView, HotLotView;

@interface HomeViewController : BaseViewController
{
    IBOutlet UIView         *_wrapView;
    IBOutlet UIButton       *_menuButton;
    IBOutlet MSGallaryView  *_gallaryView;
    IBOutlet UIButton       *_customButton;
    IBOutlet UIView         *_hotView;
    IBOutlet HotLotView     *_hotLotView;
    IBOutlet UIView         *_openView;
    IBOutlet UILabel        *_openIssueLbl;
    IBOutlet OpenBallView   *_openBallView;
    IBOutlet UIView         *_userPanel;
    
    IBOutlet UILabel        *_nameLbl;
    IBOutlet UILabel        *_rewardLbl;
    IBOutlet UILabel        *_balanceLbl;
    IBOutlet UIImageView    *_vipIcon;
    
    IBOutlet BadgeIconButton *_msgButton;
    
    IBOutletCollection(UILabel) NSArray *_labels;
    IBOutletCollection(UILabel) NSArray *_lightLabels;
    
    BOOL _panelOpened;
}

- (IBAction)gotoBet:(id)sender;
- (IBAction)openPanel:(id)sender;
- (IBAction)panelButtonClick:(id)sender;
@end

@protocol HotLotViewDelegate <NSObject>
- (void)onHotLotViewGridClick:(HotLotView *)view atIndex:(NSInteger)index;
@end

@interface HotLotView : UIView {
    NSMutableArray *_grids;
}
@property (assign, nonatomic) id<HotLotViewDelegate> delegate;
@property (strong, nonatomic) NSArray *hotLotterys;

- (void)update;
- (NSInteger)plusGridIndex;

@end