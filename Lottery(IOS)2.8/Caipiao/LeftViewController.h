//
//  LeftViewController.h
//  SideMenuController
//
//  Created by danal on 13-1-3.
//  Copyright (c) 2013年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RQLogin.h"
#import "UserHeaderView.h"

typedef enum {
    kMenuIndexTixian= -3,
    kMenuIndexChongzhi = -2,
    kMenuIndexHeader = -1,
    kMenuIndexHall = 0,
    kMenuIndexTransfer,
    kMenuIndexGame,
    kMenuIndexZhuiHao,
    kMenuIndexPublic,
    kMenuIndexTransacation,
    kMenuIndexInfo,
    kMenuIndexSetting,
    kMenuIndexSign,
    kMenuIndexMax,
    kMenuIndexAddUser,
    kMenuIndexUserList,
    kMenuIndexLinkOpen,
} MenuIndex;

#ifdef __LV__
@interface LeftViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,
RQBaseDelegate,UIActionSheetDelegate, UIAlertViewDelegate>
{
    NSIndexPath *_selectedIndexPath;
    UserType _userType;
    MenuIndex _lastMenuIndex;
}

@property (strong, nonatomic) UserHeaderView *userHeaderView;

- (void)reload:(UserType)userType;
- (void)activeMenuIndex:(MenuIndex)index;
- (void)swithToMenuIndex:(MenuIndex)index;
- (void)swithToMenuIndex:(MenuIndex)index andActiveViewController:(UIViewController *)controller;
- (void)traceEventWithTitle:(NSString *)title;

-(void)showSheet;
-(BOOL) needLogon:(NSString*) str;

@end
#else

@interface LeftViewController : UIViewController
- (void)swithToMenuIndex:(MenuIndex)index;
@end

#endif

