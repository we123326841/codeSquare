//
//  ShareManager.h
//  Caipiao
//
//  Created by danal-rich on 4/2/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface ShareManager : NSObject<UIActionSheetDelegate,
MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>
@property (copy, nonatomic) NSString *shareText;
@property (copy, nonatomic) NSString *link;

/**
 * Init with text and a url link to the article
 */
- (id)initWithText:(NSString *)text link:(NSString *)urlLink;

/**
 * Open the share list menu
 */
- (void)openShareList;

@end
