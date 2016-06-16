//
//  LinkLabel.h
//  Musou
//
//  Created by luo danal on 8/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinkLabel : UILabel {
    NSMutableArray *_invocations;
}
@property (copy, nonatomic) NSString *url;

- (void)addTarget:(id)target action:(SEL)selector;
@end
