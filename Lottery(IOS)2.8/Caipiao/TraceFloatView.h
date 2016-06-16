//
//  TraceFloatView.h
//  Caipiao
//
//  Created by danal-rich on 8/13/14.
//  Copyright (c) 2014 yz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckBox.h"

@interface TraceFloatView : UIView {
    UIView  *_targetView;
    IBOutlet UILabel *_textLbl;
}
@property (assign, nonatomic) IBOutlet CheckBox *checkbox;

- (void)followTarget:(UIView *)targetView;
@end
