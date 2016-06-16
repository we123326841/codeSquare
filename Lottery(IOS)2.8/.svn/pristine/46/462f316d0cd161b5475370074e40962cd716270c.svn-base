//
//  ShareManager.m
//  Caipiao
//
//  Created by danal-rich on 4/2/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import "ShareManager.h"



@interface ShareManager ()
{
    BOOL _done;
}
@end

@implementation ShareManager


- (void)dealloc{
#ifdef DEBUG
    NSLog(@"%s",__func__);
#endif
    self.link = nil;
    self.shareText = nil;
    [super dealloc];
}


- (id)initWithText:(NSString *)text link:(NSString *)urlLink{
    self = [super init];
    if (self){
        self.shareText = text;
        self.link = urlLink ? urlLink : @"";
//        _done = NO;
//        [self performSelectorInBackground:@selector(loop:) withObject:nil];
    }
    return self;
}

- (void)loop:(id)sender{
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    } while (!_done);
}

- (void)openShareList{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"转发到"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"微信",@"短信",@"邮件",@"复制", nil];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    [sheet release];
}

//Private methods

- (void)shareToWeixin{
//    [[WXManager shared] sendLinkContent:self.shareText title:self.shareText thumb:[UIImage imageNamed:@"Icon@2x.png"] link:self.link scene:WXSceneSession];
    _done = YES;
}

- (void)shareToEmail{
    MFMailComposeViewController *controller = [[[MFMailComposeViewController alloc] init] autorelease];
    
    if([MFMailComposeViewController canSendMail])
    {
        [controller setSubject:nil];
        [controller setMessageBody:[self.shareText stringByAppendingFormat:@" %@",self.link] isHTML:NO];
        controller.mailComposeDelegate = self;
        [[AppDelegate sideMenuController] presentModalViewController:controller animated:YES];
    }

}

- (void)shareToSMS{
    
    if([MFMessageComposeViewController canSendText])
    {
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
        controller.body = [self.shareText stringByAppendingFormat:@" %@",self.link];
        controller.recipients = nil;
        controller.messageComposeDelegate = self;
        [[AppDelegate sideMenuController] presentModalViewController:controller animated:YES];
        [controller release];
    } else {
        _done = YES;
    }

}

- (void)shareToPasterBoard{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setValue:[self.shareText stringByAppendingFormat:@" %@",self.link] forPasteboardType:@"public.utf8-plain-text"];
    [HUDView showMessageToView:[UIApplication sharedApplication].keyWindow msg:@"已复制到系统剪切板" subtitle:nil];
    _done = YES;
}



#pragma mark -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self shareToWeixin];
            break;
        case 1:
            [self shareToSMS];
            break;
        case 2:
            [self shareToEmail];
            break;
        case 3:
            [self shareToPasterBoard];
            break;
        default:    //Cancel
             _done = YES;
            break;
    }
   
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [controller dismissViewControllerAnimated:YES completion:NULL];
     _done = YES;
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [controller dismissViewControllerAnimated:YES completion:NULL];
     _done = YES;
}

@end
